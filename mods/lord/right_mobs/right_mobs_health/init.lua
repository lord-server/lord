right_mobs_health = {
    mob_definitions = {},
    states = {
        dead = 0,
        alive = 1,
    }
}

local function serialize_state(state)
	if state == right_mobs_health.states.dead then
		return "dead"
	elseif state == right_mobs_health.states.alive then
		return "alive"
	end
end

local function deserialize_state(state)
	if state == "dead" then
		return right_mobs_health.states.dead
	elseif state == "alive" then
		return right_mobs_health.states.alive
    end
end

right_mobs_health.heal = function(self, context, healer, force)
    for name, value in pairs(force) do
        value = math.max(value, 0)
        if context.health[name] then
            context.health[name] = math.min(context.health[name] + value, context.max_health[name])
        end
    end
end

right_mobs_health.punch = function(self, context, puncher, force)
    for name, value in pairs(force) do
        value = math.max(value, 0)
        if context.health[name] then
            context.health[name] = math.max(context.health[name] - value, 0)
        end
    end
end

right_mobs_health.process = function(self, context, position, velocity, dtime)
    if context.state == self.states.dead then
        return
    end
    for _, value in pairs(context.health) do
        if value <= 0 then
            context.state = self.states.dead
            if context.definition.on_die then
                context.definition.on_die(context, context.userdata)
            end
            break
        end
    end
end

right_mobs_health.register_mob = function(self, name, def)
	local definition = {
		aux = def.aux,
        on_die = def.on_die,
        factors = def.factors,
    }

    self.mob_definitions[name] = definition
end

right_mobs_health.init_new_mob = function(self, name, userdata, parameters)
    -- TODO: проверить что моб с таким именем зарегистрирован
    local context = {
        name = name,
        userdata = userdata,
        state = self.states.alive,
        parameters = parameters,

        full_health = {},
        health = {},

        definition = self.mob_definitions[name],
    }

    for name, value in pairs(parameters.factors) do
        context.health[name] = value
        context.full_health[name] = value
    end
    
    return context
end

right_mobs_health.serialize = function(self, context)
    local data = {
        name = context.name,
        health = context.health,
        full_health = context.full_health,
        state = serialize_state(context.state),
    }
    return minetest.serialize(data)
end

local factors_check(factors, vals)
    local res = {}
    for name, default in pairs(factors) do
        res[name] = vals[name] or default
    end
    return res
end

right_mobs_health.init_from_serialized = function(self, serialized, userdata)
    local deserialized = minetest.deserialize(serialized)
    local name = deserialized.name

    if not self.mob_definitions[name] then
        return nil
    end
    local def = self.mob_definitions[name]
    local context = {
        name = name,
        health = factors_check(def.factors, deserialized.health),
        full_health =  factors_check(def.factors, deserialized.full_health),
        state = deserialize_state(deserialized.state),
        userdata = userdata,
        definition = def,
    }
    return context
end
