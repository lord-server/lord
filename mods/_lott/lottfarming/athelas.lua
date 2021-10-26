<<<<<<< HEAD
<<<<<<< HEAD
local S = lottfarming.get_translator
=======
local S = minetest.get_translator("lottfarming")
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)

farming.register_plant("lottfarming:athelas", {
	description = S("Athelas Seed"),
	harvest_description = S("Athelas"),
<<<<<<< HEAD
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
=======
minetest.register_craftitem("lottfarming:athelas_seed", {
	description = "Athelas Seeds",
	inventory_image = "lottfarming_athelas_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return place_seed(itemstack, placer, pointed_thing, "lottfarming:athelas_1", 2)
	end,
})

minetest.register_node("lottfarming:athelas_1", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_athelas_1.png"},
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:athelas_2", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_athelas_2.png"},
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+11/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:athelas_3", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"lottfarming_athelas_3.png"},
	waving = 1,
	drop = {
		max_items = 6,
		items = {
			{ items = {'lottfarming:athelas_seed'} },
			{ items = {'lottfarming:athelas_seed'}, rarity = 2},
			{ items = {'lottfarming:athelas_seed'}, rarity = 5},
			{ items = {'lottfarming:athelas'} },
			{ items = {'lottfarming:athelas'}, rarity = 2 },
			{ items = {'lottfarming:athelas'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("lottfarming:athelas", {
	description = "Athelas",
	inventory_image = "lottfarming_athelas.png",
})

farming:add_plant("lottfarming:athelas_3", {"lottfarming:athelas_1", "lottfarming:athelas_2"}, 50, 20, 2)
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
=======
	seed_inv_img = "lottfarming_athelas_seed.png",
	paramtype2 = "meshoptions",
	steps = 3,
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"},
	place_param2 = 1,
})
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
