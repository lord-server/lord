local S = lottfarming.get_translator

<<<<<<< HEAD
=======
local stop_trigger = function(_, pos)
	local unodename = minetest.get_node({x = pos.x, y = pos.y + 1, z = pos.z}).name
	local dtype = minetest.registered_nodes[unodename].drawtype
	if dtype == "airlike" then
		return false
	else
		return true
	end
end

>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
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
<<<<<<< HEAD
	fertility = {"soil"},
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
	next_plant = {{node = "lottfarming:corn_1"}},
=======
	fertility = {"grassland"},
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	next_plant = {{name = "lottfarming:corn_1"}},
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
})

minetest.register_node("lottfarming:corn_1", {
	paramtype = "light",
<<<<<<< HEAD
	walkable = false,
	drawtype = "mesh",
	mesh = "lottfarming_plant_1.obj",
=======
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
	drop = "",
	tiles = {"lottfarming_corn_1.png"},
	planttype = 2,
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
<<<<<<< HEAD
			{-4/16, -0.5, -4/16, 4/16, -0.5+3/16, 4/16}
		},
	},
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
=======
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
	next_plant = {{node = "lottfarming:corn_2"}},
	on_timer = farming.grow_plant,
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:corn_2", {
	paramtype = "light",
<<<<<<< HEAD
	walkable = false,
	drawtype = "mesh",
	mesh = "lottfarming_plant_1.obj",
=======
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
	drop = "",
	tiles = {"lottfarming_corn_2.png"},
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
<<<<<<< HEAD
			{-4/16, -0.5, -4/16, 4/16, -0.5+9/16, 4/16}
		},
	},
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
=======
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
	next_plant = {{node = "lottfarming:corn_3"}},
	on_timer = farming.grow_plant,
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:corn_3", {
	paramtype = "light",
<<<<<<< HEAD
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
=======
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_3.png"},
	waving = 1,
	next_plant = {{node = "lottfarming:corn_4"}, {node = "lottfarming:corn_21", pos = {x = 0, y = 1, z = 0}}},
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
	on_timer = farming.grow_plant,
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:corn_4", {
	paramtype = "light",
<<<<<<< HEAD
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
=======
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_4.png"},
	waving = 1,
	next_plant = {{node = "lottfarming:corn_21", pos = {x = 0, y = 1, z = 0}}},
	stop_trigger = stop_trigger,
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
	on_timer = farming.grow_plant,
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

<<<<<<< HEAD
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
=======
minetest.register_node("lottfarming:corn_21", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_21.png"},
	waving = 1,
	next_plant = {{node = "lottfarming:corn_22"}},
	groups = {snappyc = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:corn_22", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_22.png"},
	waving = 1,
	next_plant = {{node = "lottfarming:corn_23"}, {node = "lottfarming:corn_31", pos = {x = 0, y = 1, z = 0}}},
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

<<<<<<< HEAD
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
=======
minetest.register_node("lottfarming:corn_23", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_23.png"},
	waving = 1,
	next_plant = {{node = "lottfarming:corn_31", pos = {x = 0, y = 1, z = 0}}},
	stop_trigger = stop_trigger,
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

<<<<<<< HEAD
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
=======
minetest.register_node("lottfarming:corn_31", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_31.png"},
	waving = 1,
	next_plant = {{node = "lottfarming:corn_32"}},
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

<<<<<<< HEAD
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
=======
minetest.register_node("lottfarming:corn_32", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"lottfarming_corn_32.png"},
	waving = 1,
	drop = {
		max_items = 6,
		items = {
			{ items = {'lottfarming:corn'} },
			{ items = {'lottfarming:corn'}, rarity = 2},
			{ items = {'lottfarming:corn'}, rarity = 5},
			{ items = {'lottfarming:corn_seed'} },
			{ items = {'lottfarming:corn_seed'}, rarity = 2 },
			{ items = {'lottfarming:corn_seed'}, rarity = 5 }
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
		}
	},
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})
