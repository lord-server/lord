local S = minetest.get_translator("lottplants")


--Lorien grass
minetest.register_node("lottplants:lorien_grass_1", {
	description       = S("Lorien Grass"),
	drawtype          = "plantlike",
	tiles             = { "lottplants_lorien_grass_1.png" },
	-- use a bigger inventory image
	inventory_image   = "lottplants_lorien_grass_3.png",
	wield_image       = "lottplants_lorien_grass_3.png",
	paramtype         = "light",
	waving            = 1,
	walkable          = false,
	is_ground_content = true,
	buildable_to      = true,
	groups            = {
		snappy = 3, flammable = 3, flora = 1, attached_node = 1, grass = 1, color_green = 1
	},
	sounds            = default.node_sound_leaves_defaults(),
	selection_box     = {
		type  = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -5 / 16, 0.5 },
	},
	on_place          = function(itemstack, placer, pointed_thing)
		-- place a random grass node
		local stack = ItemStack("lottplants:lorien_grass_" .. math.random(1, 5))
		local ret   = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("lottplants:lorien_grass_1 " .. itemstack:get_count() - (1 - ret:get_count()))
	end,
})
minetest.register_node("lottplants:lorien_grass_2", {
	description       = S("Lorien Grass"),
	drawtype          = "plantlike",
	tiles             = { "lottplants_lorien_grass_2.png" },
	inventory_image   = "lottplants_lorien_grass_2.png",
	wield_image       = "lottplants_lorien_grass_2.png",
	paramtype         = "light",
	waving            = 1,
	walkable          = false,
	buildable_to      = true,
	is_ground_content = true,
	drop              = "lottplants:lorien_grass_1",
	groups            = {
		snappy = 3, flammable = 3, flora = 1, attached_node = 1, not_in_creative_inventory = 1, grass = 1
	},
	sounds            = default.node_sound_leaves_defaults(),
	selection_box     = {
		type  = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -5 / 16, 0.5 },
	},
})
minetest.register_node("lottplants:lorien_grass_3", {
	description       = S("Lorien Grass"),
	drawtype          = "plantlike",
	tiles             = { "lottplants_lorien_grass_3.png" },
	inventory_image   = "lottplants_lorien_grass_3.png",
	wield_image       = "lottplants_lorien_grass_3.png",
	paramtype         = "light",
	waving            = 1,
	walkable          = false,
	buildable_to      = true,
	is_ground_content = true,
	drop              = "lottplants:lorien_grass_1",
	groups            = {
		snappy = 3, flammable = 3, flora = 1, attached_node = 1, not_in_creative_inventory = 1, grass = 1
	},
	sounds            = default.node_sound_leaves_defaults(),
	selection_box     = {
		type  = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -5 / 16, 0.5 },
	},
})
minetest.register_node("lottplants:lorien_grass_4", {
	description       = S("Lorien Grass"),
	drawtype          = "plantlike",
	tiles             = { "lottplants_lorien_grass_4.png" },
	inventory_image   = "lottplants_lorien_grass_4.png",
	wield_image       = "lottplants_lorien_grass_4.png",
	paramtype         = "light",
	waving            = 1,
	walkable          = false,
	buildable_to      = true,
	is_ground_content = true,
	drop              = "lottplants:lorien_grass_1",
	groups            = {
		snappy = 3, flammable = 3, flora = 1, attached_node = 1, not_in_creative_inventory = 1, grass = 1
	},
	sounds            = default.node_sound_leaves_defaults(),
	selection_box     = {
		type  = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -5 / 16, 0.5 },
	},
})

minetest.register_node("lottplants:brambles_of_mordor", {
	description = S("Brambles Of Mordor"),
	drawtype = "plantlike",
	tiles = { "lottplants_brambles_of_mordor.png" },
	inventory_image = "lottplants_brambles_of_mordor.png",
	wield_image = "lottplants_brambles_of_mordor.png",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 42,
	walkable = false,
	waving = 1,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_grey=1, grass=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

minetest.register_node("lottplants:pilinehtar", {
	description = S("Pilinehtar"),
	drawtype = "plantlike",
	tiles = { "lottplants_pilinehtar.png" },
	inventory_image = "lottplants_pilinehtar.png",
	wield_image = "lottplants_pilinehtar.png",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 2,
	waving = 1,
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flower=1,flora=1,attached_node=1,color_green=1, grass=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})
