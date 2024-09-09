local config    = require('lord_damage.config')
local Particles = require('lord_damage.Particles')


--- Registers our (LORD) damage Types.
local function register_damage_types()
	for _, damage_type in pairs(config.damage_types) do
		damage.Type.register(damage_type)
	end
end

--- Registers adding particles near damaged player.
local function register_damage_particles()
	Particles.configure(config.particles)

	damage.on_damage_of(damage.Type.FLESHY, function(player, amount, reason)
		Particles.spawn(player, damage.Type.FLESHY)
	end)
	damage.on_damage_of(damage.Type.FIRE, function(player, amount, reason)
		Particles.spawn(player, damage.Type.FIRE)
	end)
	damage.on_damage_of(damage.Type.SOUL, function(player, amount, reason)
		Particles.spawn(player, damage.Type.SOUL)
	end)
	damage.on_damage_of(damage.Type.POISON, function(player, amount, reason)
		Particles.spawn(player, damage.Type.POISON)
	end)
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_damage_types()
		register_damage_particles()
	end,
}
