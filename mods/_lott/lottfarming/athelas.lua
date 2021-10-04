local S = lottfarming.get_translator

farming.register_plant("lottfarming:athelas", {
	description = S("Athelas Seed"),
	harvest_description = S("Athelas"),
	seed_inv_img = "lottfarming_seed_athelas.png",
	paramtype2 = "meshoptions",
	steps = 3,
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
	fertility = {"soil"},
	place_param2 = 1,
})
