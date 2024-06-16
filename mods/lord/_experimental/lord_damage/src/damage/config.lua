local spawn_particles = function(player, damage_type)
	minetest.add_particlespawner({
		amount   = 20,
		time     = 0.02,
		attached = player,
		texture  = "lord_damage_"..damage_type.."_particle.png",
		glow     = 1,
		collisiondetection = true,
		pos = {
			min = vector.new(-0.5,0.5,-0.5),
			max = vector.new(0.5,1,0.5),
			bias = 0,
		},
		vel = {
			min = vector.new(-0.5,0,-0.5),
			max = vector.new(0.5,1,0.5),
			bias = 0,
		},
		acc = {
			min = vector.new(-1.5,-1,-1.5),
			max = vector.new(1.5,2,1.5),
			bias = 0,
		},
		exptime = {
			min = 0.1,
			max = 0.5,
			bias = 0,
		},
		jitter = {
			min = vector.new(-1.5,-1,-1.5),
			max = vector.new(1.5,2,1.5),
			bias = 0,
		},
	})
end

local direct_behavior = function(player, amount, reason, source)
	return lord_damage.base_behavior(player, amount, "direct", reason, source)
end

local direct_periodic_behavior = function(player, amount, reason, source, chunks)
	return lord_damage.periodic_base_behavior(player, amount, "direct_periodic", reason, source, chunks)
end


local simple_physical_behavior = function(player, amount, reason, source)
	spawn_particles(player, "physical")
	return lord_damage.base_behavior(player, amount, "physical", reason, source)
end

local simple_physical_periodic_behavior = function(player, amount, reason, source, chunks)
	return lord_damage.periodic_base_behavior(player, amount, "physical_periodic", reason, source, chunks)
end

local slashing_physical_behavior = function(player, amount, reason, source)
	spawn_particles(player, "physical")
	return lord_damage.base_behavior(player, amount, "slashing_physical", reason, source)
end

local slashing_physical_periodic_behavior = function(player, amount, reason, source, chunks)
	return lord_damage.periodic_base_behavior(player, amount, "slashing_physical_periodic", reason, source, chunks)
end

local piercing_physical_behavior = function(player, amount, reason, source)
	spawn_particles(player, "physical")
	return lord_damage.base_behavior(player, amount, "piercing_physical", reason, source)
end

local piercing_physical_periodic_behavior = function(player, amount, reason, source, chunks)
	return lord_damage.periodic_base_behavior(player, amount, "piercing_physical_periodic", reason, source, chunks)
end

local toxical_behavior = function(player, amount, reason, source)
	spawn_particles(player, "toxical")

	return lord_damage.base_behavior(player, amount, "toxical", reason, source)
end

local toxical_periodic_behavior = function(player, amount, reason, source, chunks)
	return lord_damage.periodic_base_behavior(player, amount, "toxical_periodic", reason, source, chunks)
end


local fiery_behavior = function(player, amount, reason, source)
	minetest.sound_play("default_cool_lava", { object = player, max_hear_distance = 16, gain = 0.2 }, true)
	spawn_particles(player, "fiery")

	lord_damage.base_behavior(player, amount, "fiery", reason, source)
end

local fiery_periodic_behavior = function(player, amount, reason, source, chunks)
	local do_in_cycle = function()
		minetest.sound_play("default_cool_lava", { object = player, max_hear_distance = 16, gain = 0.2 }, true)
		spawn_particles(player, "fiery")
	end
	return lord_damage.periodic_base_behavior(player, amount, "fiery_periodic", reason, source, chunks, do_in_cycle)
end


local mental_behavior = function(player, amount, reason, source)
	lord_damage.base_behavior(player, amount, "mental", reason, source)
end

local mental_periodic_behavior = function(player, amount, reason, source, chunks)
	return lord_damage.periodic_base_behavior(player, amount, "mental_periodic", reason, source, chunks)
end

return {
	["direct"]                     = direct_behavior,
	["direct_periodic"]            = direct_periodic_behavior,
	["simple_physical"]            = simple_physical_behavior,
	["simple_physical_periodic"]   = simple_physical_periodic_behavior,
	["slashing_physical"]          = slashing_physical_behavior,
	["slashing_physical_periodic"] = slashing_physical_periodic_behavior,
	["piercing_physical"]          = piercing_physical_behavior,
	["piercing_physical_periodic"] = piercing_physical_periodic_behavior,
	["toxical"]                    = toxical_behavior,
	["toxical_periodic"]           = toxical_periodic_behavior,
	["fiery"]                      = fiery_behavior,
	["fiery_periodic"]             = fiery_periodic_behavior,
	["mental"]                     = mental_behavior,
	["mental_periodic"]            = mental_periodic_behavior,
}

