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

right_mobs_health.heal = function(self, context, healer, health)
    context.health = math.min(context.health + health, context.max_health)
end

right_mobs_health.punch = function(self, context, puncher, force)
    context.health = math.max(context.health - force, 0)
end

right_mobs_health.process = function(self, context, position, velocity, dtime)
    if context.state == self.states.dead then
        return
    end

    if context.health <= 0 then
        context.state = self.states.dead
        if context.definition.on_die then
            context.definition.on_die(context, context.userdata)
        end
    end
end

right_mobs_health.register_mob = function(self, name, def)
	local definition = {
		aux = def.aux,

        on_die = def.on_die,
    }

    self.mob_definitions[name] = definition
end

right_mobs_health.init_new_mob = function(self, name, max_health, userdata)
    -- TODO: проверить что моб с таким именем зарегистрирован
    
    local context = {
        name = name,
        max_health = max_health,
        health = max_health,
        userdata = userdata,
        state = self.states.alive,

        definition = self.mob_definitions[name],
    }

    return context
end

right_mobs_health.serialize = function(self, context)
    local data = {
        name = context.name,
        health = context.health,
        max_health = context.max_health,
        state = serialize_state(context.state),
    }
    return minetest.serialize(data)
end

right_mobs_health.init_from_serialized = function(self, serialized, userdata)
    local deserialized = minetest.deserialize(serialized)
    local name = deserialized.name

    -- TODO: проверить что моб с таким именем зарегистрирован

    local context = {
        name = name,
        health = deserialized.health,
        max_health = deserialized.max_health,
        state = deserialize_state(deserialized.state),
        userdata = userdata,
        definition = self.mob_definitions[name],
    }
    return context
end
