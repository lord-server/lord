<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
local S = lottfarming.get_translator

<<<<<<< HEAD
=======
=======
local S = minetest.get_translator("lottfarming")
=======
local S = lottfarming.get_translator
>>>>>>> 2efad20 (2-nd part)

>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
local stop_trigger = function(_, pos)
	local unodename = minetest.get_node({x = pos.x, y = pos.y + 1, z = pos.z}).name
	local dtype = minetest.registered_nodes[unodename].drawtype
	if dtype == "airlike" then
		return false
	else
		return true
	end
end

<<<<<<< HEAD
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
farming.register_plant("lottfarming:corn",{
	seed_name = "lottfarming:corn_kernel",
	description = S("Corn Kernel"),
	seed_inv_img = "lottfarming_corn_kernel.png",
	harvest_name = "lottfarming:ear_of_corn",
	harvest_description = S("Ear of Corn"),
	harvest_inv_img = "lottfarming_ear_of_corn.png",
=======
farming.register_plant("lottfarming:corn",{
	seed_name = "lottfarming:corn_kernel",
	description = S("Corn Kernel"),
	seed_inv_img = "lottfarming_corn_kernel.png",
	harvest_name = "lottfarming:ear_of_corn",
	harvest_description = S("Ear of Corn"),
<<<<<<< HEAD
	harvest_inv_img = "farming_ear_of_corn.png",
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
=======
	harvest_inv_img = "lottfarming_ear_of_corn.png",
>>>>>>> 2efad20 (2-nd part)
	paramtype2 = "meshoptions",
	groups = {salad = 1},
	place_param2 = 3,
	on_use = minetest.item_eat(2),
	planttype = 2,
<<<<<<< HEAD
<<<<<<< HEAD
	fertility = {"soil"},
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
	next_plant = {{node = "lottfarming:corn_1"}},
=======
=======
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
	fertility = {"grassland"},
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	next_plant = {{name = "lottfarming:corn_1"}},
<<<<<<< HEAD
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
=======
minetest.register_craftitem("lottfarming:corn_seed", {
	description = "Corn Seeds",
	inventory_image = "lottfarming_corn_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		return place_seed(itemstack, placer, pointed_thing, "lottfarming:corn_1", 3)
	end,
})
minetest.register_craftitem("lottfarming:corn", {
	description = "Corn",
	inventory_image = "lottfarming_corn.png",
     groups = {salad=1},
	on_use = minetest.item_eat(4),
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
=======
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
})

minetest.register_node("lottfarming:corn_1", {
	paramtype = "light",
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_1.png"},
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
=======
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_1.png"},
	planttype = 2,
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
=======
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	next_plant = {{node = "lottfarming:corn_2"}},
	on_timer = farming.grow_plant,
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:corn_2", {
	paramtype = "light",
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
	walkable = false,
	drawtype = "mesh",
	mesh = "lottfarming_plant_1.obj",
=======
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
=======
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
=======
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
	drop = "",
	tiles = {"lottfarming_corn_2.png"},
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
=======
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	next_plant = {{node = "lottfarming:corn_3"}},
	on_timer = farming.grow_plant,
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:corn_3", {
	paramtype = "light",
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
=======
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_3.png"},
	waving = 1,
<<<<<<< HEAD
<<<<<<< HEAD
	next_plant = {{node = "lottfarming:corn_4"}, {node = "lottfarming:corn_21", pos = {x = 0, y = 1, z = 0}}},
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
	on_timer = farming.grow_plant,
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
=======
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
=======
	next_plant = {{node = "lottfarming:corn_4"}, {node = "lottfarming:corn_21", pos = {x = 0, y = 1, z = 0}}},
	on_timer = farming.grow_plant,
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:corn_4", {
	paramtype = "light",
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
=======
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_4.png"},
	waving = 1,
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
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
=======
	next_plant = {{node = "lottfarming:corn_21", pos = {x = 0, y = 1, z = 0}}},
	stop_trigger = stop_trigger,
	on_timer = farming.grow_plant,
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
minetest.register_node("lottfarming:corn_21", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_21.png"},
	waving = 1,
<<<<<<< HEAD
<<<<<<< HEAD
	next_plant = {{node = "lottfarming:corn_22"}},
	groups = {snappyc = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
=======
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
=======
	next_plant = {{node = "lottfarming:corn_22"}},
	groups = {snappyc = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
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
<<<<<<< HEAD
<<<<<<< HEAD
	next_plant = {{node = "lottfarming:corn_23"}, {node = "lottfarming:corn_31", pos = {x = 0, y = 1, z = 0}}},
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
=======
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
	sounds = default.node_sound_leaves_defaults(),
})

<<<<<<< HEAD
minetest.register_node("lottfarming:corn_7", {
	paramtype = "light",
<<<<<<< HEAD
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
=======
	next_plant = {{node = "lottfarming:corn_23"}, {node = "lottfarming:corn_31", pos = {x = 0, y = 1, z = 0}}},
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
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
<<<<<<< HEAD
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
=======
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_23.png"},
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
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
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
=======
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
minetest.register_node("lottfarming:corn_31", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_corn_31.png"},
	waving = 1,
<<<<<<< HEAD
<<<<<<< HEAD
	next_plant = {{node = "lottfarming:corn_32"}},
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
=======
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
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
=======
	next_plant = {{node = "lottfarming:corn_32"}},
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
minetest.register_node("lottfarming:corn_32", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
<<<<<<< HEAD
<<<<<<< HEAD
=======
	drop = "",
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
=======
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
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
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
=======
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
		}
	},
	groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
<<<<<<< HEAD
=======
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

chance = 20
interval = 45
whereon = "farming:soil_wet"
wherein = "air"

minetest.register_abm({
	nodenames = "lottfarming:corn_1",
	interval = interval,
	chance = chance,
	action = function(pos, node)
		pos.y = pos.y-1
		if minetest.get_node(pos).name ~= "farming:soil_wet" then
			return
		end
		pos.y = pos.y+1
		local light_level = minetest.get_node_light(pos)
		if not light_level then
			return
		end
		local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
		if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
			pos.y=pos.y+1
			if minetest.get_node(pos).name ~= wherein then
				return
			end
			pos.y=pos.y-1

			minetest.set_node(pos, {name='lottfarming:corn_2', param2 = 3})
		end
	end
})
minetest.register_abm({
	nodenames = "lottfarming:corn_2",
	interval = interval,
	chance = chance,
	action = function(pos, node)
		pos.y = pos.y-1
		if minetest.get_node(pos).name ~= "farming:soil_wet" then
			return
		end
		pos.y = pos.y+1
		local light_level = minetest.get_node_light(pos)
		if not light_level then
			return
		end
		local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
		if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
			pos.y=pos.y+1
			minetest.set_node(pos, {name='lottfarming:corn_21', param2 = 3})
			pos.y=pos.y-1
			minetest.set_node(pos, {name='lottfarming:corn_3', param2 = 3})
		end
	end
})
minetest.register_abm({
	nodenames = "lottfarming:corn_3",
	interval = interval,
	chance = chance,
	action = function(pos, node)
		pos.y = pos.y-1
		if minetest.get_node(pos).name ~= "farming:soil_wet" then
			return
		end
		pos.y = pos.y+1
		local light_level = minetest.get_node_light(pos)
		if not light_level then
			return
		end
		local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
		if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
			pos.y=pos.y+1
			pos.y=pos.y+1
			minetest.set_node(pos, {name='lottfarming:corn_31', param2 = 3})
			pos.y=pos.y-1
			minetest.set_node(pos, {name='lottfarming:corn_22', param2 = 3})
			pos.y=pos.y-1
			minetest.set_node(pos, {name='lottfarming:corn_4', param2 = 3})
		end
	end
})
minetest.register_abm({
	nodenames = "lottfarming:corn_22",
	interval = interval,
	chance = chance,
	action = function(pos, node)
		local light_level = minetest.get_node_light(pos)
		if not light_level then
			return
		end
		local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
		if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
			pos.y=pos.y+1
			minetest.set_node(pos, {name='lottfarming:corn_32', param2 = 3})
			pos.y=pos.y-1
			minetest.set_node(pos, {name='lottfarming:corn_23', param2 = 3})
		end
	end
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
=======
})
<<<<<<< HEAD

minetest.register_lbm({
	name = "lottfarming:start_nodetimer_corn",
	nodenames = {"lottfarming:corn_1", "lottfarming:corn_2", "lottfarming:corn_3", "lottfarming:corn_4",
	"lottfarming:corn_21", "lottfarming:corn_22", "lottfarming:corn_23",
	"lottfarming:corn_31"},
	action = function(pos, node)
		tick_again(pos)
	end,
>>>>>>> 5237f07 (Closes #344. Closes #321. Update LOTT/lottfarming. Move to timer-based growing system)
})
=======
>>>>>>> 2efad20 (2-nd part)
