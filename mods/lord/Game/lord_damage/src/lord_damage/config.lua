damage.Type.FLESHY      = 'fleshy'
damage.Type.FIRE        = 'fire'
damage.Type.SOUL        = 'soul'
damage.Type.POISON      = 'poison'
damage.Type.SUFFOCATION = 'suffocation'


return {
	damage_types = {
		damage.Type.FLESHY,
		damage.Type.FIRE,
		damage.Type.SOUL,
		damage.Type.POISON,
		damage.Type.SUFFOCATION,
	},
	particles = {
		[damage.Type.FLESHY] = { amount = 10, time = 0.2 },
		[damage.Type.FIRE]   = { amount = 50, time = 1.0 },
		[damage.Type.SOUL]   = { amount =  5, time = 0.2 },
		[damage.Type.POISON] = { amount = 30, time = 1.0 },
	}
}
