throwing                    = {}

throwing.arrows             = {}

local HIT_RADIUS = 4

local BASE_LIQUID_VISCOSITY = 50

local STEP = 4

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
	local entity = obj:get_luaentity()
	if entity then
		local ownvel = { x = 0, y = 0, z = 0 }
		local vec    = {}
		local v      = entity.velocity or 1 -- or set to default
		vec.x        = v * dir.x
		vec.y        = v * dir.y
		vec.z        = v * dir.z
		entity.switch   = 1
		if (owner.is_player and owner:is_player()) then
			entity.owner_id = owner:get_player_name() -- add unique owner id to arrow
			ownvel          = owner:get_player_velocity()
		else
			entity.owner_id = tostring(owner) -- add unique owner id to arrow
			ownvel          = owner:getvelocity() or ownvel
		end
		vec = { x = vec.x + ownvel.x, y = vec.y + ownvel.y, z = vec.z + ownvel.z }

		-- arrow velocity will be setted on first step
		entity.inited = false
		entity.launch_velocity = vec
		obj:setvelocity({ x = 0, y = 0, z = 0 })
		local yaw = 0
		if vec.x ~= 0 or vec.z ~= 0 then
			yaw = math.atan2(vec.z, vec.x)
		end
		obj:setyaw(yaw + math.pi)
		obj:setacceleration(acceleration(vec, entity.kfr, entity.mass))
		entity.owner = owner
		entity.launched = false
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
		--minetest.log("Hitting "..tostring(node))
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

local function hit_mob(mob, arrow, callback, owner_id)
	local entity = mob:get_luaentity() and mob:get_luaentity().name or ""


	if entity ~= "__builtin:item"
		and entity ~= "__builtin:falling_node"
		and entity ~= "gauges:hp_bar"
		and entity ~= "signs:text"
		and entity ~= "itemframes:item" then

		--minetest.log("Hitting "..tostring(entity))
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

local function hits_mob(pos, target_pos, colbox)
	if colbox == nil then
		return false
	end
	if pos.x - target_pos.x < colbox[1] or pos.y - target_pos.y < colbox[2] or pos.z - target_pos.z < colbox[3] then
		return false
	end
	if pos.x - target_pos.x > colbox[4] or pos.y - target_pos.y > colbox[5] or pos.z - target_pos.z > colbox[6] then
		return false
	end
	return true
end

local function hits_player(pos, target_pos, colbox)
	if colbox == nil then
		return false
	end
	if pos.x - target_pos.x < colbox[1] or pos.y - target_pos.y < colbox[2] + 1 or pos.z - target_pos.z < colbox[3] then
		return false
	end
	if pos.x - target_pos.x > colbox[4] or pos.y - target_pos.y > colbox[5] + 1 or pos.z - target_pos.z > colbox[6] then
		return false
	end
	return true
end

local function hit_players(self, lpos)
	local hit = false
	local lmobs = minetest.get_objects_inside_radius(lpos, HIT_RADIUS)
	local intersect_owner = false
	-- now check that arrow hits their collisionbox
	for _, player in pairs(lmobs) do
		if player == self.owner then
			intersect_owner = true
		end
		if player ~= self.object and (self.launched or self.owner ~= player) then
			if player:is_player() then
				local ppos = player:getpos()
				if hits_player(lpos, ppos, player:get_properties().collisionbox) then
					hit = hit_player(player, self, self.hit_player, self.owner_id) or hit
				end
			else
				local entity = player:get_luaentity()
				local ppos = player:getpos()
				if hits_mob(lpos, ppos, entity.collisionbox) then
					hit = hit_mob(player, self, self.hit_mob, self.owner_id) or hit
				end
			end
		end
	end
	if not self.launched and not intersect_owner then
		-- arrow has leaved player, who shoot
		self.launched = true
	end
	return hit
end


local function arrow_step(self, dtime)
	self.timer = self.timer + dtime

	local pos  = self.object:getpos()

	-- start arrow move
	if self.inited == false then
		self.inited = true
		self.object:setvelocity(self.launch_velocity)

		-- arrow sound
		-- TODO: should be on the all arrow path
		local fly_sound = self.definition.fly_sound
		if fly_sound and fly_sound.sound then
			minetest.sound_play(fly_sound.sound, {
				pos = pos,
				gain = 1.0,
				max_hear_distance = fly_sound.sound_distance or 5,
			})
		end
	end

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
	local vel = self.object:getvelocity()
	local vel_len = math.sqrt(vel.x*vel.x + vel.y*vel.y + vel.z*vel.z)
	local step_len = vel_len * dtime

	if vel_len > 0 then
		local dir = {x = vel.x/vel_len, y = vel.y/vel_len, z = vel.z/vel_len}

		for l = 0, (step_len * STEP) do
			local lpos = {x = pos.x + dir.x * l / STEP, y = pos.y + dir.y * l/STEP, z = pos.z + dir.z * l/STEP}

			local hit = hit_node(lpos, self, self.hit_node) or hit_players(self, lpos)

			if hit then
				res = true
				break
			else
				self.lastpos = lpos
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

