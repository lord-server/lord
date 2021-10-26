<<<<<<< HEAD
local S = lottfarming.get_translator
=======
local S = minetest.get_translator("lottfarming")
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)

farming.register_plant("lottfarming:tomato", {
	harvest_name = "lottfarming:tomato",
	description = S("Tomato Seed"),
	harvest_description = S("Tomato"),
<<<<<<< HEAD
	seed_inv_img = "lottfarming_seed_tomato.png",
=======
	seed_inv_img = "lottfarming_tomato_seed.png",
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
	groups = {salad = 1},
	planttype = 1,
	steps = 4,
	paramtype2 = "meshoptions",
<<<<<<< HEAD
<<<<<<< HEAD
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
	fertility = {"soil"},
=======
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"},
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
=======
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"},
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
	place_param2 = 1,
	on_use = minetest.item_eat(2),
})

minetest.register_craftitem("lottfarming:tomato_cooked", {
	description = S("Cooked Tomato"),
	inventory_image = "lottfarming_tomato_cooked.png",
	on_use = minetest.item_eat(2),
})

minetest.register_craftitem("lottfarming:tomato_soup", {
	description = S("Tomato Soup"),
	inventory_image = "lottfarming_tomato_soup.png",
	on_use = minetest.item_eat(10),
})
