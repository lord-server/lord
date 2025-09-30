local math_pi, math_arctan, math_sqrt
	= math.pi, math.atan2,  math.sqrt

--- @alias projectiles.Entity.RotationType "pointed"|"rolling"

--- @class projectiles.Entity.LuaEntity
--- @field _collision_count      integer
--- @field _life_timer           number
--- @field _projectile_stack     ItemStack
--- @field _rotation_formula     projectiles.Entity.RotationType
--- @field _shooter              ObjectRef|Player|Entity
--- @field _sound_played_times   integer
--- @field _time_from_last_hit   number
--- @field _timer_is_started     boolean
--- @field _remove_on_object_hit boolean
--- @field object                Entity

--- @class projectiles.Entity.StaticData
--- @field _timer_is_started boolean
--- @field _projectile_stack table

--- @class projectiles.Entity.Definition
--- @field initial_properties   { visual: string, wield_item: string, visual_size: Position }
--- @field max_speed            number
--- @field sound_hit_node       { name: string, gain: number },
--- @field sound_hit_object     { name:string, gain: number },
--- @field damage_groups        { fleshy: number },
--- @field remove_on_object_hit boolean,
--- @field remove_on_node_hit   boolean,
--- @field rotation_formula     projectiles.Entity.RotationType
--- @field on_hit_node          fun(projectile:projectiles.Entity.LuaEntity, node_pos, move_result)
--- @field on_hit_object        fun(projectile:projectiles.Entity.LuaEntity, target, move_result)
--- @field after_hit_node       fun(projectile:projectiles.Entity.LuaEntity, node_pos, move_result)
--- @field after_hit_object     fun(projectile:projectiles.Entity.LuaEntity, target, move_result)


--- @param rotation_type projectiles.Entity.RotationType
--- @param vel           Position|vector
--- @return Position|vector
local function get_rotation_pattern(rotation_type, vel)
	if not rotation_type or type(rotation_type) ~= "string" then
		rotation_type = "pointed"
	end
	local rotation_patterns = {
		pointed = {
			x = 0,
			y = math_pi + math_arctan(vel.z, vel.x),
			z = math_arctan(vel.y, math_sqrt(vel.z * vel.z + vel.x * vel.x))
		},
		rolling = {
			x = 0,
			y = -math_pi*2 + math_arctan(vel.z, vel.x),
			z = -math_arctan(vel.y, math_sqrt(vel.z * vel.z + vel.x * vel.x))
		},
	}
	return rotation_patterns[rotation_type]
end

-- Update projectile life timer
--- @param projectile projectiles.Entity.LuaEntity  projectile entity
--- @param dtime      number                        time passed from the last call
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
--- @param projectile        projectiles.Entity.LuaEntity  projectile entity
--- @param target            Entity     target entity
--- @param damage_groups     table      damage groups table
--- @param remove_after_hit  boolean    true: remove after hit; false/nil: do nothing
--- @param multipliers       table      damage multiplier table
local function punch_target(projectile, target, damage_groups, remove_after_hit, multipliers)
	if remove_after_hit == nil then
		remove_after_hit = true
	end

	local multiplied = table.multiply_each_value(damage_groups, multipliers)

	local new_damage_groups = table.map(multiplied, function(value)
		if type(value) ~= "number" then
			return value
		end
		return math.ceil(value)
	end)

	target:punch(projectile._shooter or projectile.object, 1.4, {
		full_punch_interval = 1.4,
		damage_groups       = new_damage_groups,
	}, projectile.object:get_velocity():normalize())

	if remove_after_hit ~= true then
		local pos = projectile.object:get_pos()
		minetest.add_item(pos, projectile._projectile_stack)
	end

	projectile.object:remove()
end

--- @param entity Entity  entity to check if it is a projectile
---
--- @return boolean true, if it is a projectile, or false
local function is_entity_projectile(entity)
	if not entity or not entity:get_luaentity() then
		return false
	end

	local entity_name = entity:get_luaentity().name
	local registered_projectiles = projectiles.get_projectiles()
	for _, reg in pairs(registered_projectiles) do
		if reg.entity_name == entity_name then
			return true
		end
	end

	return false
