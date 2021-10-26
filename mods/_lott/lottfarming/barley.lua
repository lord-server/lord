local S = lottfarming.get_translator

farming.register_plant("lottfarming:barley", {
	harvest_name = "lottfarming:sheaf_barley",
	seed_name = "lottfarming:barley",
	description = S("Barley"),
	harvest_description = S("Sheaf Barley"),
	harvest_inv_img = "lottfarming_sheaf_barley.png",
	seed_inv_img = "lottfarming_barley.png",
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
	on_use = minetest.item_eat(2),
})

minetest.register_craftitem("lottfarming:barley_cooked", {
	description = S("Cooked Barley"),
	inventory_image = "lottfarming_barley_cooked.png",
	on_use = minetest.item_eat(2),
})
