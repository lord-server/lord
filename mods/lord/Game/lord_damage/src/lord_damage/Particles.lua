local minetest_add_particlespawner, vector_new
    = minetest.add_particlespawner, vector.new



--- @class lord_damage.Particles
local Particles = {
	--- @private
	--- @static
	--- @type table<string,{amount:number,time:number}>
	for_damage = {
		[damage.Type.FLESHY] = { amount = 10, time = 0.2 },
		[damage.Type.FIRE]   = { amount = 50, time = 1.0 },
		[damage.Type.SOUL]   = { amount =  5, time = 0.2 },
		[damage.Type.POISON] = { amount = 30, time = 1.0 },
	}
}

--- @param config table<string,{amount:number,time:number}>
function Particles.configure(config)
	Particles.for_damage = config
end

--- @param player      Player
--- @param damage_type string one of damage.Type.<CONST>
function Particles.spawn(player, damage_type)
	local dmg_particles = Particles.for_damage[damage_type]
	local amount = dmg_particles and dmg_particles.amount or 20
	local time   = dmg_particles and dmg_particles.time or 0.2

	minetest_add_particlespawner({
		amount             = amount,
		time               = time,
		attached           = player,
		texture            = "lord_damage_particle_" .. damage_type .. ".png",
		glow               = 1,
		collisiondetection = true,
		pos                = {
			min  = vector_new(-0.5, 0.5, -0.5),
			max  = vector_new(0.5, 1, 0.5),
			bias = 0,
		},
		vel                = {
			min  = vector_new(-0.5, 0, -0.5),
			max  = vector_new(0.5, 1, 0.5),
			bias = 0,
		},
		acc                = {
			min  = vector_new(-1.5, -1, -1.5),
			max  = vector_new(1.5, 2, 1.5),
			bias = 0,
		},
		exptime            = {
			min  = 0.1,
			max  = 0.5,
			bias = 0,
		},
		jitter             = {
			min  = vector_new(-1.5, -1, -1.5),
			max  = vector_new(1.5, 2, 1.5),
			bias = 0,
		},
	})
end


return Particles
