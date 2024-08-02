local SL = minetest.get_translator("tools")

return {
	get_recipes = function(source)
		return {{
			{source, 'group:stick', source},
			{source, 'group:stick', source},
			{'', 'group:stick', ''},
		}}
	end,
	wood        = {
		description         = SL("Wooden Battleaxe"),
		max_drop_level      = 1,
		choppy              = { times = { [1] = 3.75, [2] = 2.75, [3] = 2.05 }, uses = 5, maxlevel = 1 },
		snappy              = { times = { [1] = 2.75, [2] = 1.75, [3] = 0.75 }, uses = 5, maxlevel = 1 },
		damage_groups       = { fleshy = 4.65 },
		full_punch_interval = 1.55,
		groups              = { wooden = 1 },
	},
	stone       = {
		description         = SL("Stone Battleaxe"),
		max_drop_level      = 1,
		choppy              = { times = { [1] = 3.35, [2] = 2.10, [3] = 1.85 }, uses = 5, maxlevel = 1 },
		snappy              = { times = { [1] = 2.75, [2] = 1.75, [3] = 0.75 }, uses = 5, maxlevel = 1 },
		damage_groups       = { fleshy = 6.00 },
		full_punch_interval = 1.60,
	},
	steel       = {
		description         = SL("Steel Battleaxe"),
		max_drop_level      = 1,
		choppy              = { times = { [1] = 3, [2] = 1.90, [3] = 1.50 }, uses = 15, maxlevel = 2 },
		snappy              = { times = { [1] = 2.75, [2] = 1.45, [3] = 0.60 }, uses = 25, maxlevel = 2 },
		damage_groups       = { fleshy = 7.00 },
		full_punch_interval = 1.75,
		groups              = { steel_item = 1 },
	},
	bronze      = {
		description         = SL("Bronze Battleaxe"),
		max_drop_level      = 1,
		choppy              = { times = { [1] = 2.80, [2] = 1.70, [3] = 1.30 }, uses = 20, maxlevel = 2 },
		snappy              = { times = { [1] = 2.55, [2] = 1.25, [3] = 0.50 }, uses = 30, maxlevel = 2 },
		damage_groups       = { fleshy = 8.1 },
		full_punch_interval = 1.80,
		groups              = { bronze_item = 1 },
	},
	copper      = {
		description         = SL("Copper Battleaxe"),
		max_drop_level      = 1,
		choppy              = { times = { [1] = 3.25, [2] = 2.00, [3] = 1.75 }, uses = 5, maxlevel = 1 },
		snappy              = { times = { [1] = 2.75, [2] = 1.45, [3] = 0.60 }, uses = 10, maxlevel = 1 },
		damage_groups       = { fleshy = 7.88 },
		full_punch_interval = 1.79,
		groups              = { copper_item = 1 },
	},
	tin         = {
		description         = SL("Tin Battleaxe"),
		max_drop_level      = 1,
		choppy              = { times = { [1] = 3.25, [2] = 2.00, [3] = 1.75 }, uses = 5, maxlevel = 1 },
		snappy              = { times = { [1] = 2.75, [2] = 1.45, [3] = 0.60 }, uses = 10, maxlevel = 1 },
		damage_groups       = { fleshy = 6.6 },
		full_punch_interval = 1.65,
		groups              = { tin_item = 1 },
	},
	silver      = {
		description         = SL("Silver Battleaxe"),
		max_drop_level      = 1,
		choppy              = { times = { [1] = 2.80, [2] = 1.70, [3] = 1.30 }, uses = 15, maxlevel = 2 },
		snappy              = { times = { [1] = 2.60, [2] = 1.30, [3] = 0.50 }, uses = 25, maxlevel = 2 },
		damage_groups       = { fleshy = 10.18 },
		full_punch_interval = 1.85,
		groups              = { silver_item = 1 },
	},
	gold        = {
		description         = SL("Gold Battleaxe"),
		max_drop_level      = 1,
		choppy              = { times = { [1] = 2.80, [2] = 1.70, [3] = 1.30 }, uses = 20, maxlevel = 2 },
		snappy              = { times = { [1] = 2.60, [2] = 1.30, [3] = 0.50 }, uses = 30, maxlevel = 2 },
		damage_groups       = { fleshy = 9.5 },
		full_punch_interval = 1.90,
		groups              = { gold_item = 1 },
	},
	galvorn     = {
		description         = SL("Galvorn Battleaxe"),
		max_drop_level      = 1,
		choppy              = { times = { [1] = 2.50, [2] = 1.50, [3] = .90 }, uses = 25, maxlevel = 2 },
		snappy              = { times = { [1] = 2.50, [2] = 1.50, [3] = 0.85 }, uses = 35, maxlevel = 2 },
		damage_groups       = { fleshy = 12 },
		full_punch_interval = 1.80,
		groups              = { forbidden = 1, galvorn_item = 1 },
	},
	mithril     = {
		description         = SL("Mithril Battleaxe"),
		max_drop_level      = 1,
		choppy              = { times = { [1] = 2, [2] = 1, [3] = .50 }, uses = 35, maxlevel = 3 },
		snappy              = { times = { [1] = 1, [2] = 1.10, [3] = 0.50 }, uses = 40, maxlevel = 3 },
		damage_groups       = { fleshy = 12 },
		full_punch_interval = 1.55,
		groups              = { mithril_item = 1 },
	}
}