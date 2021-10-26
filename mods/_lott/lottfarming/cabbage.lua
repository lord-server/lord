<<<<<<< HEAD
<<<<<<< HEAD
local S = lottfarming.get_translator
=======
minetest.register_craftitem("lottfarming:cabbage_seed", {
	description = "Cabbage Seed",
	inventory_image = "lottfarming_cabbage_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return place_seed(itemstack, placer, pointed_thing, "lottfarming:cabbage_1")
	end,
})
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
=======
local S = minetest.get_translator("lottfarming")
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)

minetest.register_node("lottfarming:cabbage_1", {
	paramtype = "light",
	sunlight_propagates = true,
	drawtype = "nodebox",
	drop = "",
<<<<<<< HEAD
<<<<<<< HEAD
	tiles = {"lottfarming_cabbage_top.png", "lottfarming_cabbage_top.png", "lottfarming_cabbage_side.png",
	"lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png"},
=======
	tiles = {"lottfarming_cabbage_top.png", "lottfarming_cabbage_top.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png"},
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
=======
	tiles = {"lottfarming_cabbage_top.png", "lottfarming_cabbage_top.png", "lottfarming_cabbage_side.png",
	"lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png"},
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
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
<<<<<<< HEAD
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
	next_plant = {{node = "lottfarming:cabbage_2"}},
=======
	next_plant = {{name = "lottfarming:cabbage_2"}},
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, not_in_creative_inventory = 1, plant = 1},
=======
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, not_in_creative_inventory=1, plant=1},
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
=======
	next_plant = {{name = "lottfarming:cabbage_2"}},
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, not_in_creative_inventory = 1, plant = 1},
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("lottfarming:cabbage_2", {
	paramtype = "light",
	sunlight_propagates = true,
	drawtype = "nodebox",
	drop = "",
<<<<<<< HEAD
<<<<<<< HEAD
	tiles = {"lottfarming_cabbage_top.png", "lottfarming_cabbage_top.png", "lottfarming_cabbage_side.png",
	"lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png"},
=======
	tiles = {"lottfarming_cabbage_top.png", "lottfarming_cabbage_top.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png"},
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
=======
	tiles = {"lottfarming_cabbage_top.png", "lottfarming_cabbage_top.png", "lottfarming_cabbage_side.png",
	"lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png"},
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
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
<<<<<<< HEAD
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
	next_plant = {{node = "lottfarming:cabbage_3"}},
=======
	next_plant = {{name = "lottfarming:cabbage_3"}},
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, not_in_creative_inventory = 1, plant = 1},
=======
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, not_in_creative_inventory=1, plant=1},
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
=======
	next_plant = {{name = "lottfarming:cabbage_3"}},
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, not_in_creative_inventory = 1, plant = 1},
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("lottfarming:cabbage_3", {
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
	description = S("Cabbage"),
	paramtype2 = "facedir",
	tiles = {"lottfarming_cabbage_top.png", "lottfarming_cabbage_top.png", "lottfarming_cabbage_side.png",
	"lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png"},
	drop = {
<<<<<<< HEAD
=======
	description = "Cabbage",
	paramtype2 = "facedir",
	tiles = {"lottfarming_cabbage_top.png", "lottfarming_cabbage_top.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png"},
		drop = {
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
=======
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
		max_items = 6,
		items = {
			{ items = {'lottfarming:cabbage_seed'} },
			{ items = {'lottfarming:cabbage_seed'}, rarity = 2},
			{ items = {'lottfarming:cabbage_seed'}, rarity = 5},
<<<<<<< HEAD
<<<<<<< HEAD
			{ items = {'lottfarming:cabbage'} }
		}
	},
<<<<<<< HEAD
=======
	next_plant = {{name = "lottfarming:cabbage"}},
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, plant = 1},
=======
			{ items = {'lottfarming:cabbage'} },
			{ items = {'lottfarming:cabbage'}, rarity = 2 },
			{ items = {'lottfarming:cabbage'}, rarity = 5 }
		}
	},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, plant=1},
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
=======
			{ items = {'lottfarming:cabbage'} }
		}
	},
	next_plant = {{name = "lottfarming:cabbage"}},
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, plant = 1},
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("lottfarming:cabbage", {
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
	description = S("Cabbage"),
	paramtype2 = "facedir",
	tiles = {"lottfarming_cabbage_top.png", "lottfarming_cabbage_top.png", "lottfarming_cabbage_side.png",
	"lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png"},
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, plant = 1, salad = 1},
	sounds = default.node_sound_wood_defaults(),
    on_use = minetest.item_eat(4)
<<<<<<< HEAD
})

farming.register_plant("lottfarming:cabbage", {
	description = S("Cabbage Seed"),
	harvest_name = "lottfarming:cabbage",
	seed_inv_img = "lottfarming_seed_cabbage.png",
	planttype = 3,
	paramtype2 = "meshoptions",
<<<<<<< HEAD
	minlight = 11,
	maxlight = 15,
	fertility = {"soil"},
=======
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"},
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
	place_param2 = 1,
})
=======
	description = "Cabbage",
	paramtype2 = "facedir",
	tiles = {"lottfarming_cabbage_top.png", "lottfarming_cabbage_top.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png"},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, plant=1, salad=1},
	sounds = default.node_sound_wood_defaults(),
     on_use = minetest.item_eat(4)
})

farming:add_plant("lottfarming:cabbage_3", {"lottfarming:cabbage_1", "lottfarming:cabbage_2"}, 80, 20)
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
=======
})

farming.register_plant("lottfarming:cabbage", {
	description = S("Cabbage Seed"),
	harvest_name = "lottfarming:cabbage",
	seed_inv_img = "lottfarming_cabbage_seed.png",
	planttype = 3,
	paramtype2 = "meshoptions",
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"},
	place_param2 = 1,
})
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)

minetest.register_craft({
	output = 'lottfarming:salad',
	recipe = {
		{'group:salad', 'group:salad', 'group:salad'},
		{'', 'lottfarming:bowl', ''},
	}
})

minetest.register_craftitem("lottfarming:salad", {
<<<<<<< HEAD
<<<<<<< HEAD
	description = S("Salad"),
	inventory_image = "lottfarming_salad.png",
	on_use = minetest.item_eat(10),
})
=======
=======
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
	description = "Salad",
	inventory_image = "lottfarming_salad.png",
	on_use = minetest.item_eat(10),
})
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
