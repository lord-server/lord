<<<<<<< HEAD
<<<<<<< HEAD
local S = lottfarming.get_translator
=======
local S = minetest.get_translator("lottfarming")
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
=======
local S = lottfarming.get_translator
>>>>>>> 2efad20 (2-nd part)

farming.register_plant("lottfarming:carrot", {
	description = S("Carrot Seed"),
	harvest_description = S("Carrot"),
<<<<<<< HEAD
<<<<<<< HEAD
	seed_inv_img = "lottfarming_seed_carrot.png",
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
=======
	seed_inv_img = "lottfarming_carrot_seed.png",
=======
	seed_inv_img = "lottfarming_seed_carrot.png",
>>>>>>> 2efad20 (2-nd part)
	paramtype2 = "meshoptions",
	steps = 4,
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"},
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
	groups = {},
	place_param2 = 1,
	on_use = minetest.item_eat(2),
})
