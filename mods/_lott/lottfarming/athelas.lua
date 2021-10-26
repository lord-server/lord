local S = lottfarming.get_translator

farming.register_plant("lottfarming:athelas", {
	description = S("Athelas Seed"),
	harvest_description = S("Athelas"),
	seed_inv_img = "lottfarming_seed_athelas.png",
	paramtype2 = "meshoptions",
	steps = 3,
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
})