end

local function play_sound_on_hit(entity, hit_thing, pos)
	local sound_spec = { object = entity.object }
	if pos then
		sound_spec.object = nil
		sound_spec.pos = pos
	end
	if not entity._time_from_last_hit or
			(entity._time_from_last_hit > 1 and
			(not entity._sound_played_times or entity._sound_played_times < 5)) then
		entity._time_from_last_hit = 0
		entity._sound_played_times = (entity._sound_played_times or 0) + 1
		minetest.sound_play(entity["_sound_hit_"..hit_thing], sound_spec)
	end
end

local function collision_node(projectile, move_result, on_hit_node, after_hit_node)
	local node_pos = move_result.collisions[1].node_pos

		play_sound_on_hit(projectile, "node", node_pos)

		if on_hit_node and type(on_hit_node) == "function" then
			on_hit_node(projectile, node_pos, move_result)
		end
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
		if after_hit_node and type(after_hit_node) == "function" then
			after_hit_node(projectile, node_pos, move_result)
		end
end

--- Hit handling depending on target
--- @param projectile    projectiles.Entity.LuaEntity projectile entity
--- @param target        ObjectRef                    target entity
--- @param damage_groups table                        damage groups table (see Minetest API)
--- @param velocity      vector                       projectile velocity
local function hit_handling(projectile, target, damage_groups, velocity)
	local function hit()
		local damage = (vector.length(velocity)/GRAVITY)^(1/2)
		return punch_target(projectile, target, damage_groups, projectile._remove_on_object_hit, { fleshy = damage })
	end
	-- Hit player
	if target and target:is_player() then
		play_sound_on_hit(projectile, "object")
		hit()
	else
		--- @cast target Entity
		-- Hit another projectile
		if target and is_entity_projectile(target) then
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
--- @param projectile    projectiles.Entity.LuaEntity projectile entity
--- @param move_result   table                        table with collision info
--- @param damage_groups table                        damage groups table (see Minetest API)
local function collision_handling(projectile, move_result, damage_groups)
	local vel = projectile.object:get_velocity()

	if not move_result.collisions[1] then
		return
	end

	local itemstack_entity_reg = projectiles.get_projectiles()[projectile._projectile_stack:get_name()].entity_reg

	local on_hit_node   = itemstack_entity_reg.on_hit_node
	local on_hit_object = itemstack_entity_reg.on_hit_object
	local after_hit_node   = itemstack_entity_reg.after_hit_node
	local after_hit_object = itemstack_entity_reg.after_hit_object

	if move_result.collisions[1].type == "node" then
		collision_node(projectile, move_result, on_hit_node, after_hit_node)
		return
	end
	projectile.object:set_velocity({x = 0, y = 0, z = 0})
	projectile.object:set_acceleration({x = 0, y = 0, z = 0})
	projectile._timer_is_started = true

	local target = move_result.collisions[1].object

	if on_hit_object and type(on_hit_object) == "function" then
		on_hit_object(projectile, target, move_result)
	end

	hit_handling(projectile, target, damage_groups, vel)

	if after_hit_object and type(after_hit_object) == "function" then
		after_hit_object(projectile, target, move_result)
	end
end


--- @param projectile  projectiles.Entity.LuaEntity    projectile entity
--- @param environment "normal"|"water"                node type
--- @param rotation    projectiles.Entity.RotationType rotation type
local function flight_processing(projectile, environment, rotation)
	local vel = projectile.object:get_velocity()
	local projectile_type = projectiles.get_projectiles()[projectile._projectile_stack:get_name()].type
	local particle_texture = "lord_projectiles_"..projectile_type.."_trajectory_"..environment.."_particle.png"
	if vel.y ~= 0 then
		math.randomseed(os.time())
		if environment == "water" then
			minetest.add_particlespawner({
				attached = projectile.object,
				size = { min = 2, max = 4.5 },
				pos = {
					min = vector.new(-0.5, -0.5, -0.5),
					max = vector.new( 0.5,  0.5,  0.5),
					-- when `bias` is 0, all random values are exactly as likely as any
				},
				texture = particle_texture,
			})
		else
			minetest.add_particlespawner({
				attached = projectile.object,
				texture = particle_texture,
			})
		end

		projectile.object:set_rotation(get_rotation_pattern(rotation, vel))
	end
