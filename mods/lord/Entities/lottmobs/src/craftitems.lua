local S = minetest.get_mod_translator()

minetest.register_craftitem("lottmobs:meat", {
	description     = S("Cooked Meat"),
	inventory_image = "lottmobs_meat.png",
	on_use          = minetest.item_eat(13),
	_tt_food_hp     = 13,
})

minetest.register_craftitem("lottmobs:meat_raw", {
	description     = S("Raw Meat"),
	inventory_image = "lottmobs_meat_raw.png",
	on_use          = minetest.item_eat(3),
	_tt_food_hp     = 3,
})

minetest.register_craft({
	type = "cooking",
	output = "lottmobs:meat",
	recipe = "lottmobs:meat_raw",
})

minetest.register_craftitem("lottmobs:pork_raw", {
	description     = S("Raw Boar Meat"),
	inventory_image = "mobs_pork_raw.png",
	on_use          = minetest.item_eat(4),
	_tt_food_hp     = 4,
})

minetest.register_craftitem("lottmobs:pork_cooked", {
	description     = S("Cooked Boar Meat"),
	inventory_image = "mobs_pork_cooked.png",
	on_use          = minetest.item_eat(14),
	_tt_food_hp     = 14,
})

minetest.register_craft({
	type = "cooking",
	output = "lottmobs:pork_cooked",
	recipe = "lottmobs:pork_raw",
	cooktime = 5,
})


minetest.register_craftitem("lottmobs:dirty_shirt", {
    description = S("Dirty Jacket"),
    inventory_image = "lottclothes_inv_jacket_midgewater.png^[colorize:#935d3675",
    stack_max = 1,
})

minetest.register_craftitem("lottmobs:dirty_trousers", {
    description = S("Dirty Trousers"),
    inventory_image = "lottclothes_inv_pants_midgewater.png^[colorize:#935d3675",
    stack_max = 1,
})

minetest.register_craft({
    output = "lottclothes:jacket_midgewater",
    type = "shapeless",
    recipe = {"bucket:bucket_water", "lottmobs:dirty_shirt"},
    replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}},
})

minetest.register_craft({
    output = "lottclothes:pants_midgewater",
    type = "shapeless",
    recipe = {"bucket:bucket_water", "lottmobs:dirty_trousers"},
    replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}},
})

minetest.register_craftitem("lottmobs:spiderpoison", {
	description = S("Spider Poison"),
	inventory_image = "lottmobs_spiderpoison.png",
})


minetest.register_craftitem("lottmobs:fish_raw", {
	description     = S("Raw Fish"),
	inventory_image = "lottmobs_fish_raw.png",
	on_use          = minetest.item_eat(2),
	_tt_food_hp     = 2,
})

minetest.register_craftitem("lottmobs:horsemeat_raw", {
	description     = S("Raw Horsemeat"),
	inventory_image = "lottmobs_horsemeat_raw.png",
	on_use          = minetest.item_eat(3),
	_tt_food_hp     = 3,
})

minetest.register_craftitem("lottmobs:chicken_raw", {
	description     = S("Raw Chicken"),
	inventory_image = "lottmobs_chicken_raw.png",
	on_use          = minetest.item_eat(2),
	_tt_food_hp     = 2,
})

minetest.register_craftitem("lottmobs:rabbit_raw", {
	description     = S("Raw Rabbit"),
	inventory_image = "lottmobs_rabbit_raw.png",
	on_use          = minetest.item_eat(2),
	_tt_food_hp     = 2,
})

minetest.register_craftitem("lottmobs:fish_cooked", {
	description     = S("Cooked Fish"),
	inventory_image = "lottmobs_fish_cooked.png",
	on_use          = minetest.item_eat(11),
	_tt_food_hp     = 11,
})

minetest.register_craftitem("lottmobs:horsemeat_cooked", {
	description     = S("Cooked Horsemeat"),
	inventory_image = "lottmobs_horsemeat_cooked.png",
	on_use          = minetest.item_eat(13),
	_tt_food_hp     = 13,
})

minetest.register_craftitem("lottmobs:chicken_cooked", {
	description     = S("Cooked Chiсken"),
	inventory_image = "lottmobs_chicken_cooked.png",
	on_use          = minetest.item_eat(11),
	_tt_food_hp     = 11,
})

minetest.register_craftitem("lottmobs:rabbit_cooked", {
	description     = S("Cooked Rabbit"),
	inventory_image = "lottmobs_rabbit_cooked.png",
	on_use          = minetest.item_eat(9),
	_tt_food_hp     = 9,
})

minetest.register_craftitem("lottmobs:rotten_meat", {
	description     = S("Rotten Meat"),
	inventory_image = "lottmobs_rotten_meat.png",
	on_use          = minetest.item_eat(-6),
	_tt_food_hp     = -6,
})

minetest.register_craftitem("lottmobs:fried_egg", {
	description     = S("Omelette"),
	inventory_image = "lottmobs_fried_egg.png",
	on_use          = minetest.item_eat(5),
	_tt_food_hp     = 5,
})

minetest.register_craft({
	type = "cooking",
	output = "lottmobs:fish_cooked",
	recipe = "lottmobs:fish_raw",
	cooktime = 3,
})

minetest.register_craft({
	type = "cooking",
	output = "lottmobs:horsemeat_cooked",
	recipe = "lottmobs:horsemeat_raw",
	cooktime = 8,
})

minetest.register_craft({
	type = "cooking",
	output = "lottmobs:chicken_cooked",
	recipe = "lottmobs:chicken_raw",
	cooktime = 6,
})

minetest.register_craft({
	type = "cooking",
	output = "lottmobs:rabbit_cooked",
	recipe = "lottmobs:rabbit_raw",
	cooktime = 5,
})

minetest.register_craft({
	type = "cooking",
	output = "lottmobs:fried_egg",
	recipe = "lottmobs:egg",
	cooktime = 3,
})
