throwing                    = {}

throwing.arrows             = {}

local BASE_LIQUID_VISCOSITY = 50

local function node_ok(pos, fallback)
	fallback   = fallback or "default:dirt"
	local node = minetest.get_node_or_nil(pos)
	if not node then
		return minetest.registered_nodes[fallback]
	end
	if minetest.registered_nodes[node.name] then
		return node
	end
	return minetest.registered_nodes[fallback]
end

function throwing:arrow_type(arrow_name)
	if throwing.arrows[arrow_name] ~= nil then
		return throwing.arrows[arrow_name].arrow_type or "none"
	else
		return "none"
	end
end

local function acceleration(velocity, k, mass)
	if mass == nil or mass == 0.0 then
		return { x = 0.0, y = 0.0, z = 0.0 }
	end
	if k == nil or k == 0 then
		return { x = 0.0, y = -9.81, z = 0.0 }
	end
	return { x = -velocity.x * k, y = -9.81 - velocity.y * k, z = -velocity.z * k }
end

function throwing:shoot(owner, arrow_name, pos, dir, distance)
	local dl  = (dir.x ^ 2 + dir.y ^ 2 + dir.z ^ 2) ^ 0.5;
	dir.x     = dir.x / dl
	dir.y     = dir.y / dl
	dir.z     = dir.z / dl

	pos.x     = pos.x + dir.x * distance
	pos.y     = pos.y + dir.y * distance
	pos.z     = pos.z + dir.z * distance

	--minetest.log("action", "pos = "..pos.x.." "..pos.y.." "..pos.z)

	local obj = minetest.add_entity(pos, arrow_name)
	obj:set_armor_groups({ immortal = 1 })
	local ent = obj:get_luaentity()
	if ent then
		local ownvel = { x = 0, y = 0, z = 0 }
		local vec    = {}
		local v      = ent.velocity or 1 -- or set to default
		vec.x        = v * dir.x
		vec.y        = v * dir.y
		vec.z        = v * dir.z
		ent.switch   = 1
		if (owner.is_player and owner:is_player()) then
			ent.owner_id = owner:get_player_name() -- add unique owner id to arrow
			ownvel       = owner:get_player_velocity()
		else
			ent.owner_id = tostring(owner) -- add unique owner id to arrow
			ownvel       = owner:getvelocity() or ownvel
		end
		vec = { x = vec.x + ownvel.x, y = vec.y + ownvel.y, z = vec.z + ownvel.z }
		obj:setvelocity(vec)
		local yaw = 0
		if vec.x ~= 0 or vec.z ~= 0 then
			yaw = math.atan2(vec.z, vec.x)
		end
		obj:setyaw(yaw + math.pi)
		obj:setacceleration(acceleration(vec, ent.kfr, ent.mass))
		ent.owner = owner
		ent.launched = false
	end
	return true
end

local function calculate_damage(arrow)
	local v      = arrow.object:get_velocity()
	local v2     = v.x ^ 2 + v.y ^ 2 + v.z ^ 2

	local dc     = arrow.definition.damage_coefficient or 0.1
	local mass   = arrow.definition.mass or 0
	local damage = mass * v2 / 2 * dc
	--minetest.log("action", "damage = "..tostring(damage))
	return damage
end

local function hit_node(pos, arrow, callback)
	local node = node_ok(pos).name
	if minetest.registered_nodes[node].walkable then
		if callback then
			callback(arrow, pos, node)
		end
		if arrow.drop == true then
			pos.y         = pos.y + 1
			arrow.lastpos = (arrow.lastpos or pos)
			minetest.add_item(arrow.lastpos, arrow.object:get_luaentity().name)
		end
		return true
	end
	return false
end

local function hit_player(player, arrow, callback, owner_id)
	if player:get_player_name() ~= owner_id then
		if callback then
			callback(arrow, player)
		end
		local s   = arrow.object:getpos()
		local p   = player:getpos()
		local vec = { x = s.x - p.x, y = s.y - p.y, z = s.z - p.z }

		player:punch(arrow.owner, 1.0, {
			full_punch_interval = 1.0,
			damage_groups       = { fleshy = calculate_damage(arrow) },
		}, vec)

		return true
	end
	return false
end

local function hit_mob(mob, arrow, callback, owner_id)
	local entity = mob:get_luaentity() and mob:get_luaentity().name or ""

	if tostring(mob) ~= owner_id
		and entity ~= "__builtin:item"
		and entity ~= "__builtin:falling_node"
		and entity ~= "gauges:hp_bar"
		and entity ~= "signs:text"
		and entity ~= "itemframes:item" then
		if callback then
			callback(arrow, mob)
		end
		local s   = arrow.object:getpos()
		local p   = mob:getpos()
		local vec = { x = s.x - p.x, y = s.y - p.y, z = s.z - p.z }

		mob:punch(arrow.owner, 1.0, {
			full_punch_interval = 1.0,
			damage_groups       = { fleshy = calculate_damage(arrow) },
		}, vec)

		return true
	end
	return false
