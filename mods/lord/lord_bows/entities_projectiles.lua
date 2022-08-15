-- entities projectiles
-- Прямиком с lord2

-- acceleration of gravity
local GRAVITY = 10

projectiles = {}

function update_life_timer(self, dtime)
	if not self.timer_is_start then return end

	self.life_timer = self.life_timer - dtime

	if self.life_timer <= 0 then
		self.object:remove()
	end
end

projectiles.register_projectile_arrow_type = function(name, item, def)
	-- Независящие от def параметры
	minetest.register_entity(name, {
		max_hp = 1,
		physical = true,
		collide_with_objects = true,
		pointable = true, -- Потом изменить на false
		use_texture_alpha = true,
		visual_size = {x = 1.5, y = 1.5, z = 1.5},
		visual = "mesh",
		mesh = "projectile_arrow_type.obj",
		collisionbox = {-0.15, -0.15, -0.15, 0.15, 0.15, 0.15},

		-- Таймер жизни:
		life_timer = 20,
		timer_is_start = false,

		-- Зависящие от def параметры
		textures = def.textures,

		-- Функции
		on_step = function(self, dtime, moveresult)

			if moveresult.collides or moveresult.standing_on_object then
				self.object:set_velocity({x = 0, y = 0, z = 0})
				self.object:set_acceleration({x = 0, y = 0, z = 0})

				self.timer_is_start = true

				if not moveresult.collisions[1] then return end
				if moveresult.collisions[1].type == "node" then return end

				local target = moveresult.collisions[1].object

				if target:is_player() then
					target:punch(self.object, 1.0, {
							full_punch_interval = 1.0,
							damage_groups = {fleshy = def.damage},
						},
						nil)
					self.object:remove()
				else
					if target:get_luaentity().name == name then
						self.object:set_acceleration({x = 0, y = GRAVITY*-1, z = 0})
						target:set_acceleration({x = 0, y = GRAVITY*-1, z = 0})
					elseif	target:get_luaentity().name == "__builtin:item"
						and target:get_luaentity().name == "__builtin:falling_node"
						and target:get_luaentity().name == "gauges:hp_bar"
						and target:get_luaentity().name == "signs:text"
						and target:get_luaentity().name == "itemframes:item" then return
					else
						target:punch(self.object, 1.0, {
							full_punch_interval = 1.0,
							damage_groups = {fleshy = def.damage},
						})
						self.object:remove()
					end
				end
			else
				local vel = self.object:get_velocity()
				if vel.y ~= 0 then
					local rot = {
						x = 0,
						y = math.pi + math.atan2(vel.z, vel.x),
						z = math.atan2(vel.y, math.sqrt(vel.z*vel.z+vel.x*vel.x))}
					self.object:set_rotation(rot)
				end
			end

			-- Обновление таймера жизни
			update_life_timer(self, dtime)
		end,

		on_rightclick = function(self, clicker)
			local pos = self.object:get_pos()
			self.object:remove()
			minetest.add_item(pos, item)
		end,
	})
end
