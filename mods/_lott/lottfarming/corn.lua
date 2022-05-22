local S = lottfarming.get_translator

farming.register_plant("lottfarming:corn",{
	seed_name = "lottfarming:corn_kernel",
	description = S("Corn Kernel"),
	seed_inv_img = "lottfarming_corn_kernel.png",
	harvest_name = "lottfarming:ear_of_corn",
	harvest_description = S("Ear of Corn"),
	harvest_inv_img = "lottfarming_ear_of_corn.png",
	paramtype2 = "meshoptions",
	groups = {salad = 1},
	place_param2 = 3,
	on_use = minetest.item_eat(2),
	planttype = 2,
	fertility = {"soil"},
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
	next_plant = {{node = "lottfarming:corn_1"}},
})

minetest.register_node("lottfarming:corn_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "mesh",
	mesh = "lottfarming_plant_1.obj",
	drop = "",
	tiles = {"lottfarming_corn_1.png"},
	planttype = 2,
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
			{-4/16, -0.5, -4/16, 4/16, -0.5+3/16, 4/16}
		},
	},
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
	next_plant = {{node = "lottfarming:corn_2"}},
	on_timer = farming.grow_plant,
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:corn_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "mesh",
	mesh = "lottfarming_plant_1.obj",
	drop = "",
	tiles = {"lottfarming_corn_2.png"},
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
			{-4/16, -0.5, -4/16, 4/16, -0.5+9/16, 4/16}
		},
	},
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
	next_plant = {{node = "lottfarming:corn_3"}},
	on_timer = farming.grow_plant,
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:corn_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "mesh",
	mesh = "lottfarming_plant_1.obj",
	drop = "",
	tiles = {"lottfarming_corn_3.png"},
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
			{-4/16, -0.5, -4/16, 4/16, -0.5+13/16, 4/16}
		},
	},
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
	next_plant = {{node = "lottfarming:corn_4"}},
	on_timer = farming.grow_plant,
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:corn_4", {
	paramtype = "light",
	walkable = false,
	drawtype = "mesh",
	mesh = "lottfarming_plant_2.obj",
	drop = "",
	tiles = {"lottfarming_corn_4.png"},
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
			{-4/16, -0.5, -4/16, 4/16, 0.5+5/16, 4/16}
		},
	},
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
	next_plant = {{node = "lottfarming:corn_5"}},
	on_timer = farming.grow_plant,
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:corn_5", {
	paramtype = "light",
	walkable = false,
	drawtype = "mesh",
	mesh = "lottfarming_plant_2.obj",
	drop = "",
	tiles = {"lottfarming_corn_5.png"},
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
			{-4/16, -0.5, -4/16, 4/16, 0.5+8/16, 4/16}
		},
	},
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
	next_plant = {{node = "lottfarming:corn_6"}},
	on_timer = farming.grow_plant,
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:corn_6", {
	paramtype = "light",
	walkable = false,
	drawtype = "mesh",
	mesh = "lottfarming_plant_2.obj",
	drop = "",
	tiles = {"lottfarming_corn_6.png"},
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
			{-4/16, -0.5, -4/16, 4/16, 0.5+12/16, 4/16}
		},
	},
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
	next_plant = {{node = "lottfarming:corn_7"}},
	on_timer = farming.grow_plant,
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:corn_7", {
	paramtype = "light",
	walkable = false,
	drawtype = "mesh",
	mesh = "lottfarming_plant_3.obj",
	drop = "",
	tiles = {"lottfarming_corn_7.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-4/16, -0.5, -4/16, 4/16, 0.5+21/16, 4/16}
		},
	},
	waving = 1,
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
	next_plant = {{node = "lottfarming:corn_8"}},
	on_timer = farming.grow_plant,
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:corn_8", {
	paramtype = "light",
	walkable = false,
	drawtype = "mesh",
	mesh = "lottfarming_plant_3.obj",
	drop = "",
	tiles = {"lottfarming_corn_8.png"},
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
			{-4/16, -0.5, -4/16, 4/16, 0.5+29/16, 4/16}
		},
	},
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
	next_plant = {{node = "lottfarming:corn_9"}},
	on_timer = farming.grow_plant,
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:corn_9", {
	paramtype = "light",
	walkable = false,
	drawtype = "mesh",
	mesh = "lottfarming_plant_3.obj",
	tiles = {"lottfarming_corn_9.png"},
	paramtype2 = "leveled",
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
			{-4/16, -0.5, -4/16, 4/16, 0.5+29/16, 4/16}
		},
	},
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
	drop = {
		max_items = 6,
		items = {
			{ items = {'lottfarming:corn 3'}},
			{ items = {'lottfarming:corn'}, rarity = 2},
			{ items = {'lottfarming:corn'}, rarity = 5},
			{ items = {'lottfarming:corn'}, rarity = 7},
			{ items = {'lottfarming:corn_seed 2'} },
			{ items = {'lottfarming:corn_seed'}, rarity = 2},
			{ items = {'lottfarming:corn_seed'}, rarity = 5}
		}
	},
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})
