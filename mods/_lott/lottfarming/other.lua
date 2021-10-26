<<<<<<< HEAD
local S = lottfarming.get_translator
=======
local S = minetest.get_transator("lottfarming")
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)

minetest.register_craftitem("lottfarming:cookie_cracker", {
	description = S("Cracker"),
	inventory_image = "lottfarming_cookie_cracker.png",
	on_use = minetest.item_eat(2),
})

minetest.register_craft({
	type = "cooking",
	cooktime = 7,
	output = "lottfarming:cookie_cracker 4",
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
	recipe = {"lottpotion:glass_bottle_water", "farming:flour"},
	replacements = {{"lottpotion:glass_bottle_water", "vessels:glass_bottle"}},
})

minetest.register_craft({
	type = "shapeless",
	output = "lottfarming:yeast_dough",
	recipe = {"group:mushroom", "lottfarming:dough"},
})

minetest.register_craftitem("lottfarming:dough", {
	description = S("Dough"),
	inventory_image = "lottfarming_dough.png",
})

minetest.register_craftitem("lottfarming:yeast_dough", {
	description = S("Yeast Dough"),
	inventory_image = "lottfarming_yeast_dough.png",
})

minetest.register_craftitem("lottfarming:salted_dough", {
	description = S("Salted Dough"),
	inventory_image = "lottfarming_salted_dough.png",
})
