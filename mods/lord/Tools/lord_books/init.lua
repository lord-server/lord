dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/crafts.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/cooking.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/forbidden.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/protection.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/potions.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/brewing.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/master.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/scroll.lua")

minetest.register_craft({
	output = 'lord_books:crafts_book',
	recipe = {
		{ 'group:stick', 'group:stick', 'group:stick' },
		{ 'group:stick', 'default:book', 'group:stick' },
		{ 'group:stick', 'group:stick', 'group:stick' },
	}
})

minetest.register_craft({
	type         = "shapeless",
	output       = 'lord_books:cooking_book',
	recipe       = { 'lord_books:crafts_book', 'default:furnace' },
	replacements = { { "default:furnace", "default:furnace" } }
})

minetest.register_craft({
	output = 'lord_books:protection_book',
	recipe = {
		{ 'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot' },
		{ 'default:steel_ingot', 'lord_books:crafts_book', 'default:steel_ingot' },
		{ 'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot' },
	}
})

minetest.register_craft({
	type         = "shapeless",
	output       = "lord_books:brewing_book",
	recipe       = { 'lottpotion:brewer', 'lord_books:cooking_book' },
	replacements = { { "lottpotion:brewer", "lottpotion:brewer" } }
})

minetest.register_craft({
	type         = "shapeless",
	output       = "lord_books:potions_book",
	recipe       = { 'lottpotion:potion_brewer', 'lord_books:cooking_book' },
	replacements = { { "lottpotion:potion_brewer", "lottpotion:potion_brewer" } }
})

minetest.register_craft({
	output = 'lord_books:forbidden_crafts_book',
	recipe = {
		{ 'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot' },
		{ 'default:gold_ingot', 'lord_books:protection_book', 'default:gold_ingot' },
		{ 'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot' },
	}
})

minetest.register_craft({
	type   = "shapeless",
	output = "lord_books:master_book",
	recipe = {
		'lord_books:cooking_book',
		'lord_books:potions_book',
		'lottores:tilkal_ingot',
		'lord_books:protection_book',
		'lord_books:forbidden_crafts_book',
		'lottores:mithril_ingot',
		'lord_books:crafts_book',
		'lord_books:brewing_book',
		'lottores:tilkal_ingot',
	}
})

minetest.register_craft({
	output = "lord_books:scroll",
	recipe = {
		{"default:paper", "default:paper"},
		{"", "default:paper"},
		{"default:paper", "default:paper"},
	},
})

minetest.register_craft({
	output = "lord_books:scroll",
	recipe = {
		{"default:paper", "default:paper"},
		{"default:paper", ""},
		{"default:paper", "default:paper"},
	},
})
