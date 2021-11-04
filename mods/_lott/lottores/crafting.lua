minetest.register_craft({
	type = "shapeless",
	output = "lottores:galvorn_ingot",
	recipe = {"lottores:lead_ingot", "default:mese_crystal"}
})

minetest.register_craft({
	output = 'lottores:tilkal',
	recipe = {
		{'lottores:tilkal_ingot', 'lottores:tilkal_ingot', 'lottores:tilkal_ingot'},
		{'lottores:tilkal_ingot', 'lottores:tilkal_ingot', 'lottores:tilkal_ingot'},
		{'lottores:tilkal_ingot', 'lottores:tilkal_ingot', 'lottores:tilkal_ingot'},
	}
})

minetest.register_craft({
	output = 'lottores:tilkal_ingot 9',
	recipe = {
		{'lottores:tilkal'},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "lottores:tilkal_ingot",
	recipe = {
		"default:copper_ingot",
		"lottores:silver_ingot",
		"lottores:tin_ingot",
		"lottores:lead_ingot",
		"default:steel_ingot",
		"default:gold_ingot",
	}
})

minetest.register_craft({
	output = 'lottores:limestone',
	recipe = {
		{'lottores:limestone_lump', 'lottores:limestone_lump', 'lottores:limestone_lump'},
		{'lottores:limestone_lump', 'lottores:limestone_lump', 'lottores:limestone_lump'},
		{'lottores:limestone_lump', 'lottores:limestone_lump', 'lottores:limestone_lump'},
	}
})

minetest.register_craft({
	output = 'lottores:limestone_lump 9',
	recipe = {
		{'lottores:limestone'},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "lottores:marble",
	recipe = "lottores:limestone",
})

minetest.register_craft({
	type = "cooking",
	output = "lottores:geodes_crystal_1",
	recipe = "lottores:rough_rock_lump",
})

minetest.register_craft({
	output = 'lottores:silver_block',
	recipe = {
		{'lottores:silver_ingot', 'lottores:silver_ingot', 'lottores:silver_ingot'},
		{'lottores:silver_ingot', 'lottores:silver_ingot', 'lottores:silver_ingot'},
		{'lottores:silver_ingot', 'lottores:silver_ingot', 'lottores:silver_ingot'},
	}
})

minetest.register_craft({
	output = 'lottores:silver_ingot 9',
	recipe = {
		{'lottores:silver_block'},
	}
})

minetest.register_craft({
	output = 'lottores:tin_block',
	recipe = {
		{'lottores:tin_ingot', 'lottores:tin_ingot', 'lottores:tin_ingot'},
		{'lottores:tin_ingot', 'lottores:tin_ingot', 'lottores:tin_ingot'},
		{'lottores:tin_ingot', 'lottores:tin_ingot', 'lottores:tin_ingot'},
	}
})

minetest.register_craft({
	output = 'lottores:tin_ingot 9',
	recipe = {
		{'lottores:tin_block'},
	}
})

minetest.register_craft({
	output = 'lottores:lead_block',
	recipe = {
		{'lottores:lead_ingot', 'lottores:lead_ingot', 'lottores:lead_ingot'},
		{'lottores:lead_ingot', 'lottores:lead_ingot', 'lottores:lead_ingot'},
		{'lottores:lead_ingot', 'lottores:lead_ingot', 'lottores:lead_ingot'},
	}
})

minetest.register_craft({
	output = 'lottores:lead_ingot 9',
	recipe = {
		{'lottores:lead_block'},
	}
})

minetest.register_craft({
	output = 'lottores:mithril_block',
	recipe = {
		{'lottores:mithril_ingot', 'lottores:mithril_ingot', 'lottores:mithril_ingot'},
		{'lottores:mithril_ingot', 'lottores:mithril_ingot', 'lottores:mithril_ingot'},
		{'lottores:mithril_ingot', 'lottores:mithril_ingot', 'lottores:mithril_ingot'},
	}
})

minetest.register_craft({
	output = 'lottores:mithril_ingot 9',
	recipe = {
		{'lottores:mithril_block'},
	}
})

minetest.register_craft({
	output = 'lottores:galvorn_block',
	recipe = {
		{'lottores:galvorn_ingot', 'lottores:galvorn_ingot', 'lottores:galvorn_ingot'},
		{'lottores:galvorn_ingot', 'lottores:galvorn_ingot', 'lottores:galvorn_ingot'},
		{'lottores:galvorn_ingot', 'lottores:galvorn_ingot', 'lottores:galvorn_ingot'},
	}
})

minetest.register_craft({
	output = 'lottores:galvorn_ingot 9',
	recipe = {
		{'lottores:galvorn_block'},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "lottores:ithildin_1",
	recipe = {"lottores:mithril_ingot", "lottores:geodes_crystal_1"}
})

minetest.register_craft({
	type = "shapeless",
	output = "lottores:ithildin_stone_1",
	recipe = {"lottores:ithildin_1", "group:stone"}
})

minetest.register_craft({
	type = "shapeless",
	output = "lottores:ithildin_lamp_1",
	recipe = {"lottores:mithril_ingot", "lottother:blue_torch"}
})

minetest.register_craft({
	type = "shapeless",
	output = "lottores:ithildin_stonelamp_1",
	recipe = {"lottores:ithildin_lamp_1", "group:stone"}
})

minetest.register_craft( {
	output = 'lottores:pearl_block',
	recipe = {
		{ 'craft "lottores:pearl"', 'craft "lottores:pearl"', 'craft "lottores:pearl"' },
		{ 'craft "lottores:pearl"', 'craft "lottores:pearl"', 'craft "lottores:pearl"' },
		{ 'craft "lottores:pearl"', 'craft "lottores:pearl"', 'craft "lottores:pearl"' },
	}
})

minetest.register_craft({
	output = 'lottores:salt_block',
	recipe = {
		{'lottores:salt', 'lottores:salt', 'lottores:salt'},
		{'lottores:salt', 'lottores:salt', 'lottores:salt'},
		{'lottores:salt', 'lottores:salt', 'lottores:salt'},
	}
})

minetest.register_craft({
	output = 'lottores:salt 9',
	recipe = {
		{'lottores:salt_block'},
	}
})

minetest.register_craft({
	output = 'lottores:pearl_block',
	recipe = {
		{'lottores:pearl', 'lottores:pearl', 'lottores:pearl'},
		{'lottores:pearl', 'lottores:pearl', 'lottores:pearl'},
		{'lottores:pearl', 'lottores:pearl', 'lottores:pearl'},
	}
})

minetest.register_craft({
	output = 'lottores:pearl 9',
	recipe = {
		{'lottores:pearl_block'},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "lottores:silver_ingot",
	recipe = "lottores:silver_lump",
})
minetest.register_craft({
	type = "cooking",
	output = "lottores:silver_ingot",
	recipe = "group:silver_item",
})

minetest.register_craft({
	type = "cooking",
	output = "lottores:mithril_ingot",
	recipe = "lottores:mithril_lump",
})
minetest.register_craft({
	type = "cooking",
	output = "lottores:mithril_ingot",
	recipe = "group:mithril_item",
})

minetest.register_craft({
	type = "cooking",
	output = "lottores:tin_ingot",
	recipe = "lottores:tin_lump",
})
minetest.register_craft({
	type = "cooking",
	output = "lottores:tin_ingot",
	recipe = "group:tin_item",
})

minetest.register_craft({
	type = "cooking",
	output = "lottores:lead_ingot",
	recipe = "lottores:lead_lump",
})
minetest.register_craft({
	type = "cooking",
	output = "lottores:lead_ingot",
	recipe = "group:lead_item",
})

minetest.register_craft({
	type = "cooking",
	output = "lottores:galvorn_ingot",
	recipe = "group:galvorn_item",
})
