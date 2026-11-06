local S = core.get_mod_translator()


--- @type table<string, integer>
local durability = {
	wood    = 30,
	stone   = 60,
	steel   = 180,
	bronze  = 270,
	copper  = 180,
	tin     = 225,
	silver  = 180,
	gold    = 270,
	galvorn = 810,
	mithril = 1620,
}


return {
	get_recipes = function(source)
		return {{
			{source, source, source},
			{'', 'group:stick', ''},
			{'', 'group:stick', ''},
		}}
	end,
	wood = {
		description         = S("Wooden Pickaxe"),
		_rank               = item_rank.Type.COMMON,
		_durability         = durability.wood,
		full_punch_interval = 1.2,
		max_drop_level      = 0,
		cracky              = {
			times = { [3]=1.60 },
			maxlevel = 1
		},
		damage_groups       = { fleshy = 2 },
		groups              = { wooden = 1, pickaxe = 1, flammable = 2 },
	},
	stone = {
		description         = S("Stone Pickaxe"),
		_rank               = item_rank.Type.COMMON,
		_durability         = durability.stone,
		full_punch_interval = 1.3,
		max_drop_level      = 0,
		cracky              = {
			times = { [2]=2.0, [3]=1.20 },
			maxlevel = 1
		},
		mineable            = {
			times    = { [1]=2.0 },
			maxlevel = 0
		},
		damage_groups       = { fleshy = 3 },
		groups              = { pickaxe = 1 },
	},
	steel = {
		description         = S("Steel Pickaxe"),
		_rank               = item_rank.Type.RARE,
		_durability         = durability.steel,
		full_punch_interval = 1.0,
		max_drop_level      = 1,
		cracky              = {
			times = { [1]=4.00, [2]=1.60, [3]=0.80 },
			maxlevel = 2
		},
		mineable            = {
			times    = { [1]=1.00, [2]=1.60, [3]=2.40 },
			maxlevel = 0
		},
		damage_groups       = { fleshy = 4 },
		groups              = { steel_item = 1, pickaxe = 1 },
	},
	bronze = {
		description         = S("Bronze Pickaxe"),
		_rank               = item_rank.Type.RARE,
		_durability         = durability.bronze,
		full_punch_interval = 1.0,
		max_drop_level      = 1,
		cracky              = {
			times = { [1]=4.00, [2]=1.60, [3]=0.80 },
			maxlevel = 2
		},
		mineable            = {
			times    = { [1]=1.00, [2]=1.60, [3]=2.40 },
			maxlevel = 0
		},
		damage_groups       = { fleshy=4 },
		groups              = { bronze_item = 1, pickaxe = 1 },
	},
	copper = {
		description         = S("Copper Pickaxe"),
		_rank               = item_rank.Type.ADVANCED,
		_durability         = durability.copper,
		full_punch_interval = 1.0,
		max_drop_level      = 1,
		cracky              = {
			times = { [1]=4.00, [2]=1.60, [3]=0.80 },
			maxlevel = 2
		},
		mineable            = {
			times    = { [1]=1.60, [2]=2.40 },
			maxlevel = 0
		},
		damage_groups       = { fleshy = 4 },
		groups              = { copper_item = 1, pickaxe = 1 },
	},
	tin = {
		description         = S("Tin Pickaxe"),
		_rank               = item_rank.Type.ADVANCED,
		_durability         = durability.tin,
		full_punch_interval = 1.0,
		max_drop_level      = 1,
		cracky              = {
			times = { [1]=4.00, [2]=1.60, [3]=0.80 },
			maxlevel = 2
		},
		mineable            = {
			times    = { [1]=1.60, [2]=2.40 },
			maxlevel = 0
		},
		damage_groups       = {fleshy=4},
		groups              = {tin_item = 1, pickaxe = 1},
	},
	silver = {
		description         = S("Silver Pickaxe"),
		_rank               = item_rank.Type.EPIC,
		_durability         = durability.silver,
		full_punch_interval = 1.0,
		max_drop_level      = 2,
		cracky              = {
			times = { [1]=3.00, [2]=1.40, [3]=0.70 },
			maxlevel = 2
		},
		mineable            = {
			times    = { [1]=0.80, [2]=1.20, [3]=1.80, [4]=2.60 },
			maxlevel = 0
		},
		damage_groups       = { fleshy = 4 },
		groups              = { silver_item = 1, pickaxe = 1 },
	},
	gold = {
		description         = S("Gold Pickaxe"),
		_rank               = item_rank.Type.EPIC,
		_durability         = durability.gold,
		full_punch_interval = 1.0,
		max_drop_level      = 2,
		cracky              = {
			times = { [1]=3.00, [2]=1.40, [3]=0.70 },
			maxlevel = 2
		},
		mineable            = {
			times    = { [1]=0.80, [2]=1.20, [3]=1.80, [4]=2.60 },
			maxlevel = 0
		},
		damage_groups       = { fleshy = 4 },
		groups              = { gold_item = 1, pickaxe = 1 },
	},
	galvorn = {
		description         = S("Galvorn Pickaxe"),
		_rank               = item_rank.Type.LEGENDARY,
		_durability         = durability.galvorn,
		full_punch_interval = 0.9,
		max_drop_level      = 3,
		cracky              = {
			times = { [1]=2.4, [2]=1.2, [3]=0.60 },
			maxlevel = 3
		},
		mineable            = {
			times    = { [1]=0.60, [2]=0.90, [3]=1.30, [4]=1.80, [5]=2.60 },
			maxlevel = 0
		},
		damage_groups       = { fleshy = 5 },
		groups              = { forbidden = 1, galvorn_item = 1, pickaxe = 1 },
	},
	mithril = {
		description         = S("Mithril Pickaxe"),
		_rank               = item_rank.Type.LEGENDARY,
		_durability         = durability.mithril,
		full_punch_interval = 0.8,
		max_drop_level      = 3,
		cracky              = {
			times = { [1]=1.5, [2]=0.8, [3]=0.40 },
			maxlevel = 3
		},
		mineable            = {
			times    = { [1]=0.40, [2]=0.60, [3]=0.90, [4]=1.30, [5]=1.80 },
			maxlevel = 0
		},
		damage_groups       = { fleshy = 5 },
		groups              = { mithril_item = 1, pickaxe = 1 },
	}
}
