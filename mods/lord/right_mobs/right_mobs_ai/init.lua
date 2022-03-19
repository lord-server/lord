right_mobs_ai = {
	states = {
		death = 0,
		stroll = 1,
		rest = 2,
		runaway = 3,
		goto_target = 4,
		attack = 5,
	},
	attacks = {
		dogfight = 1,
		remote_attack = 2,
	},
}

local function default_attack(context, attack)
end

local function default_death(context)
end

local function default_walk(context, target)
end

local function default_stay(context)
end

local function default_on_punched(context, puncher, attributes)
end

local function default_think(context, dtime)
end

right_mobs_ai.init_new_mob = function(self, def)
	local context = {
		aux = def.aux,
		state = self.states.rest,
		available_attacks = def.available_attacks or {},

		-- implementations of actions
		attack = def.attack or default_attack
		death = def.death or default_death,
		walk = def.walk or default_walk,
		stay = def.stay or default_stay,

		-- reactions on external actions
		punched = def.on_punched or default_on_punched,

		-- decision function
		think = def.think or default_think,
	}
end
