local S = lottfarming.get_translator

farming.register_plant("lottfarming:berries", {
	description = S("Berries Seed"),
	harvest_description = S("Berries"),
	seed_inv_img = "lottfarming_seed_berries.png",
	paramtype2 = "meshoptions",
	steps = 4,
<<<<<<< HEAD
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
	fertility = {"soil"},
=======
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"},
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
	groups = {},
	place_param2 = 1,
	on_use = minetest.item_eat(2),
})
