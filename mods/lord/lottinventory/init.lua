dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/zcg.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/cooking.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/forbidden.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/protection.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/potions.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/brewing.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/master.lua")


minetest.register_craft({
	output = 'lottinventory:crafts_book',
	recipe = {
		{ 'group:stick', 'group:stick', 'group:stick' },
		{ 'group:stick', 'default:book', 'group:stick' },
		{ 'group:stick', 'group:stick', 'group:stick' },
	}
})

minetest.register_craft({
	type         = "shapeless",
	output       = 'lottinventory:cooking_book',
	recipe       = { 'lottinventory:crafts_book', 'default:furnace' },
	replacements = { { "default:furnace", "default:furnace" } }
})

minetest.register_craft({
	output = 'lottinventory:protection_book',
	recipe = {
		{ 'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot' },
		{ 'default:steel_ingot', 'lottinventory:crafts_book', 'default:steel_ingot' },
		{ 'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot' },
	}
})

minetest.register_craft({
	type         = "shapeless",
	output       = "lottinventory:brewing_book",
	recipe       = { 'lottpotion:brewer', 'lottinventory:cooking_book' },
	replacements = { { "lottpotion:brewer", "lottpotion:brewer" } }
})

minetest.register_craft({
	type         = "shapeless",
	output       = "lottinventory:potions_book",
	recipe       = { 'lottpotion:potion_brewer', 'lottinventory:cooking_book' },
	replacements = { { "lottpotion:potion_brewer", "lottpotion:potion_brewer" } }
})

minetest.register_craft({
	output = 'lottinventory:forbidden_crafts_book',
	recipe = {
		{ 'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot' },
		{ 'default:gold_ingot', 'lottinventory:protection_book', 'default:gold_ingot' },
		{ 'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot' },
	}
})

minetest.register_craft({
	type   = "shapeless",
	output = "lottinventory:master_book",
	recipe = {
		'lottinventory:cooking_book',
		'lottinventory:potions_book',
		'lottores:tilkal_ingot',
		'lottinventory:protection_book',
		'lottinventory:forbidden_crafts_book',
		'lottores:mithril_ingot',
		'lottinventory:crafts_book',
		'lottinventory:brewing_book',
		'lottores:tilkal_ingot',
	}
})
