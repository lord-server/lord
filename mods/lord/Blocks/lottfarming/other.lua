local S = minetest.get_mod_translator()

minetest.register_craftitem("lottfarming:cookie_cracker", {
	description     = S("Cracker"),
	inventory_image = "lottfarming_cookie_cracker.png",
	on_use          = minetest.item_eat(14),
	_tt_food_hp     = 14,
})

minetest.register_craft({
	type = "cooking",
	cooktime = 7,
	output = "lottfarming:cookie_cracker",
	recipe = "lottfarming:salted_dough"
})

minetest.register_craft({
	type = "shapeless",
	output = "lottfarming:salted_dough",
	recipe = {"lottores:salt", "lottfarming:dough"},
})

minetest.register_craft({
	type = "shapeless",
	output = "lottfarming:dough",
	recipe = {"lord_vessels:glass_bottle_water", "farming:flour"},
	replacements = {{"lord_vessels:glass_bottle_water", "vessels:glass_bottle"}},
})

minetest.register_craft({
	type = "shapeless",
	output = "lottfarming:yeast_dough",
	recipe = {"group:mushroom", "lottfarming:dough"},
})

minetest.register_craft({
	type = "shapeless",
	output = "lottfarming:dough_with_egg",
	recipe = {"lottmobs:egg", "lottfarming:dough"},
})

minetest.register_craftitem("lottfarming:dough", {
	description     = S("Dough"),
	inventory_image = "lottfarming_dough.png",
	on_use          = minetest.item_eat(2),
	_tt_food_hp     = 2,
})

minetest.register_craftitem("lottfarming:yeast_dough", {
	description     = S("Yeast Dough"),
	inventory_image = "lottfarming_ydough.png",
	on_use          = minetest.item_eat(3),
	_tt_food_hp     = 3,
})

minetest.register_craftitem("lottfarming:salted_dough", {
	description     = S("Salted Dough"),
	inventory_image = "lottfarming_sdough.png",
	on_use          = minetest.item_eat(4),
	_tt_food_hp     = 4,
})

minetest.register_craftitem("lottfarming:dough_with_egg", {
	description     = S("Dough with egg"),
	inventory_image = "lottfarming_dough_with_egg.png",
	on_use          = minetest.item_eat(4),
	_tt_food_hp     = 4,
})

--[[
minetest.register_craftitem("lottfarming:dough_for_sbread", {
	description     = SL("Dough for Shortbread"),
	inventory_image = "lottfarming_sbreaddough.png",
	on_use          = minetest.item_eat(1),
	_tt_food_hp     = 1,
})

minetest.register_craftitem("lottfarming:sugar", {
	description     = SL("Sugar"),
	inventory_image = "lottfarming_suagar.png",
	on_use          = minetest.item_eat(1),
	_tt_food_hp     = 1,
})

minetest.register_craft({
	type = "shapeless",
	output = "lottfarming:sugar",
	recipe = {"default:papyrus"},
})

minetest.register_craft({
	type = "shapeless",
	output = "lottfarming:dough_for_sbread",
	recipe = {"lottmobs:butter", "lottfarming:sugar", "lottfarming:dough"},
})
]]--
