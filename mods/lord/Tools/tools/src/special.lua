local S = minetest.get_translator('tools')


minetest.register_tool('tools:sword_elven', {
	description       = S('Elven Sword'),
	inventory_image   = 'tools_sword_elven.png',
	tool_capabilities = {
		max_drop_level      = 2,
		groupcaps           = { snappy = { times = { [1] = 1.60, [2] = 1.30, [3] = 0.90 }, uses = 50, maxlevel = 3 }, },
		damage_groups       = { soul = 8, fleshy = 6.2 },
		full_punch_interval = 1,
	},
	groups            = { bronze_item = 1, forbidden = 1 },
})
minetest.register_tool('tools:sword_orc', {
	description       = S('Orcish Sword'),
	inventory_image   = 'tools_sword_orc.png',
	tool_capabilities = {
		max_drop_level      = 2,
		groupcaps           = { snappy = { times = { [1] = 2.25, [2] = 1.80, [3] = 1.30 }, uses = 17, maxlevel = 3 }, },
		damage_groups       = { poison = 1.2, fleshy = 7.8 },
		full_punch_interval = 1.2,
	},
	groups            = { steel_item = 1, forbidden = 1 },
})
minetest.register_tool('tools:battleaxe_dwarven', {
	description       = S('Dwarven Battleaxe'),
	inventory_image   = 'castle_battleaxe.png',
	tool_capabilities = {
		max_drop_level      = 1,
		groupcaps           = {
			choppy = { times = { [1] = 2.10, [2] = 0.90, [3] = 0.50 }, uses = 20, maxlevel = 3 },
			snappy = { times = { [1] = 1.90, [2] = 0.90, [3] = 0.30 }, uses = 20, maxlevel = 3 },
		},
		damage_groups       = { fleshy = 25 },
		full_punch_interval = 2.0,
	},
	groups            = { steel_item = 1, forbidden = 1 },
})
minetest.register_tool('tools:sword_human', {
	description       = S('Human Sword'),
	inventory_image   = 'tools_sword_human.png',
	tool_capabilities = {
		max_drop_level      = 2,
		groupcaps           = { snappy = { times = { [1] = 2.25, [2] = 1.80, [3] = 1.30 }, uses = 17, maxlevel = 3 }, },
		damage_groups       = { fire = 2, fleshy = 7.8 },
		full_punch_interval = 1.2,
	},
	groups            = { mithril_item = 1, forbidden = 1 },
})

minetest.register_tool('tools:dagger_hobbit', {
	description         = S('Hobbit Dagger'),
	inventory_image     = 'tools_dagger_hobbit.png',
	range               = 2,
	tool_capabilities = {
		max_drop_level      = 0,
		groupcaps           = { snappy = { times = { [2] = 2.25, [3] = 1.75 }, uses = 2, maxlevel = 1 }, },
		damage_groups       = { fleshy = 2 },
		full_punch_interval = .2
	},
	groups            = { mithril_item = 1, forbidden = 1 },
})

minetest.register_craft({
	method = minetest.CraftMethod.ANVIL,
	output = 'tools:sword_elven',
	recipe = {
		{ '',                     'default:steel_ingot', ''                     },
		{ 'default:bronze_ingot', 'default:steel_ingot', 'default:bronze_ingot' },
		{ 'default:mese_crystal', 'group:stick',         'default:mese_crystal' },
	}
})
minetest.register_mirrored_crafts({
	method = minetest.CraftMethod.ANVIL,
	output = 'tools:sword_orc',
	recipe = {
		{ '', 'default:steel_ingot', 'default:steel_ingot' },
		{ '', 'lottores:mithril_lump', '' },
		{ '', 'default:mese_crystal', '' },
	}
})
minetest.register_craft({
	method = minetest.CraftMethod.ANVIL,
	output = 'tools:battleaxe_dwarven',
	recipe = {
		{ 'lottores:mithril_ingot', 'default:mese_crystal', 'lottores:mithril_ingot' },
		{ 'lottores:mithril_ingot', 'group:stick',          'lottores:mithril_ingot' },
		{ '',                       'group:stick',          '' }
	}
})
minetest.register_craft({
	method = minetest.CraftMethod.ANVIL,
	output = 'tools:sword_human',
	recipe = {
		{ '',                  'lottores:mithril_ingot', ''                  },
		{ 'lottores:red_gem',  'lottores:mithril_ingot', 'lottores:red_gem'  },
		{ 'lottores:blue_gem', 'group:stick',            'lottores:blue_gem' },
	}
})
minetest.register_craft({
	method = minetest.CraftMethod.ANVIL,
	output = 'tools:dagger_hobbit',
	recipe = {
		{ '',                     'default:mese_crystal', ''                     },
		{ 'default:mese_crystal', 'tools:dagger_mithril', 'default:mese_crystal' },
		{ '',                     '',                     ''                     }
	},
})


-- @tags: legacy
minetest.register_alias('castle:battleaxe', 'tools:battleaxe_dwarven')
