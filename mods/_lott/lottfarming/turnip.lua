<<<<<<< HEAD
<<<<<<< HEAD
local S = lottfarming.get_translator
=======
local S = minetest.get_translator("lottfarming")
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
=======
local S = lottfarming.get_translator
>>>>>>> 2efad20 (2-nd part)

farming.register_plant("lottfarming:turnip", {
	harvest_name = "lottfarming:turnip",
	description = S("Turnip Seed"),
	harvest_description = S("Turnip"),
<<<<<<< HEAD
<<<<<<< HEAD
	seed_inv_img = "lottfarming_seed_turnip.png",
=======
	seed_inv_img = "lottfarming_turnip_seed.png",
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
=======
	seed_inv_img = "lottfarming_seed_turnip.png",
>>>>>>> 2efad20 (2-nd part)
	groups = {},
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

minetest.register_craftitem("lottfarming:turnip_cooked", {
<<<<<<< HEAD
<<<<<<< HEAD
	description = S("Cooked Turnip"),
=======
	description = "Cooked Turnip",
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
=======
	description = S("Cooked Turnip"),
>>>>>>> 2efad20 (2-nd part)
	inventory_image = "lottfarming_turnip_cooked.png",
	on_use = minetest.item_eat(2),
})
