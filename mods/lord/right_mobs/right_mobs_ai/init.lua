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
	defaults = {
		speed = 1,
	},
	mob_definitions = {},
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

local update_target_position = function(context)
	if context.target then
		context.target_position = context.target:get_pos()
	end
end

-- processing actions
local function process_attack(context, position, velocity)
	update_target_position(context)
	if context.attack and context.attack.perform then	
		local attack = nil
		if context.definition.select_attack then
			attack = context.definition.select_attack(context, position, velocity, context.userdata)
		end

		if attack and context.target then
			if context.definition.attack then
				context.definition.attack(context, context.target, attack, context.userdata)
			end
		end

		context.attack.perform = false
	end
end

local function process_walk(context, current_position, current_velocity, speed)
	-- TODO: use random delta
	local rx = 0
	local ry = 0
	local rz = 0

	speed = speed or right_mobs_api.defaults.speed
 	local target_position = {x = current_position.x + rx, y = current_position.y + ry, z = current_position.z + rz}
	if context.definition.walk then
		context.definition.walk(context, target_position, speed, context.userdata)
	end
end

local function process_targeting(context, current_position, current_velocity)
	update_target_position(context)
	if context.definition.walk then
		context.definition.walk(context, context.target_position, context.parameters.targeting_speed, context.userdata)
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
	update_target_position(context)
	if context.aggression and context.aggression.perform then
		if context.definition.aggression then
			context.definition.aggression(context, context.target, context.userdata)
		end
		context.aggression.perform = false
	end
end

local function process_target_lost(context)
	context.target = nil
	context.target_position = nil
	if context.definition.on_target_lost then
		context.definition.on_target_lost(context)
	end
end

local function has_dogfight(context)
	local available = context.parameters.available_attacks or {}
	for _, item in pairs(available) do
		if item == right_mobs_ai.attacks.dogfight then
			return true
		end
	end
	return false
end

local function has_remote(context)
	local available = context.parameters.available_attacks
	for _, item in pairs(available) do
		if item == right_mobs_ai.attacks.remote_attack then
			return true
		end
	end
	return false
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
				switch_timer = 0,
				perform = false,
			}
		end

		context.aggression.switch_timer = context.aggression.switch_timer + dtime

		if context.aggression.switch_timer > context.parameters.aggression.switch_time then
			context.aggression.perform = true
			context.aggression.switch_time = 0
			context.state = right_mobs_ai.states.attack
		end
	elseif context.state == right_mobs_ai.states.attack then
		if context.attack == nil then
			context.attack = {
				switch_timer = 0,
				attack_timer = 0,
				perform = false,
			}
		end

		context.attack.switch_timer = context.attack.switch_timer + dtime
		context.attack.attack_timer = context.attack.attack_timer + dtime

		if context.attack.switch_timer > context.parameters.attack.switch_time then
			context.attack.switch_timer = 0
			context.attack.attack_timer = 0
			context.state = right_mobs_ai.states.rest
		end

		if context.attack.attack_timer > context.parameters.attack.attack_period then
			context.attack.perform = true
			context.attack.attack_timer = 0
		end
	end
end

local function default_select_attack(context, position, velocity)
	local delta = {	x=context.target_position.x - position.x,
					y=context.target_position.y - position.y,
					z=context.target_position.z - position.z,
				}
	local len = vector.length(delta)
	
	if has_dogfight(context) and len < context.parameters.dogfight_distance then
		return right_mobs_ai.attacks.dogfight
	elseif has_remote(context) then
		return right_mobs_ai.attacks.remote_attack
	end
	return nil
end

-- end of default actions

right_mobs_ai.process = function(self, context, position, velocity, dtime)
	if context.state == right_mobs_ai.states.stroll then
		process_walk(context, position, velocity, context.parameters.stroll_speed)
	elseif context.state == right_mobs_ai.states.rest then
		process_stay(context, position, velocity)
	elseif context.state == right_mobs_ai.states.runaway then
		process_walk(context, position, velocity, context.parametes.runaway_speed)
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
	}

	self.mob_definitions[name] = definition
end

right_mobs_ai.init_new_mob = function(self, name, userdata, parameters)
	-- TODO: проверить что моб с таким именем зарегистрирован

	local context = {
		parameters = parameters,
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
		parameters = context.parameters,
		state = serialize_state(context.state),
	}
	return minetest.serialize(data)
end

right_mobs_ai.init_from_serialized = function(self, serialized, userdata)
    local deserialized = minetest.deserialize(serialized)
	local name = deserialized.name

	if not self.mob_definitions[name] then
        return nil
    end

	local parameters = deserialized.parameters
	local state = deserialize_state(deserialized.state)
	local context = {
		name = name,
		state = state,
		definition = self.mob_definitions[name],
		parameters = parameters,
		userdata = userdata,
	}
	return context
end
