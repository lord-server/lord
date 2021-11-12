<<<<<<< HEAD
local S = lottfarming.get_translator
<<<<<<< HEAD

minetest.register_alias("lottfarming:melon_slice", "lottfarming:melon")

minetest.register_craftitem("lottfarming:melon", {
	description = S("Melon Slice"),
	inventory_image = "lottfarming_melon.png",
	on_use = minetest.item_eat(2),
=======
minetest.register_craftitem("lottfarming:melon_seed", {
	description = "Melon Seed",
	inventory_image = "lottfarming_melon_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return place_seed(itemstack, placer, pointed_thing, "lottfarming:melon_1")
	end,
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
})
=======
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)

minetest.register_node("lottfarming:melon_1", {
	paramtype = "light",
	sunlight_propagates = true,
	drawtype = "nodebox",
	drop = "",
<<<<<<< HEAD
	tiles = {"lottfarming_melon_top.png", "lottfarming_melon_top.png", "lottfarming_melon_side.png",
	"lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png"},
=======
	tiles = {"lottfarming_melon_top.png", "lottfarming_melon_top.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png"},
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
	node_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.5, -0.2, 0.2, -0.1, 0.2}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.5, -0.2, 0.2, -0.1, 0.2}
		},
	},
<<<<<<< HEAD
<<<<<<< HEAD
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
	next_plant = {{node = "lottfarming:melon_2"}},
=======
	next_plant = {{name = "lottfarming:melon_2"}},
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, not_in_creative_inventory = 1, plant = 1},
=======
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, not_in_creative_inventory=1, plant=1},
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("lottfarming:melon_2", {
	paramtype = "light",
	sunlight_propagates = true,
	drawtype = "nodebox",
	drop = "",
<<<<<<< HEAD
	tiles = {"lottfarming_melon_top.png", "lottfarming_melon_top.png", "lottfarming_melon_side.png",
	"lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png"},
=======
	tiles = {"lottfarming_melon_top.png", "lottfarming_melon_top.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png"},
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
	node_box = {
		type = "fixed",
		fixed = {
			{-0.35, -0.5, -0.35, 0.35, 0.2, 0.35}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.35, -0.5, -0.35, 0.35, 0.2, 0.35}
		},
	},
<<<<<<< HEAD
<<<<<<< HEAD
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
	next_plant = {{node = "lottfarming:melon_3"}},
=======
	next_plant = {{name = "lottfarming:melon_3"}},
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, not_in_creative_inventory = 1, plant = 1},
=======
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, not_in_creative_inventory=1, plant=1},
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("lottfarming:melon_3", {
<<<<<<< HEAD
	description = S("Melon"),
	paramtype2 = "facedir",
	tiles = {"lottfarming_melon_top.png", "lottfarming_melon_top.png", "lottfarming_melon_side.png",
	"lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'lottfarming:melon_seed'} },
			{ items = {'lottfarming:melon_seed'}, rarity = 2},
			{ items = {'lottfarming:melon_seed'}, rarity = 5},
			{ items = {'lottfarming:melon_3'} }
		}
	},
	groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, plant = 1},
=======
	description = "Melon",
	paramtype2 = "facedir",
	tiles = {"lottfarming_melon_top.png", "lottfarming_melon_top.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png"},
		drop = {
		max_items = 6,
		items = {
			{ items = {'lottfarming:melon_seed'} },
			{ items = {'lottfarming:melon_seed'}, rarity = 20},
			{ items = {'lottfarming:melon 8'} },
		}
	},
	groups = {choppy=2, oddly_breakable_by_hand=1, flammable=2, plant=1},
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
	sounds = default.node_sound_wood_defaults(),
})

<<<<<<< HEAD
farming.register_plant("lottfarming:melon", {
	description = S("Melon Seed"),
	harvest_name = "lottfarming:melon_3",
	seed_inv_img = "lottfarming_seed_melon.png",
	planttype = 3,
	paramtype2 = "meshoptions",
	minlight = 11,
	maxlight = 15,
	fertility = {"soil"},
	place_param2 = 1,
})
=======
minetest.register_alias("lottfarming:melon_slice", "lottfarming:melon")

minetest.register_craftitem("lottfarming:melon", {
<<<<<<< HEAD
	description = S("Melon Slice"),
=======
	description = "Melon",
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
	inventory_image = "lottfarming_melon.png",
	on_use = minetest.item_eat(2),
})

<<<<<<< HEAD
farming.register_plant("lottfarming:melon", {
	description = S("Melon Seed"),
	harvest_name = "lottfarming:melon_3",
	seed_inv_img = "lottfarming_seed_melon.png",
	planttype = 3,
	paramtype2 = "meshoptions",
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"},
	place_param2 = 1,
})
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
=======
farming:add_plant("lottfarming:melon_3", {"lottfarming:melon_1", "lottfarming:melon_2"}, 80, 20)
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
