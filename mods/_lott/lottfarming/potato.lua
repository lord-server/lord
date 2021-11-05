<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
local S = lottfarming.get_translator
=======
local S = minetest.get_translator("lottfarming")
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
=======
local S = lottfarming.get_translator
>>>>>>> 2efad20 (2-nd part)

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
=======
minetest.register_craftitem("lottfarming:potato_seed", {
	description = "Potato Seeds",
	inventory_image = "lottfarming_potato_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return place_seed(itemstack, placer, pointed_thing, "lottfarming:potato_1", 40)
	end,
})

minetest.register_node("lottfarming:potato_1", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_potato_1.png"},
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+6/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:potato_2", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_potato_2.png"},
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+9/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:potato_3", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"lottfarming_potato_3.png"},
	waving = 1,
	drop = {
		max_items = 6,
		items = {
			{ items = {'lottfarming:potato_seed'} },
			{ items = {'lottfarming:potato_seed'}, rarity = 2},
			{ items = {'lottfarming:potato_seed'}, rarity = 5},
			{ items = {'lottfarming:potato'} },
			{ items = {'lottfarming:potato'}, rarity = 2 },
			{ items = {'lottfarming:potato'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("lottfarming:potato", {
	description = "Potato",
	inventory_image = "lottfarming_potato.png",
	on_use = minetest.item_eat(1),
})

farming:add_plant("lottfarming:potato_3", {"lottfarming:potato_1", "lottfarming:potato_2"}, 50, 20, 40)

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "lottfarming:potato_cooked",
	recipe = "lottfarming:potato"
})

minetest.register_craftitem("lottfarming:potato_cooked", {
	description = "Cooked Potato",
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
=======
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"},
	place_param2 = 1,
	on_use = minetest.item_eat(1),
})

minetest.register_craftitem("lottfarming:potato_cooked", {
	description = S("Cooked Potato"),
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
	inventory_image = "lottfarming_potato_cooked.png",
	on_use = minetest.item_eat(5),
})
