local math_pi, math_arctan, math_sqrt
	= math.pi, math.atan2,  math.sqrt


-- Update projectile life timer
--- @param projectile LuaEntity  projectile entity
--- @param dtime      number     time passed from the last call
local function update_life_timer(projectile, dtime)
	if not projectile._timer_is_started then
		return
	end

	projectile._life_timer = projectile._life_timer - dtime

	if projectile._life_timer <= 0 then
		projectile.object:remove()
		return true
	end
	return false
end

-- Dealing the damage to the target
--- @param projectile    LuaEntity  projectile entity
--- @param target        LuaEntity  target entity
--- @param damage_groups table      damage groups table
--- @param multipliers   table      damage multiplier table
local function punch_target(projectile, target, damage_groups, remove_after_punch, multipliers)
	if remove_after_punch == nil then
		remove_after_punch = true
	end

	local multiplied = table.multiply_each_value(damage_groups, multipliers)

	local new_damage_groups = table.map(multiplied, function(value)
		if type(value) ~= "number" then
			return value
		end
		return math.ceil(value)
	end)
	minetest.chat_send_all(dump(damage_groups))
	minetest.chat_send_all(dump(new_damage_groups))
	target:punch(projectile.object, 1.4, {
		full_punch_interval = 1.4,
		damage_groups       = new_damage_groups,
	})

	if remove_after_punch == true then
		projectile.object:remove()
	end
end

--- @param entity LuaEntity  entity to check if it is a projectile
--- @return       boolean    true, if it is a projectile, or false
local function is_entity_projectile(entity)
	local registered_projectiles = projectiles.get_projectiles()
	for _, reg in pairs(registered_projectiles) do
		if reg.entity_name == entity:get_luaentity().name then
			return true
		end
	end
	return false
end

local function play_sound_on_hit(entity, hit_thing)
	if not entity._time_from_last_hit or
			(entity._time_from_last_hit > 1 and
			(not entity._sound_played_times or entity._sound_played_times < 5)) then
		entity._time_from_last_hit = 0
		entity._sound_played_times = (entity._sound_played_times or 0) + 1
		minetest.sound_play(entity["_sound_hit_"..hit_thing], {object = entity.object})
	end
end

-- Hit handling depending on target
--- @param projectile    LuaEntity  projectile entity
--- @param target        LuaEntity  target entity
--- @param damage_groups table      damage groups table (see Minetest API)
--- @param velocity      vector     projectile velocity
local function hit_handling(projectile, target, damage_groups, velocity)
	local function hit()
		local damage = (vector.length(velocity)/GRAVITY)^(1/2)
		punch_target(projectile, target, damage_groups, true, { fleshy = damage })
	end
	-- Hit player
	if target:is_player() then
		play_sound_on_hit(projectile, "object")
		hit()
	else
		-- Hit another projectile
		if is_entity_projectile(target) then
			projectile.object:set_acceleration({x = 0, y = GRAVITY * -1, z = 0})
			target:set_acceleration({x = 0, y = GRAVITY * -1, z = 0})
			play_sound_on_hit(projectile, "object")
		-- Hit entity
		else
			play_sound_on_hit(projectile, "object")
			hit()
		end
	end
end

-- Collision handling
--- @param projectile    LuaEntity  projectile entity
--- @param move_result   table      table with collision info
--- @param damage_groups table      damage groups table (see Minetest API)
local function collision_handling(projectile, move_result, damage_groups)
	local vel = projectile.object:get_velocity()

	if not move_result.collisions[1] then
		return
	end

	if move_result.collisions[1].type == "node" then
		play_sound_on_hit(projectile, "node")
		local node_pos = move_result.collisions[1].node_pos
		local projectile_pos = projectile.object:get_pos()

		local dist = math_sqrt( (node_pos.x - projectile_pos.x)^2 +
			(node_pos.y - projectile_pos.y)^2 +
			(node_pos.z - projectile_pos.z)^2
		)

		if dist < 0.9 then
			projectile.object:set_velocity({x = 0, y = 0, z = 0})
			projectile.object:set_acceleration({x = 0, y = 0, z = 0})
			projectile._timer_is_started = true
		end
		return
	end
	projectile.object:set_velocity({x = 0, y = 0, z = 0})
	projectile.object:set_acceleration({x = 0, y = 0, z = 0})
	projectile._timer_is_started = true

	local target = move_result.collisions[1].object

	hit_handling(projectile, target, damage_groups, vel)
