right_mobs_ai = {
	states = {
		stroll = 1,
		rest = 2,
		runaway = 3,
		aggression = 4,
		goto_target = 5,
		attack = 6,
	},
	attacks = {
		dogfight = 1,
		remote_attack = 2,
	},
}

local function serialize_state(state)
	if state == right_mobs_ai.states.stroll then
		return "stroll"
	elseif state == right_mobs_ai.states.rest then
		return "rest"
	elseif state == right_mobs_ai.states.runaway then
		return "runaway"
	elseif state == right_mobs_ai.states.aggression then
		return "aggression"
	elseif state == right_mobs_ai.states.goto_target then
		return "goto_target"
	elseif state == right_mobs_ai.states.attack then
		return "attack"
	end
end

local function deserialize_state(state)
	if state == "stroll" then
		return right_mobs_ai.states.stroll
	elseif state == "rest" then
		return right_mobs_ai.states.rest
	elseif state == "runaway" then
		return right_mobs_ai.states.runaway
	elseif state == "aggression" then
		return right_mobs_ai.states.aggression
	elseif state == "goto_target" then
		return right_mobs_ai.states.goto_target
	elseif state == "attack" then
		return right_mobs_ai.states.attack
	end
end

-- processing actions
local function process_attack(context, position, velocity)
	local attack = nil
	if context.definition.select_attack then
		attack = context.definition.select_attack(context, position, velocity)	
	end

	if attack and context.target then
		if context.definition.attack then
			context.definition.attack(context, context.target, attack, context.userdata)
		end
	end
end

local function process_walk(context, current_position, current_velocity, speed)
	-- TODO: use random delta
	local rx = 0
	local ry = 0
	local rz = 0
 	local target_position = {x = current_position.x + rx, y = current_position.y + ry, z = current_position.z + rz}
	 if context.definition.walk then
		context.definition.walk(context, target_position, speed, context.userdata)
	end
end

local function process_targeting(context, current_position, current_velocity)
	update_target_position(context)
	if context.definition.walk then
		context.definition.walk(context, context.target_position, context.definition.targeting_speed, context.userdata)
	end
end

local function process_stay(context, position, velocity)
	context.target = nil
	context.target_position = nil
	if context.definition.stay then
		context.definition.stay(context, context.userdata)
	end
end

local function process_aggression(context, position, velocity, target)
	if context.definition.aggression then
		context.definition.aggression(context, context.target, context.userdata)
	end
end

local function process_target_lost(context)
	context.target = nil
	context.target_position = nil
	if context.definition.on_target_lost then
		context.definition.on_target_lost(context)
	end
end

local update_target_position = function(context)
	if context.target then
		context.target_position = context.target:get_pos()
	end
end

-- default actions
local function default_on_punched(context, puncher, attributes)
	context.state = right_mobs_ai.states.aggression
	context.target = puncher
	update_target_position(context)
end

local function default_on_target_lost(context)
	context.state = right_mobs_ai.states.rest
	context.aggression = nil
end

local function default_think(context, position, velocity, dtime)
	-- aggression
	if context.state == right_mobs_ai.states.aggression then
		if context.aggression == nil then
			context.aggression = {
				time = 0
			}
		end

		context.aggression.time += dtime

		if context.aggression.dtime > 10 then
			context.state = right_mobs_ai.states.rest
			context.aggression = nil
		end
	end
end

local function default_select_attack(context, position, velocity)
	local delta = {	x=context.target_position.x - position.x,
					y=context.target_position.y - position.y,
					z=context.target_position.z - position.z,
				}
	local len = vector.length(delta)
	
	if has_dogfight(context) and len < context.definition.dogfight_distance then
		return right_mobs_ai.attacks.dogfight
	elseif has_remote(context) then
		return right_mobs_ai.attacks.remote_attack
	end
	return nil
end

-- end of default actions

local function has_dogfight(context)
	local available = context.definition.available_attacks
	for _, item in available do
		if item == right_mobs_ai.attacks.dogfight then
			return true
		end
	end
	return false
end

local function has_remote(context)
	local available = context.definition.available_attacks
	for _, item in available do
		if item == right_mobs_ai.attacks.remote_attack then
			return true
		end
	end
	return false
end

right_mobs_ai.process = function(self, context, position, velocity, dtime)
	if context.state == right_mobs_ai.states.stroll then
		process_walk(context, position, velocity, context.stroll_speed)
	elseif context.state == right_mobs_ai.states.rest then
		process_stay(context, position, velocity)
	elseif context.state == right_mobs_ai.states.runaway then
		process_walk(context, position, velocity, context.runaway_speed)
	elseif context.state == right_mobs_ai.states.goto_target then
		process_targeting(context, position, velocity)
	elseif context.state == right_mobs_ai.states.attack then
		process_attack(context, position, velocity)
	elseif context.state == right_mobs_ai.states.aggression then
		process_aggression(context, position, velocity)
	end

	if context.definition.think then
		context.definition.think(context, position, velocity, dtime)
	end
end

right_mobs_ai.punch = function(self, context, puncher, attributes)
	if context.definition.on_punched then
		context.definition.on_punched(context, puncher, attributes)
	end
end

right_mobs_ai.get_targets = function(self, context)
	if context.target then
		return {context.target}
	else
		return {}
	end
end

right_mobs_ai.target_lost = function(self, context, target)
	if context.target == target then
		process_target_lost(context)
	end
end

right_mobs_ai.register_mob = function(self, name, def)
	local definition = {
		aux = def.aux,
		available_attacks = def.available_attacks or {},

		-- actions
		attack = def.attack,
		walk = def.walk,
		stay = def.stay,
		aggression = def.aggression,

		-- reactions on external actions
		on_punched = def.on_punched or default_on_punched,
		on_target_lost = def.on_target_lost or default_on_target_lost,

		-- decision function
		think = def.think or default_think,
		select_attack = def.select_attack or default_select_attack,

		-- parameters
		stroll_speed = def.stroll_speed or right_mobs_ai.defaults.speed,
		runaway_speed = def.runaway_speed or right_mobs_ai.defaults.speed,
		targeting_speed = def.targeting_speed or right_mobs_ai.defaults.speed,
	}

	self.mob_definitions[name] = definition
end

right_mobs_ai.init_new_mob = function(self, name, userdata)
	-- TODO: проверить что моб с таким именем зарегистрирован

	local context = {
		definition = self.mob_definitions[name],
		state = self.states.rest,
		name = name,
		userdata = userdata,
	}
	return context
end

right_mobs_ai.serialize = function(self, context)
	-- сохранение целей сложно реализовать, поэтому при засыпании моб забывает цели
	if context.state == self.states.attack or
		context.state == self.states.goto_target or
		context.state == self.states.aggression then

		context.state = self.states.rest
		context.target = nil
		context.target_position = nil
	end

	local data = {
		name = context.name,
		state = serialize_state(context.state),
	}
	return minetest.serialize(data)
end

right_mobs_ai.init_from_serialized = function(self, serialized, userdata)
	-- TODO: проверить что моб с таким именем зарегистрирован

	local deserialized = minetest.deserialize(data)
	local name = deserialized.name
	local state = deserialize_state(deserialized.state)
	local context = {
		name = name,
		state = state,
		definition = self.mob_definitions[name],
		userdata = userdata,
	}
	return context
end