end

--- @param position Position
--- @return "normal"|"water"
local function get_environment_at(position)
	local node_groups = minetest.registered_nodes[core.get_node(position).name].groups

	return (node_groups and node_groups.water ~= nil)
		and "water"
		or  "normal"
end

local register_projectile_entity = function(name, entity_reg)
	local initial_properties = {
		physical               = true,
		collide_with_objects   = true,
		collisionbox           = { -0.15, -0.15, -0.15, 0.15, 0.15, 0.15 },
		selectionbox           = { -0.15, -0.15, -0.15, 0.15, 0.15, 0.15 },
		pointable              = true,
		visual                 = "item",
		wield_item             = "default:clay_brick",
		visual_size            = { x = 1.5, y = 1.5, z = 1.5 },
		use_texture_alpha      = false,
	}
	minetest.register_entity(name, {
		initial_properties = table.merge(initial_properties, entity_reg.initial_properties),
		_life_timer         = entity_reg.life_timer or 90,
		_shooter            = nil,
		_timer_is_started   = entity_reg.timer_is_started or true,
		_collision_count    = 0,
		_sound_hit_node     = entity_reg.sound_hit_node,
		_sound_hit_object   = entity_reg.sound_hit_object,
		on_step        = function(self, dtime, moveresult)
			if self._time_from_last_hit and self._life_timer > 0  then
				self._time_from_last_hit = self._time_from_last_hit + dtime
			end

			local pos = self.object:get_pos()

			core.emerge_area(vector.subtract(pos, 8), vector.add(pos, 8))

			if (vector.length(self.object:get_velocity()) > 0 and moveresult.collides) or moveresult.standing_on_object then
				self:_on_collision(moveresult)
			elseif vector.length(self.object:get_velocity()) > 0 then
				flight_processing(self, get_environment_at(pos), self._rotation_formula)
			end

			local stack = self._projectile_stack
			--- @diagnostic disable-next-line # TODO: тут что-то странное (is_in_creative = not_in_creative_inventory)
			local is_in_creative = minetest.registered_items[stack:get_name()].groups.not_in_creative_inventory

			if update_life_timer(self, dtime) and not is_in_creative then
				minetest.add_item(pos, stack)
			end
		end,
		on_punch       = function(self, puncher, time_from_last_punch, tool_capabilities, dir, damage)
			if not puncher:is_player() or not self._shooter then
				return
			end

			if not self._shooter:is_player() then
				return
			end

			if vector.length(self.object:get_velocity()) > 0 or self._shooter:get_player_name() ~= puncher:get_player_name() then
				return
			end
			self.object:remove()
			minetest.give_or_drop(puncher, self._projectile_stack)
		end,
		on_activate    = function(self, staticdata, dtime_s)
			if not staticdata or staticdata == "" then
				return
			end
			local staticdata_table = minetest.deserialize(staticdata)
			if not staticdata_table then
				return
			end

			self._timer_is_started = true --staticdata_table._timer_is_started -- TODO: check if it is needed
			self._projectile_stack = ItemStack(staticdata_table._projectile_stack)
			update_life_timer(self, dtime_s)
		end,
		get_staticdata = function(self)
			local staticdata_table = {}
			staticdata_table._timer_is_started = self._timer_is_started
			local projectile_stack = self._projectile_stack
			if projectile_stack then
				staticdata_table._projectile_stack = projectile_stack:to_table()
			end
			return minetest.serialize(staticdata_table)
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
					minetest.add_item(pos, self._projectile_stack)
				end
			end
		end
	})
end

return {
	register_projectile_entity = register_projectile_entity,
	get_rotation_pattern       = get_rotation_pattern,
}
