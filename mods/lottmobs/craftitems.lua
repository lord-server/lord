local SL = lord.require_intllib()

minetest.register_craftitem("lottmobs:meat", {
	description = SL("Cooked Meat"),
	inventory_image = "lottmobs_meat.png",
	on_use = minetest.item_eat(1),
})

minetest.register_craftitem("lottmobs:meat_raw", {
	description = SL("Raw Meat"),
	inventory_image = "lottmobs_meat_raw.png",
	on_use = minetest.item_eat(1),
})

minetest.register_craft({
	type = "cooking",
	output = "lottmobs:meat",
	recipe = "lottmobs:meat_raw",
})

minetest.register_craftitem("lottmobs:pork_raw", {
	description = SL("Raw Porkchop"),
	inventory_image = "mobs_pork_raw.png",
	on_use = minetest.item_eat(2),
})

minetest.register_craftitem("lottmobs:pork_cooked", {
	description = SL("Cooked Porkchop"),
	inventory_image = "mobs_pork_cooked.png",
	on_use = minetest.item_eat(2),
})

minetest.register_craft({
	type = "cooking",
	output = "lottmobs:pork_cooked",
	recipe = "lottmobs:pork_raw",
	cooktime = 5,
})


minetest.register_craftitem("lottmobs:dirty_shirt", {
    description = SL("Dirty Jacket"),
    inventory_image = "lottclothes_inv_jacket_midgewater.png^[colorize:#935d3675",
    stack_max = 1,
})

minetest.register_craftitem("lottmobs:dirty_trousers", {
    description = SL("Dirty Trousers"),
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
	description = SL("Spider Poison"),
	inventory_image = "lottmobs_spiderpoison.png",
})


minetest.register_craftitem("lottmobs:fish_raw", {
	description = SL("Raw Fish"),
	inventory_image = "lottmobs_fish_raw.png",
	on_use = minetest.item_eat(1),
})

minetest.register_craftitem("lottmobs:horsemeat_raw", {
	description = SL("Raw Horsemeat"),
	inventory_image = "lottmobs_horsemeat_raw.png",
	on_use = minetest.item_eat(2),
})

minetest.register_craftitem("lottmobs:chiken_raw", {
	description = SL("Raw Chiken"),
	inventory_image = "lottmobs_chiken_raw.png",
	on_use = minetest.item_eat(2),
})

minetest.register_craftitem("lottmobs:rabbit_raw", {
	description = SL("Raw Rabbit"),
	inventory_image = "lottmobs_rabbit_raw.png",
	on_use = minetest.item_eat(1),
})
minetest.register_craftitem("lottmobs:fish_cooked", {
	description = SL("Cooked Fish"),
	inventory_image = "lottmobs_fish_cooked.png",
	on_use = minetest.item_eat(3),
})

minetest.register_craftitem("lottmobs:horsemeat_cooked", {
	description = SL("Cooked Horsemeat"),
	inventory_image = "lottmobs_horsemeat_cooked.png",
	on_use = minetest.item_eat(5),
})

minetest.register_craftitem("lottmobs:chiken_cooked", {
	description = SL("Cooked Chiken"),
	inventory_image = "lottmobs_chiken_cooked.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craftitem("lottmobs:rabbit_cooked", {
	description = SL("Cooked Rabbit"),
	inventory_image = "lottmobs_rabbit_cooked.png",
	on_use = minetest.item_eat(3),
})

minetest.register_craftitem("lottmobs:rabbit_cooked", {
	description = SL("Rotten Meat"),
	inventory_image = "lottmobs_rabbit_cooked.png",
	on_use = minetest.item_eat(2),
})