end

local function arrow_on_punch(arrow, puncher, time_from_last_punch, tool_capabilities, dir)
	if arrow.can_drop_on_punch and
		(arrow:can_drop_on_punch(puncher, time_from_last_punch, tool_capabilities, dir) == false)
	then
		return
	end
	local pos     = arrow.object:getpos()
	pos.y         = pos.y + 1
	arrow.lastpos = (arrow.lastpos or pos)
	minetest.add_item(arrow.lastpos, arrow.object:get_luaentity().name)
	arrow.object:remove()
end

local function arrow_step(self, dtime)
	self.timer = self.timer + dtime

	local pos  = self.object:getpos()

	if self.switch == 0
		or self.timer > self.ttl
		or not within_limits(pos, 0) then
		self.object:remove(); -- print ("removed arrow")
		return
	end

	-- does arrow have a tail (fireball)
	if self.definition.tail
		and self.definition.tail == 1
		and self.definition.tail_texture then
		minetest.add_particle({
			pos                = pos,
			velocity           = { x = 0, y = 0, z = 0 },
			acceleration       = { x = 0, y = 0, z = 0 },
			expirationtime     = self.definition.expire or 0.25,
			collisiondetection = false,
			texture            = self.definition.tail_texture,
			size               = self.definition.tail_size or 5,
			glow               = self.definition.glow or 0,
		})
	end

	local res = false
	local mobs = {}
	local vel = self.object:getvelocity()
	local vel_len = math.sqrt(vel.x*vel.x + vel.y*vel.y + vel.z*vel.z)
	local step_len = vel_len * dtime
	if vel_len > 0 then
		local dir = {x = vel.x/vel_len, y = vel.y/vel_len, z = vel.z/vel_len}
		local res_node = false
		for l = 0, (step_len * 2) do
			local lpos = {x = pos.x + dir.x * l / 2, y = pos.y + dir.y * l/2, z = pos.z + dir.z * l/2}

			-- hit node
			-- hit only first node
			res_node = res_node or hit_node(lpos, self, self.hit_node)

			-- hit players
			local lmobs = minetest.get_objects_inside_radius(lpos, 1.0)
			for _, player in pairs(lmobs) do
				mobs[player] = true
			end
		end
		res = res_node or res
	else
		-- hit node
		res = hit_node(pos, self, self.hit_node) or res

		-- hit players
		local lmobs = minetest.get_objects_inside_radius(pos, 1.0)
		for _, player in pairs(lmobs) do
			mobs[player] = true
		end
	end

	if mobs[self.object] == nil
	then
		-- arrow has leaved player, who shoot
		self.launched = true
	end

	for player, _ in pairs(mobs) do
		if player ~= self.object or self.launched then
			if player:is_player() then
				res = hit_player(player, self, self.hit_player, self.owner_id) or res
			else
				res = hit_mob(player, self, self.hit_mob, self.owner_id) or res
			end
		end
	end

	if res == true then
		self.object:remove();
	else
		local k    = self.k
		local node = minetest.registered_nodes[minetest.get_node(pos).name]
		if node and node.liquid_viscosity then
			k = k * BASE_LIQUID_VISCOSITY * node.liquid_viscosity
		end
		local acc = acceleration(vel, k, self.definition.mass)
		self.object:setacceleration(acc)
	end
	self.lastpos = pos
end


-- register arrow for shoot attack
function throwing:register_arrow(name, def)

	if not name or not def then return end -- errorcheck

	local dop = def.drop_on_punch
	if dop == nil then
		dop = def.drop
	end
	if dop == nil then
		dop = false
	end

	local k               = def.kfr and def.mass and def.mass > 0 and def.kfr / def.mass or 0

	throwing.arrows[name] = def
	minetest.register_entity(name, {
		definition                  = def,
		ttl                         = def.ttl or 150,
		physical                    = false,
		visual                      = def.visual,
		visual_size                 = def.visual_size,
		textures                    = def.textures,
		velocity                    = def.velocity,
		mass                        = def.mass or 0,
		k                           = k,
		hit_player                  = def.hit_player,
		hit_node                    = def.hit_node,
		hit_mob                     = def.hit_mob,
		drop                        = def.drop or false, -- drops arrow as registered item when true
		drop_on_punch               = dop, -- drops arrow as registered item when true
		can_drop_on_punch           = def.can_drop_on_punch,
		collisionbox                = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 }, -- remove box around arrows
		timer                       = 0,
		switch                      = 0,
		owner_id                    = def.owner_id,
		rotate                      = def.rotate,
		automatic_face_movement_dir = def.rotate and (def.rotate - (math.pi / 180)) or false,

		on_step                     = def.on_step or arrow_step,
		on_punch                    = dop and (def.on_punch or arrow_on_punch) or nil,
	})
end

