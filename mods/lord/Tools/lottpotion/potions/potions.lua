

-- moved AS IS from lottpotion/init.lua
-- TODO: REMOVE; and migrate to our `lord_potions`


lottpotion.register_potion("athelasbrew", "Athelas Brew", "lottpotion:athelasbrew", 100, {
	effect = "fixhp",
	types  = {
		{
			type    = 1,
			hp      = 1,
			time    = 20,
			set     = {},
			effects = {
			},
		},
		{
			type    = 2,
			hp      = 2,
			time    = 50,
			set     = {},
			effects = {
			},
		},
		{
			type    = 3,
			hp      = 4,
			time    = 100,
			set     = {},
			effects = {
			},
		},
	}
})

lottpotion.register_potion("limpe", "Limpe", "lottpotion:limpe", 240, {
	effect = "air",
	types  = {
		{
			type    = 1,
			br      = 2,
			hp      = 10,
			time    = 60,
			set     = {},
			effects = {
			},
		},
		{
			type    = 2,
			br      = 5,
			time    = 120,
			set     = {},
			effects = {
			},
		},
		{
			type    = 3,
			br      = 10,
			time    = 240,
			set     = {},
			effects = {
			},
		},
	}
})

lottpotion.register_potion("miruvor", "Miruvor", "lottpotion:miruvor", 240, {
	effect = "phys_override",
	types  = {
		{
			type    = 1,
			set     = {},
			time    = 60,
			effects = {
				jump = 0.3,
			},
		},
		{
			type    = 2,
			set     = {},
			time    = 120,
			effects = {
				jump = 0.6,
			},
		},
		{
			type    = 3,
			set     = {},
			time    = 240,
			effects = {
				jump = 1.0,
			},
		},
	}
})

lottpotion.register_potion("spiderpoison", "Spider Poison", "lottpotion:spiderpoison", 20, {
	effect = "phys_override",
	types  = {
		{
			type    = 1,
			set     = {},
			effects = {
				speed = -0.2,
				jump  = -0.2,
			},
		},
		{
			type    = 2,
			set     = {},
			effects = {
				speed = -0.5,
				jump  = -0.5,
			},
		},
		{
			type    = 3,
			set     = {},
			effects = {
				speed = -1,
				jump  = -1,
			},
		},
	}
})

lottpotion.register_potion("orcdraught", "Orc Draught", "lottpotion:orcdraught", 100, {
	effect = "fixhp",
	types  = {
		{
			type    = 1,
			hp      = -1,
			time    = 20,
			set     = {},
			effects = {
			},
		},
		{
			type    = 2,
			hp      = -1,
			time    = 50,
			set     = {},
			effects = {
			},
		},
		{
			type    = 3,
			hp      = -1,
			time    = 100,
			set     = {},
			effects = {
			},
		},
	}
})

lottpotion.register_potion("entdraught", "Ent Draught", "lottpotion:entdraught", 240, {
	effect = "phys_override",
	types  = {
		{
			type    = 1,
			set     = {},
			effects = {
				speed = 1,
				jump  = -0.2,
			},
		},
		{
			type    = 2,
			set     = {},
			effects = {
				speed = 2,
				jump  = -0.5,
			},
		},
		{
			type    = 3,
			set     = {},
			effects = {
				speed = 3,
				jump  = -1,
			},
		},
	}
})
