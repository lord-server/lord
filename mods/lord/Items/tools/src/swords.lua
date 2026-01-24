local S = minetest.get_mod_translator()

return {
	get_recipes = function(source)
		return {{
			{source},
			{source},
			{'group:stick'},
		}}
	end,
	wood        = {
		description         = S("Wooden Sword"),
		max_drop_level      = 0,
		snappy              = {
			times    = { [2] = 1.6, [3] = 0.40 },
			uses     = 10,
			maxlevel = 1
		},
		damage_groups       = { fleshy = 1.5 },
		full_punch_interval = 0.5,
		groups              = { wooden = 1, sword = 1, flammable = 2 },
	},
	stone       = {
		description         = S("Stone Sword"),
		max_drop_level      = 0,
		snappy              = {
			times    = { [2] = 1.4, [3] = 0.40 },
			uses     = 20,
			maxlevel = 1
		},
		damage_groups       = { fleshy = 4.8 },
		full_punch_interval = 1.5,
		groups              = { sword = 1 },
	},
	steel       = {
		description         = S("Steel Sword"),
		max_drop_level      = 1,
		snappy              = {
			times    = { [1] = 2.5, [2] = 1.20, [3] = 0.35 },
			uses     = 30,
			maxlevel = 2
		},
		damage_groups       = { fleshy = 5.4 },
		full_punch_interval = 1.20,
		groups              = { steel_item = 1, sword = 1 },
	},
	bronze      = {
		description         = S("Bronze Sword"),
		max_drop_level      = 1,
		snappy              = {
			times    = { [1] = 2.5, [2] = 1.20, [3] = 0.35 },
			uses     = 40,
			maxlevel = 2
		},
		damage_groups       = { fleshy = 4.76 },
		full_punch_interval = 1.4,
		groups              = { bronze_item = 1, sword = 1 },
	},
	copper      = {
		description         = S("Copper Sword"),
		max_drop_level      = 1,
		snappy              = {
			times    = { [1] = 2.5, [2] = 1.20, [3] = 0.35 },
			uses     = 30,
			maxlevel = 2
		},
		damage_groups       = { fleshy = 4.726 },
		full_punch_interval = 1.39,
		groups              = { copper_item = 1, sword = 1 },
	},
	tin         = {
		description         = S("Tin Sword"),
		max_drop_level      = 1,
		snappy              = {
			times    = { [1] = 2.5, [2] = 1.20, [3] = 0.35 },
			uses     = 35,
			maxlevel = 2
		},
		damage_groups       = { fleshy = 3.00 },
		full_punch_interval = 1.00,
		groups              = { tin_item = 1, sword = 1 },
	},
	silver      = {
		description         = S("Silver Sword"),
		max_drop_level      = 1,
		snappy              = {
			times    = { [1] = 2.3, [2] = 1.10, [3] = 0.35 },
			uses     = 30,
			maxlevel = 2
		},
		damage_groups       = { fleshy = 6.8875 },
		full_punch_interval = 1.45,
		groups              = { silver_item = 1, sword = 1 },
	},
	gold        = {
		description         = S("Gold Sword"),
		max_drop_level      = 1,
		snappy              = {
			times    = { [1] = 2.3, [2] = 1.10, [3] = 0.35 },
			uses     = 40,
			maxlevel = 2
		},
		damage_groups       = { fleshy = 6 },
		full_punch_interval = 1.50,
		groups              = { gold_item = 1, sword = 1 },
	},
	galvorn     = {
		description         = S("Galvorn Sword"),
		max_drop_level      = 1,
		snappy              = {
			times    = { [1] = 2.0, [2] = 1.00, [3] = 0.35 },
			uses     = 40,
			maxlevel = 3
		},
		damage_groups       = { fleshy = 7.25 },
		full_punch_interval = 1.45,
		groups              = { forbidden = 1, galvorn_item = 1, sword = 1 },
	},
	mithril     = {
		description         = S("Mithril Sword"),
		max_drop_level      = 1,
		snappy              = {
			times    = { [1] = 0.70, [2] = 0.80, [3] = 0.25 },
			uses     = 80,
			maxlevel = 3
		},
		damage_groups       = { fleshy = 3.5 },
		full_punch_interval = 0.5,
		groups              = { mithril_item = 1, sword = 1 },
	}
}
