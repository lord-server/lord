local math_pi, math_arctan, math_sqrt
	= math.pi, math.atan2,  math.sqrt

local projectiles  = {}


-- Update projectile life timer
--- @param projectile LuaEntity  projectile entity
--- @param dtime      number     time passed from the last call
local function update_life_timer(projectile, dtime)
	if not projectile.timer_is_started then
		return
	end

	projectile.life_timer = projectile.life_timer - dtime

	if projectile.life_timer <= 0 then
		projectile.object:remove()
		return true
	end
	return false
end

-- Dealing the damage to the target
--- @param projectile LuaEntity  projectile entity
--- @param target     LuaEntity  target entity
--- @param damage     number     the amount of damage to deal
local function punch_target(projectile, target, damage)
	target:punch(projectile.shooter, 1.0, {
		full_punch_interval = 1.0,
		damage_groups       = {fleshy = damage},
	})
	projectile.object:remove()
end

--- @param entity LuaEntity  entity to check if it is a projectile
--- @return       boolean    true, if it is a projectile, or false
local function is_entity_projectile(entity)
	for _, reg in pairs(lord_bows.get_projectiles()) do
		if reg.entity_name == entity:get_luaentity().name then
			return true
		end
	end
	return false
end

-- Hit handling depending on target
--- @param projectile LuaEntity  projectile entity
--- @param target     LuaEntity  target entity
--- @param damage     number     the amount of damage to deal
local function hit_handling(projectile, target, damage)
	-- Hit player
	if target:is_player() then
		punch_target(projectile, target, damage)
	else
		-- Hit another projectile
		if is_entity_projectile(target) then
			projectile.object:set_acceleration({x = 0, y = GRAVITY * -1, z = 0})
			target:set_acceleration({x = 0, y = GRAVITY * -1, z = 0})

		-- Hit entity
		else
			punch_target(projectile, target, damage)
		end
	end
end

-- Collision handling
--- @param projectile  LuaEntity  projectile entity
--- @param move_result table      table with collision info
--- @param damage      number     the amount of damage to deal
local function collision_handling(projectile, move_result, damage)
	local vel = projectile.object:get_velocity()
	projectile.object:set_velocity({x = vel.x/15, y = vel.y/15, z = vel.z/15})

	if not move_result.collisions[1] then
		return
	end

	if move_result.collisions[1].type == "node" then
		local node_pos = move_result.collisions[1].node_pos
		local projectile_pos = projectile.object:get_pos()

		local dist = math_sqrt( (node_pos.x - projectile_pos.x)^2 +
			(node_pos.y - projectile_pos.y)^2 +
			(node_pos.z - projectile_pos.z)^2
		)

		if dist < 0.9 then
			projectile.object:set_velocity({x = 0, y = 0, z = 0})
			projectile.object:set_acceleration({x = 0, y = 0, z = 0})
			projectile.timer_is_started = true
		end
		return
	end
	projectile.object:set_velocity({x = 0, y = 0, z = 0})
	projectile.object:set_acceleration({x = 0, y = 0, z = 0})
	projectile.timer_is_started = true

	local target = move_result.collisions[1].object

	hit_handling(projectile, target, damage)
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

projectiles.register_projectile_type = function(name, item, def)
	-- Независящие от def параметры
	minetest.register_entity(name, {
		max_hp               = 1,
		physical             = true,
		collide_with_objects = true,
		pointable            = true, -- TODO: false
		use_texture_alpha    = true,
		visual_size          = {x = 1.5, y = 1.5, z = 1.5},
		visual               = "mesh",
		mesh                 = "projectile_arrow_type.obj",
		collisionbox         = {-0.15, -0.15, -0.15, 0.15, 0.15, 0.15},
		textures             = def.textures,
		life_timer           = 60,
		shooter              = {},
		timer_is_started       = false,
		on_step        = function(self, dtime, moveresult)
			if moveresult.collides or moveresult.standing_on_object then
				collision_handling(self, moveresult, def.damage)
			else
				flight_processing(self)
			end

			local pos = self.object:get_pos()

			if update_life_timer(self, dtime) then
				minetest.add_item(pos, item)
			end
		end,
		on_punch       = function(self, puncher)
			self.object:remove()
			minetest.give_or_drop(puncher, ItemStack(item))
		end,
		on_activate    = function(self, staticdata, dtime_s)
			if staticdata == "timer_is_started" then
				self.timer_is_started = true
			else
				return
			end
			update_life_timer(self, dtime_s)
		end,
		get_staticdata = function(self)
			if self.timer_is_started then
				return "timer_is_started"
			else
				return ""
			end
		end,
	})
end

return {
	projectiles = projectiles
}
