
--- @class spawners.Particles
local Particles = {
	enabled = true
}

--- @param config spawners.Config
function Particles.init(config)
	Particles.enabled = config.enable_particles or Particles.enabled
end

function Particles.cloud_boom(pos)
	if not Particles.enabled then
		return
	end

	minetest.add_particlespawner({
		amount     = 5,
		time       = 2,
		minpos     = vector.subtract({ x = pos.x - 0.3, y = pos.y, z = pos.z - 0.3 }, 0.3),
		maxpos     = vector.add({ x = pos.x + 0.3, y = pos.y, z = pos.z + 0.3 }, 0.3),
		minvel     = { x = 0.1, y = 0.1, z = 0.1 },
		maxvel     = { x = 0.2, y = 0.2, z = 0.2 },
		minacc     = vector.new({ x = -0.1, y = 0.3, z = -0.1 }),
		maxacc     = vector.new({ x = 0.1, y = 0.6, z = 0.1 }),
		minexptime = 2,
		maxexptime = 3,
		minsize    = 16,
		maxsize    = 24,
		texture    = 'lord_spawners_smoke_particle_2.png',
		animation  = {
			type     = 'vertical_frames',
			-- Width of a frame in pixels
			aspect_w = 16,
			-- Height of a frame in pixels
			aspect_h = 16,
			-- Full loop length
			length   = 2.0,
		},
	})
end

function Particles.add_flame_effects(pos)
	if not Particles.enabled then
		return
	end

	return minetest.add_particlespawner({
		amount     = 6,
		time       = 0,
		minpos     = vector.subtract({ x = pos.x - 0.001, y = pos.y - 0.001, z = pos.z - 0.001 }, 0.5),
		maxpos     = vector.add({ x = pos.x + 0.001, y = pos.y + 0.001, z = pos.z + 0.001 }, 0.5),
		minvel     = { x = -0.1, y = -0.1, z = -0.1 },
		maxvel     = { x = 0.1, y = 0.1, z = 0.1 },
		minacc     = vector.new(),
		maxacc     = vector.new(),
		minexptime = 1,
		maxexptime = 5,
		minsize    = 0.5,
		maxsize    = 2.5,
		texture    = 'lord_spawners_flame_particle_2.png',
	})
end

function Particles.add_smoke_effects(pos)
	if not Particles.enabled then
		return
	end

	return minetest.add_particlespawner({
		amount     = 1,
		time       = 0,
		minpos     = vector.subtract({ x = pos.x - 0.001, y = pos.y - 0.001, z = pos.z - 0.001 }, 0.5),
		maxpos     = vector.add({ x = pos.x + 0.001, y = pos.y + 0.001, z = pos.z + 0.001 }, 0.5),
		minvel     = { x = -0.5, y = 0.5, z = -0.5 },
		maxvel     = { x = 0.5, y = 1.5, z = 0.5 },
		minacc     = vector.new({ x = -0.1, y = 0.1, z = -0.1 }),
		maxacc     = vector.new({ x = 0.1, y = 0.3, z = 0.1 }),
		minexptime = 0.5,
		maxexptime = 2,
		minsize    = 0.5,
		maxsize    = 2,
		texture    = 'lord_spawners_smoke_particle.png^[transform' .. math.random(0, 3),
	})
end


return Particles
