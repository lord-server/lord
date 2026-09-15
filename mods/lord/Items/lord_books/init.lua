dofile(core.get_modpath(core.get_current_modname()) .. "/crafts.lua")
dofile(core.get_modpath(core.get_current_modname()) .. "/cooking.lua")
dofile(core.get_modpath(core.get_current_modname()) .. "/forbidden.lua")
dofile(core.get_modpath(core.get_current_modname()) .. "/protection.lua")
dofile(core.get_modpath(core.get_current_modname()) .. "/potions.lua")
dofile(core.get_modpath(core.get_current_modname()) .. "/alcohol.lua")
dofile(core.get_modpath(core.get_current_modname()) .. "/master.lua")
dofile(core.get_modpath(core.get_current_modname()) .. "/scroll.lua")

core.register_craft({
	output = 'lord_books:crafts_book',
	recipe = {
		{ 'group:stick', 'group:stick', 'group:stick' },
		{ 'group:stick', 'default:book', 'group:stick' },
		{ 'group:stick', 'group:stick', 'group:stick' },
	}
})

core.register_craft({
	type         = "shapeless",
	output       = 'lord_books:cooking_book',
	recipe       = { 'lord_books:crafts_book', 'default:furnace' },
	replacements = { { "default:furnace", "default:furnace" } }
})

core.register_craft({
	output = 'lord_books:protection_book',
	recipe = {
		{ 'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot' },
		{ 'default:steel_ingot', 'lord_books:crafts_book', 'default:steel_ingot' },
		{ 'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot' },
	}
})

core.register_craft({
	type         = "shapeless",
	output       = "lord_books:brewing_book",
	recipe       = { 'barrel:barrel', 'lord_books:cooking_book' },
	replacements = { { "barrel:barrel", "barrel:barrel" } }
})

core.register_craft({
	type         = "shapeless",
	output       = "lord_books:potions_book",
	recipe       = { 'laboratory:laboratory', 'lord_books:cooking_book' },
	replacements = { { "laboratory:laboratory", "laboratory:laboratory" } }
})

core.register_craft({
	output = 'lord_books:forbidden_crafts_book',
	recipe = {
		{ 'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot' },
		{ 'default:gold_ingot', 'lord_books:protection_book', 'default:gold_ingot' },
		{ 'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot' },
	}
})

core.register_craft({
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

core.register_craft({
	output = "lord_books:scroll",
	recipe = {
		{"default:paper", "default:paper"},
		{"", "default:paper"},
		{"default:paper", "default:paper"},
	},
})

core.register_craft({
	output = "lord_books:scroll",
	recipe = {
		{"default:paper", "default:paper"},
		{"default:paper", ""},
		{"default:paper", "default:paper"},
	},
})
