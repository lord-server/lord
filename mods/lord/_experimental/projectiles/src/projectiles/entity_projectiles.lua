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
-- ._shooter
	target:punch(projectile.object, 1.0, {
		full_punch_interval = 1.0,
		damage_groups       = table.multiply_each_value(damage_groups, multipliers),
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
	local speed = vector.length(velocity)/GRAVITY
	minetest.chat_send_all("Speed: "..speed)
	-- Hit player
	if target:is_player() then
		play_sound_on_hit(projectile, "object")
		punch_target(projectile, target, damage_groups, true, { fleshy = speed })
	else
		-- Hit another projectile
		if is_entity_projectile(target) then
			projectile.object:set_acceleration({x = 0, y = GRAVITY * -1, z = 0})
			target:set_acceleration({x = 0, y = GRAVITY * -1, z = 0})

		-- Hit entity
		else
			play_sound_on_hit(projectile, "object")
			punch_target(projectile, target, damage_groups, true, { fleshy = speed })
		end
	end
end

-- Collision handling
--- @param projectile    LuaEntity  projectile entity
--- @param move_result   table      table with collision info
--- @param damage_groups table      damage groups table (see Minetest API)
local function collision_handling(projectile, move_result, damage_groups)
	local vel = projectile.object:get_velocity()
	--local acc = projectile.object:get_acceleration()
	--projectile.object:set_velocity({x = vel.x/15, y = vel.y/15, z = vel.z/15})

	if not move_result.collisions[1] then
		return
	end

	if move_result.collisions[1].type == "node" then
		minetest.chat_send_all("Speed: "..vector.length(vel)/GRAVITY)
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
local function flight_processing(projectile)
	local vel = projectile.object:get_velocity()
	if vel.y ~= 0 then
		minetest.add_particle({
			pos = projectile.object:get_pos(),
			texture = "lord_bows_trajectory_particle.png",
		})
		local rot = {
			x = 0,
			y = math_pi + math_arctan(vel.z, vel.x),
			z = math_arctan(vel.y, math_sqrt(vel.z * vel.z + vel.x * vel.x))}
			projectile.object:set_rotation(rot)
	end
end

local register_projectile_entity = function(name, item, reg)
	minetest.register_entity(name, {
		initial_properties = {
			hp_max                 = 1,
			physical               = true,
			collide_with_objects   = true,
			collisionbox           = {-0.15, -0.15, -0.15, 0.15, 0.15, 0.15},
			selectionbox           = {-0.15, -0.15, -0.15, 0.15, 0.15, 0.15},
			pointable              = reg.pointable or true,
			visual                 = reg.visual,
			visual_size            = reg.visual_size or {x = 1.5, y = 1.5, z = 1.5},
			mesh                   = reg.mesh,
			textures               = reg.textures,
			colors                 = reg.colors,
			use_texture_alpha      = true,
			spritediv              = reg.spritediv,
			initial_sprite_basepos = reg.initial_sprite_basepos,
			glow                   = reg.glow,
		},
		_life_timer         = reg.life_timer or 90,
		_shooter            = {},
		_timer_is_started   = false,
		_sound_hit_node     = reg.sound_hit_node,
		_sound_hit_object   = reg.sound_hit_object,
		on_step        = function(self, dtime, moveresult)
			if self._time_from_last_hit and self._life_timer > 0  then
				self._time_from_last_hit = self._time_from_last_hit + dtime
			end
			if (vector.length(self.object:get_velocity()) > 0 and moveresult.collides) or moveresult.standing_on_object then
				minetest.chat_send_all(dump(moveresult))
				minetest.chat_send_all("collide: "..tostring(moveresult.collides))
				minetest.chat_send_all("stand: "..tostring(moveresult.standing_on_object))
				collision_handling(self, moveresult, reg.damage_groups)
			elseif vector.length(self.object:get_velocity()) > 0 then
				minetest.chat_send_all(vector.length(self.object:get_velocity()))
				flight_processing(self)
			end

			local pos = self.object:get_pos()

			if update_life_timer(self, dtime) then
				minetest.add_item(pos, item)
			end
		end,
		on_punch       = function(self, puncher)
			if vector.length(self.object:get_velocity()) > 0 or self._shooter ~= puncher then
				return
			end
			self.object:remove()
			minetest.give_or_drop(puncher, ItemStack(item))
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
	})
end

return {
	register_projectile_entity = register_projectile_entity,
}