end


--- @param projectile LuaEntity  projectile entity
local function flight_processing(projectile, environment)
	local vel = projectile.object:get_velocity()
	if vel.y ~= 0 then
		math.randomseed(os.clock())
		if environment == "water" then
			minetest.add_particlespawner({
				attached = projectile.object,
				size = { min = 2, max = 4.5 },
				pos = {
					min = vector.new(-0.5, -0.5, -0.5),
					max = vector.new( 0.5,  0.5,  0.5),
					-- when `bias` is 0, all random values are exactly as likely as any
				},
				texture = "projectiles_trajectory_"..environment.."_particle.png",
			})
		else
			minetest.add_particlespawner({
				attached = projectile.object,
				texture = "projectiles_trajectory_"..environment.."_particle.png",
			})
		end
		local rot = {
			x = 0,
			y = math_pi + math_arctan(vel.z, vel.x),
			z = math_arctan(vel.y, math_sqrt(vel.z * vel.z + vel.x * vel.x))}
			projectile.object:set_rotation(rot)
	end
end

local register_projectile_entity = function(name, item, entity_reg)
	local initial_properties = {
		hp_max                 = 1,
		physical               = true,
		collide_with_objects   = true,
		collisionbox           = {-0.15, -0.15, -0.15, 0.15, 0.15, 0.15},
		selectionbox           = {-0.15, -0.15, -0.15, 0.15, 0.15, 0.15},
		pointable              = true,
		visual                 = "item",
		visual_size            = {x = 1.5, y = 1.5, z = 1.5},
		use_texture_alpha      = true,
	}
	minetest.register_entity(name, {
		initial_properties = table.merge(initial_properties, entity_reg.initial_properties),
		_life_timer         = entity_reg.life_timer or 90,
		_shooter            = nil,
		_timer_is_started   = false,
		_collision_count    = 0,
		_sound_hit_node     = entity_reg.sound_hit_node,
		_sound_hit_object   = entity_reg.sound_hit_object,
		on_step        = function(self, dtime, moveresult)
			if self._time_from_last_hit and self._life_timer > 0  then
				self._time_from_last_hit = self._time_from_last_hit + dtime
			end

			local pos         = self.object:get_pos()
			local node_groups = minetest.registered_nodes[core.get_node(pos).name].groups
			local environment = "normal"
			if node_groups.water ~= nil then
				environment = "water"
			end

			core.emerge_area(vector.subtract(pos, 8), vector.add(pos, 8))

			if (vector.length(self.object:get_velocity()) > 0 and moveresult.collides) or moveresult.standing_on_object then
				self:_on_collision(moveresult)
			elseif vector.length(self.object:get_velocity()) > 0 then
				flight_processing(self, environment)
			end


			if update_life_timer(self, dtime) then
				minetest.add_item(pos, item)
			end
		end,
		on_punch       = function(self, puncher)
			if vector.length(self.object:get_velocity()) > 0 or self._shooter ~= puncher then
				return
			end
			self.object:remove()
			local item_to_give = ItemStack(item)
			if self._throwable_item then
				item_to_give = self._throwable_item
			end
			minetest.chat_send_all(dump(item_to_give))
			minetest.give_or_drop(puncher, item_to_give)
		end,
		on_activate    = function(self, staticdata, dtime_s)
			if staticdata == "_timer_is_started" then
				self._timer_is_started = true
			else
				return
			end
			update_life_timer(self, dtime_s)
		end,
		get_staticdata = function(self)
			if self._timer_is_started then
				return "_timer_is_started"
			else
				return ""
			end
		end,
		_on_collision  = function(self, moveresult)
			self._collision_count = self._collision_count + 1
			if entity_reg.on_collision and type(entity_reg.on_collision) == "function" then
				entity_reg.on_collision()
			end
			local pos = self.object:get_pos()
			collision_handling(self, moveresult, entity_reg.damage_groups)
			if self._collision_count >= 10 then
				self.object:remove()
				if self._shooter and self._shooter:is_player() then
					minetest.add_item(pos, ItemStack(item))
				end
			end
		end
	})
end

return {
	register_projectile_entity = register_projectile_entity,
}
