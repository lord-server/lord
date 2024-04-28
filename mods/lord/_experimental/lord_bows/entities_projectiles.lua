-- entities projectiles

projectiles  = {}
local pi     = math.pi
local arctan = math.atan2
local sqr    = math.sqrt

-- Обновление таймера жизни стрелы
local function update_life_timer(entity, dtime)
	if not entity.timer_is_start then
		return
	end

	entity.life_timer = entity.life_timer - dtime

	if entity.life_timer <= 0 then
		entity.object:remove()
	end
end

-- Нанесение урона цели
local function punch_target(entity, target, damage)
	target:punch(entity.shooter, 1.0, {
		full_punch_interval = 1.0,
		damage_groups       = {fleshy = damage},
	})
	entity.object:remove()
end

-- Обработка попадания взависимости от цели
local function hit_handling(entity, target, name, def)
	-- Попадание по игроку
	if target:is_player() then
		punch_target(entity, target, def.damage)
	else
		--Столкновение двух стрел
		if target:get_luaentity().name == name then
			entity.object:set_acceleration({x = 0, y = GRAVITY * -1, z = 0})
			target:set_acceleration({x = 0, y = GRAVITY * -1, z = 0})
			-- Попадание по сущности
		else
			punch_target(entity, target, def.damage)
		end
	end
end

-- Обработка столкновения
local function collision_handling(entity, move_result, name, def)
	local vel = entity.object:get_velocity()
	entity.object:set_velocity({x = vel.x/15, y = vel.y/15, z = vel.z/15})

	if not move_result.collisions[1] then
		return
	end

	if move_result.collisions[1].type == "node" then
		local node_pos = move_result.collisions[1].node_pos
		local arrow_pos = entity.object:get_pos()

		local dist = sqr( (node_pos.x - arrow_pos.x)^2 +
			(node_pos.y - arrow_pos.y)^2 +
			(node_pos.z - arrow_pos.z)^2
		)

		if dist < 0.9 then
			entity.object:set_velocity({x = 0, y = 0, z = 0})
			entity.object:set_acceleration({x = 0, y = 0, z = 0})
			entity.timer_is_start = true
		end
		return
	end
	entity.object:set_velocity({x = 0, y = 0, z = 0})
	entity.object:set_acceleration({x = 0, y = 0, z = 0})
	entity.timer_is_start = true

	local target = move_result.collisions[1].object

	hit_handling(entity, target, name, def)
end

local function flight_processing(entity)
	local vel = entity.object:get_velocity()
	if vel.y ~= 0 then
		local rot = {
			x = 0,
			y = pi + arctan(vel.z, vel.x),
			z = arctan(vel.y, sqr(vel.z * vel.z + vel.x * vel.x))}
		entity.object:set_rotation(rot)
	end
end

projectiles.register_projectile_arrow_type = function(name, item, def)
	-- Независящие от def параметры
	minetest.register_entity(name, {
		max_hp               = 1,
		physical             = true,
		collide_with_objects = true,
		pointable            = true, -- Потом изменить на false
		use_texture_alpha    = true,
		visual_size          = {x = 1.5, y = 1.5, z = 1.5},
		visual               = "mesh",
		mesh                 = "projectile_arrow_type.obj",
		collisionbox         = {-0.15, -0.15, -0.15, 0.15, 0.15, 0.15},

		-- Таймер жизни:
		life_timer           = 10,
		timer_is_start       = false,

		-- Стрелок
		shooter              = {},

		-- Зависящие от def параметры
		textures             = def.textures,

		-- Функции
		on_step              = function(self, dtime, moveresult)

			if moveresult.collides or moveresult.standing_on_object then
				collision_handling(self, moveresult, name, def)
			else
				flight_processing(self)
			end

			update_life_timer(self, dtime)
		end,

		on_rightclick        = function(self, clicker)
			local pos = self.object:get_pos()
			self.object:remove()
			minetest.add_item(pos, item)
		end,

		on_activate = function(self, staticdata, dtime_s)
			if staticdata == "timer_is_start" then
				self.timer_is_start = true
			else
				return
			end
			update_life_timer(self, dtime_s)
		end,

		get_staticdata = function(self)
			if self.timer_is_start then
				return "timer_is_start"
			else
				return ""
			end
		end,
	})
end
