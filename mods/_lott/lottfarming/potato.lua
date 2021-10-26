local S = lottfarming.get_translator

farming.register_plant("lottfarming:potato", {
	seed_name = "lottfarming:half_of_potato",
	harvest_name = "lottfarming:potato",
	description = S("Half of Potato"),
	harvest_description = S("Potato"),
	seed_inv_img = "lottfarming_half_of_potato.png",
	groups = {},
	planttype = 1,
	steps = 3,
	paramtype2 = "meshoptions",
<<<<<<< HEAD
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
	fertility = {"soil"},
=======
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"},
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
	place_param2 = 1,
	on_use = minetest.item_eat(1),
})

minetest.register_craftitem("lottfarming:potato_cooked", {
	description = S("Cooked Potato"),
	inventory_image = "lottfarming_potato_cooked.png",
	on_use = minetest.item_eat(5),
})
