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

local direct_behavior = function(player, amount, reason)
	reason.damage_type = "direct"
	return lord_damage.base_behavior(player, amount, reason)
end

local direct_periodic_behavior = function(player, amount, reason, chunks, run)
	reason.damage_type = "direct_periodic"
	return lord_damage.periodic_base_behavior(player, amount, reason, chunks, run)
end


local simple_physical_behavior = function(player, amount, reason)
	reason.damage_type = "physical"
	spawn_particles(player, "physical")
	return lord_damage.base_behavior(player, amount, reason)
end

local simple_physical_periodic_behavior = function(player, amount, reason, chunks, run)
	reason.damage_type = "physical_periodic"
	return lord_damage.periodic_base_behavior(player, amount, reason, chunks, run)
end

local slashing_physical_behavior = function(player, amount, reason)
	reason.damage_type = "slashing_physical"
	spawn_particles(player, "physical")
	return lord_damage.base_behavior(player, amount, reason)
end

local slashing_physical_periodic_behavior = function(player, amount, reason, chunks, run)
	reason.damage_type = "slashing_physical_periodic"
	return lord_damage.periodic_base_behavior(player, amount, reason, chunks, run)
end

local piercing_physical_behavior = function(player, amount, reason)
	reason.damage_type = "piercing_physical"
	spawn_particles(player, "physical")
	return lord_damage.base_behavior(player, amount, reason)
end

local piercing_physical_periodic_behavior = function(player, amount, reason, chunks, run)
	reason.damage_type = "piercing_physical_periodic"
	return lord_damage.periodic_base_behavior(player, amount, reason, chunks, run)
end

local toxical_behavior = function(player, amount, reason)
	reason.damage_type = "toxical"
	spawn_particles(player, "toxical")

	return lord_damage.base_behavior(player, amount, reason)
end

local toxical_periodic_behavior = function(player, amount, reason, chunks, run)
	reason.damage_type = "toxical_periodic"
	return lord_damage.periodic_base_behavior(player, amount, reason, chunks, run)
end


local fiery_behavior = function(player, amount, reason)
	reason.damage_type = "fiery"
	minetest.sound_play("default_cool_lava", { object = player, max_hear_distance = 16, gain = 0.2 }, true)
	spawn_particles(player, "fiery")

	lord_damage.base_behavior(player, amount, reason)
end

local fiery_periodic_behavior = function(player, amount, reason, chunks, run)
	reason.damage_type = "fiery_periodic"
	local do_in_cycle = function()
		if type(run) == "function" then
			run()
		end
		minetest.sound_play("default_cool_lava", { object = player, max_hear_distance = 16, gain = 0.2 }, true)
		spawn_particles(player, "fiery")
	end
	return lord_damage.periodic_base_behavior(player, amount, reason, chunks, do_in_cycle)
end


local mental_behavior = function(player, amount, reason)
	reason.damage_type = "mental"
	lord_damage.base_behavior(player, amount, reason)
end

local mental_periodic_behavior = function(player, amount, reason, chunks, run)
	reason.damage_type = "mental_periodic"
	return lord_damage.periodic_base_behavior(player, amount, reason, chunks, run)
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

