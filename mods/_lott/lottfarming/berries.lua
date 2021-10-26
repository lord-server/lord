<<<<<<< HEAD
<<<<<<< HEAD
local S = lottfarming.get_translator
=======
local S = minetest.get_translator("lottfarming")
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)

farming.register_plant("lottfarming:berries", {
	description = S("Berries Seed"),
	harvest_description = S("Berries"),
<<<<<<< HEAD
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
=======
minetest.register_craftitem("lottfarming:berries_seed", {
	description = "Berries Seeds",
	inventory_image = "lottfarming_berries_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return place_seed(itemstack, placer, pointed_thing, "lottfarming:berries_1", 34)
	end,
})

minetest.register_node("lottfarming:berries_1", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_berries_1.png"},
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

minetest.register_node("lottfarming:berries_2", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_berries_2.png"},
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+8/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:berries_3", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_berries_3.png"},
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+13/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:berries_4", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"lottfarming_berries_4.png"},
	waving = 1,
	drop = {
		max_items = 6,
		items = {
			{ items = {'lottfarming:berries_seed'} },
			{ items = {'lottfarming:berries_seed'}, rarity = 2},
			{ items = {'lottfarming:berries_seed'}, rarity = 5},
			{ items = {'lottfarming:berries'} },
			{ items = {'lottfarming:berries'}, rarity = 2 },
			{ items = {'lottfarming:berries'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("lottfarming:berries", {
	description = "Berries",
	inventory_image = "lottfarming_berries.png",
	on_use = minetest.item_eat(1),
})

farming:add_plant("lottfarming:berries_4", {"lottfarming:berries_1", "lottfarming:berries_2", "lottfarming:berries_3"}, 50, 20, 34)
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
=======
	seed_inv_img = "lottfarming_berries_seed.png",
	paramtype2 = "meshoptions",
	steps = 4,
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"},
	groups = {},
	place_param2 = 1,
	on_use = minetest.item_eat(2),
})
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
