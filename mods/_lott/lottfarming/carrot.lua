local S = lottfarming.get_translator

farming.register_plant("lottfarming:carrot", {
	description = S("Carrot Seed"),
	harvest_description = S("Carrot"),
	seed_inv_img = "lottfarming_seed_carrot.png",
	paramtype2 = "meshoptions",
	steps = 4,
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
	fertility = {"soil"},
	groups = {},
	place_param2 = 1,
	on_use = minetest.item_eat(2),
})
