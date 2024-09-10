local S = minetest.get_translator("tools")


minetest.register_tool("tools:sword_elven", {
	description       = S("Elven Sword"),
	inventory_image   = "tools_sword_elven.png",
	tool_capabilities = {
		max_drop_level      = 2,
		groupcaps           = { snappy = { times = { [1] = 1.60, [2] = 1.30, [3] = 0.90 }, uses = 50, maxlevel = 3 }, },
		damage_groups       = { soul = 8, fleshy = 6.2 },
		full_punch_interval = 1,
	},
	groups            = { bronze_item = 1 },
})
minetest.register_tool("tools:sword_orc", {
	description       = S("Orcish Sword"),
	inventory_image   = "tools_sword_orc.png",
	tool_capabilities = {
		max_drop_level      = 2,
		groupcaps           = { snappy = { times = { [1] = 2.25, [2] = 1.80, [3] = 1.30 }, uses = 17, maxlevel = 3 }, },
		damage_groups       = { poison = 1.2, fleshy = 7.8 },
		full_punch_interval = 1.2,
	},
	groups            = { steel_item = 1 },
})
minetest.register_tool("tools:battleaxe_dwarven", {
	description       = S("Dwarven Battleaxe"),
	inventory_image   = "castle_battleaxe.png",
	tool_capabilities = {
		max_drop_level      = 1,
		groupcaps           = {
			choppy = { times = { [1] = 2.10, [2] = 0.90, [3] = 0.50 }, uses = 20, maxlevel = 3 },
			snappy = { times = { [1] = 1.90, [2] = 0.90, [3] = 0.30 }, uses = 20, maxlevel = 3 },
		},
		damage_groups       = { fleshy = 25 },
		full_punch_interval = 2.0,
	},
	groups            = { steel_item = 1 },
})
minetest.register_tool("tools:sword_human", {
	description       = S("Human Sword"),
	inventory_image   = "tools_sword_human.png",
	tool_capabilities = {
		max_drop_level      = 2,
		groupcaps           = { snappy = { times = { [1] = 2.25, [2] = 1.80, [3] = 1.30 }, uses = 17, maxlevel = 3 }, },
		damage_groups       = { fire = 2, fleshy = 7.8 },
		full_punch_interval = 1.2,
	},
	groups            = { steel_item = 1 },
})

minetest.register_craft({
	output = 'tools:sword_elven',
	recipe = {
		{ '', 'default:steel_ingot', '' },
		{ 'default:bronze_ingot', 'default:steel_ingot', 'default:bronze_ingot' },
		{ 'default:mese_crystal', 'group:stick', 'default:mese_crystal' },
	}
})
minetest.register_craft({
	output = 'tools:sword_orc',
	recipe = {
		{ '', 'default:steel_ingot', 'default:steel_ingot' },
		{ '', 'lottores:mithril_lump', '' },
		{ '', 'default:mese_crystal', '' },
	}
})
minetest.register_craft({
	output = "tools:battleaxe_dwarven",
	recipe = {
		{ "lottores:mithril_ingot", "default:mese_crystal", "lottores:mithril_ingot" },
		{ "lottores:mithril_ingot", "group:stick",          "lottores:mithril_ingot" },
		{ "",                       "group:stick",          "" }
	}
})


-- @tags: legacy
minetest.register_alias("castle:battleaxe", "tools:battleaxe_dwarven")
