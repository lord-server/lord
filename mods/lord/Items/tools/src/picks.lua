local S = core.get_mod_translator()


--- pick      base   by formula (`times[n]=speed*1.5^(n-1)`)
--- ------------------------------------------------------------------
--- wood      -      no mineable — can't mine ore (only stone and coal)
--- stone     2.00   [1]=2.00
--- copper    1.45   [1]=1.45 [2]=2.17
--- tin       1.45   [1]=1.45 [2]=2.17
--- steel     1.05   [1]=1.05 [2]=1.58 [3]=2.36
--- bronze    0.90   [1]=0.90 [2]=1.35 [3]=2.03
--- silver    0.75   [1]=0.75 [2]=1.13 [3]=1.69 [4]=2.53
--- gold      0.75   [1]=0.75 [2]=1.13 [3]=1.69 [4]=2.53
--- galvorn   0.55   [1]=0.55 [2]=0.83 [3]=1.24 [4]=1.86 [5]=2.78
--- mithril   0.40   [1]=0.40 [2]=0.60 [3]=0.90 [4]=1.35 [5]=2.02

--- * `_durability` -> `uses`
--- * `_speed`/`_tier` -> `mineable.times`
--- в `tools/init.lua`: `times[n] = _speed * 1.5^(n-1)`, n = 1..`_tier`.
--- @type table<string, { durability: integer, speed: number?, tier: integer? }>
local stats = {
	wood    = { durability = 30 },
	stone   = { durability = 60,   speed = 2.00, tier = 1 },
	copper  = { durability = 120,  speed = 1.45, tier = 2 },
	tin     = { durability = 150,  speed = 1.45, tier = 2 },
	steel   = { durability = 240,  speed = 1.05, tier = 3 },
	bronze  = { durability = 330,  speed = 0.90, tier = 3 },
	silver  = { durability = 480,  speed = 0.75, tier = 4 },
	gold    = { durability = 600,  speed = 0.75, tier = 4 },
	galvorn = { durability = 960,  speed = 0.55, tier = 5 },
	mithril = { durability = 1620, speed = 0.40, tier = 5 },
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
		_durability         = stats.wood.durability,
		full_punch_interval = 1.2,
		max_drop_level      = 0,
		cracky              = {
			times = { [3]=1.60 },
			maxlevel = 1
		},
		damage_groups       = { fleshy = 2 },
		groups              = { wooden = 1, pickaxe = 1, flammable = 2 },
	},
	-- tier 1
	stone = {
		description         = S("Stone Pickaxe"),
		_rank               = item_rank.Type.COMMON,
		_durability         = stats.stone.durability,
		_speed              = stats.stone.speed,
		_tier               = stats.stone.tier,
		full_punch_interval = 1.3,
		max_drop_level      = 0,
		cracky              = {
			times = { [2]=2.0, [3]=1.20 },
			maxlevel = 1
		},
		mineable            = {
			maxlevel = 0
		},
		damage_groups       = { fleshy = 3 },
		groups              = { pickaxe = 1 },
	},
	-- tier 2
	copper = {
		description         = S("Copper Pickaxe"),
		_rank               = item_rank.Type.ADVANCED,
		_durability         = stats.copper.durability,
		_speed              = stats.copper.speed,
		_tier               = stats.copper.tier,
		full_punch_interval = 1.0,
		max_drop_level      = 1,
		cracky              = {
			times = { [1]=4.00, [2]=1.60, [3]=0.80 },
			maxlevel = 2
		},
		mineable            = {
			maxlevel = 0
		},
		damage_groups       = { fleshy = 4 },
		groups              = { copper_item = 1, pickaxe = 1 },
	},
	tin = {
		description         = S("Tin Pickaxe"),
		_rank               = item_rank.Type.ADVANCED,
		_durability         = stats.tin.durability,
		_speed              = stats.tin.speed,
		_tier               = stats.tin.tier,
		full_punch_interval = 1.0,
		max_drop_level      = 1,
		cracky              = {
			times = { [1]=4.00, [2]=1.60, [3]=0.80 },
			maxlevel = 2
		},
		mineable            = {
			maxlevel = 0
		},
		damage_groups       = {fleshy=4},
		groups              = {tin_item = 1, pickaxe = 1},
	},
	-- tier 3
	steel = {
		description         = S("Steel Pickaxe"),
		_rank               = item_rank.Type.RARE,
		_durability         = stats.steel.durability,
		_speed              = stats.steel.speed,
		_tier               = stats.steel.tier,
		full_punch_interval = 1.0,
		max_drop_level      = 1,
		cracky              = {
			times = { [1]=4.00, [2]=1.60, [3]=0.80 },
			maxlevel = 2
		},
		mineable            = {
			maxlevel = 0
		},
		damage_groups       = { fleshy = 4 },
		groups              = { steel_item = 1, pickaxe = 1 },
	},
	bronze = {
		description         = S("Bronze Pickaxe"),
		_rank               = item_rank.Type.RARE,
		_durability         = stats.bronze.durability,
		_speed              = stats.bronze.speed,
		_tier               = stats.bronze.tier,
		full_punch_interval = 1.0,
		max_drop_level      = 1,
		cracky              = {
			times = { [1]=4.00, [2]=1.60, [3]=0.80 },
			maxlevel = 2
		},
		mineable            = {
			maxlevel = 0
		},
		damage_groups       = { fleshy=4 },
		groups              = { bronze_item = 1, pickaxe = 1 },
	},
	-- tier 4
	silver = {
		description         = S("Silver Pickaxe"),
		_rank               = item_rank.Type.EPIC,
		_durability         = stats.silver.durability,
		_speed              = stats.silver.speed,
		_tier               = stats.silver.tier,
		full_punch_interval = 1.0,
		max_drop_level      = 2,
		cracky              = {
			times = { [1]=3.00, [2]=1.40, [3]=0.70 },
			maxlevel = 2
		},
		mineable            = {
			maxlevel = 0
		},
		damage_groups       = { fleshy = 4 },
		groups              = { silver_item = 1, pickaxe = 1 },
	},
	gold = {
		description         = S("Gold Pickaxe"),
		_rank               = item_rank.Type.EPIC,
		_durability         = stats.gold.durability,
		_speed              = stats.gold.speed,
		_tier               = stats.gold.tier,
		full_punch_interval = 1.0,
		max_drop_level      = 2,
		cracky              = {
			times = { [1]=3.00, [2]=1.40, [3]=0.70 },
			maxlevel = 2
		},
		mineable            = {
			maxlevel = 0
		},
		damage_groups       = { fleshy = 4 },
		groups              = { gold_item = 1, pickaxe = 1 },
	},
	-- tier 5
	galvorn = {
		description         = S("Galvorn Pickaxe"),
		_rank               = item_rank.Type.LEGENDARY,
		_durability         = stats.galvorn.durability,
		_speed              = stats.galvorn.speed,
		_tier               = stats.galvorn.tier,
		full_punch_interval = 0.9,
		max_drop_level      = 3,
		cracky              = {
			times = { [1]=2.4, [2]=1.2, [3]=0.60 },
			maxlevel = 3
		},
		mineable            = {
			maxlevel = 0
		},
		damage_groups       = { fleshy = 5 },
		groups              = { forbidden = 1, galvorn_item = 1, pickaxe = 1 },
	},
	mithril = {
		description         = S("Mithril Pickaxe"),
		_rank               = item_rank.Type.LEGENDARY,
		_durability         = stats.mithril.durability,
		_speed              = stats.mithril.speed,
		_tier               = stats.mithril.tier,
		full_punch_interval = 0.8,
		max_drop_level      = 3,
		cracky              = {
			times = { [1]=1.5, [2]=0.8, [3]=0.40 },
			maxlevel = 3
		},
		mineable            = {
			maxlevel = 0
		},
		damage_groups       = { fleshy = 5 },
		groups              = { mithril_item = 1, pickaxe = 1 },
	}
}
