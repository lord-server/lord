local SL = lord.require_intllib()

-- The wild plants drop food that can be eaten or crafted to get seeds

-- BARLEY

minetest.register_node("lottplants:barley_wild", {
	description = SL("Wild Barley"),
	drawtype = "plantlike",
	waving = 1,
	tiles = { "lottplants_barley_wild.png" },
	inventory_image = "lottplants_barley_wild.png",
	wield_image = "lottplants_barley_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:sheaf_barley'} },
			{ items = {'lottfarming:sheaf_barley'}, rarity = 5},
			{ items = {'lottfarming:sheaf_barley'}, rarity = 10}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

-- BERRIES

minetest.register_node("lottplants:berries_wild", {
	description = SL("Wild Berries"),
	drawtype = "plantlike",
	waving = 1,
	tiles = { "lottplants_berries_wild.png" },
	inventory_image = "lottplants_berries_wild.png",
	wield_image = "lottplants_berries_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:berries'} },
			{ items = {'lottfarming:berries'}, rarity = 5},
			{ items = {'lottfarming:berries '}, rarity = 10}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

--CORN

minetest.register_node("lottplants:corn_wild", {
	description = SL("Wild Corn plant"),
	drawtype = "plantlike",
	waving = 1,
	tiles = { "lottplants_corn_wild.png" },
	inventory_image = "lottplants_corn_wild.png",
	wield_image = "lottplants_corn_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:ear_of_corn'} },
			{ items = {'lottfarming:ear_of_corn'}, rarity = 5},
			{ items = {'lottfarming:ear_of_corn 9'}, rarity = 10}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

-- CABBAGE

minetest.register_node("lottplants:cabbage_wild", {
	description = SL("Wild Cabbage"),
	paramtype2 = "facedir",
	tiles = {
		"lottfarming_cabbage_top.png",
		"lottfarming_cabbage_top.png",
		"lottfarming_cabbage_side.png",
		"lottfarming_cabbage_side.png",
		"lottfarming_cabbage_side.png",
		"lottfarming_cabbage_side.png",
	},
	sunlight_propagates = true,
	paramtype = "light",
	drawtype = "nodebox",
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:cabbage'} },
			{ items = {'lottfarming:cabbage'}, rarity = 5},
			{ items = {'lottfarming:cabbage'}, rarity = 10}
		}
	},
	walkable = true,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.35, -0.5, -0.35, 0.35, 0.2, 0.35}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.35, -0.5, -0.35, 0.35, 0.2, 0.35},
	},
})

-- MELON

minetest.register_node("lottplants:melon_wild", {
	description = SL("Wild Melon"),
	paramtype2 = "facedir",
	tiles = {
		"lottfarming_melon_top.png",
		"lottfarming_melon_top.png",
		"lottfarming_melon_side.png",
		"lottfarming_melon_side.png",
		"lottfarming_melon_side.png",
		"lottfarming_melon_side.png",
	},
	sunlight_propagates = true,
	paramtype = "light",
	drawtype = "nodebox",
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:melon 3'} },
			{ items = {'lottfarming:melon 6'}, rarity = 3},
			{ items = {'lottfarming:melon 6'}, rarity = 8}
		}
	},
	walkable = true,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	--groups = {choppy=2, oddly_breakable_by_hand=2, flammable=2, not_in_creative_inventory=1, plant=1},
	sounds = default.node_sound_leaves_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.35, -0.5, -0.35, 0.35, 0.2, 0.35}
		},
	},
	selection_box = {
		type = "fixed",
		--fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
		fixed = {-0.35, -0.5, -0.35, 0.35, 0.2, 0.35},
	},
})

-- MUSHROOMS

minetest.register_node("lottplants:mushroom_wild", {
	description = SL("Mushroom Wild"),
	drawtype = "plantlike",
	tiles = { "lottplants_mushroom_wild.png" },
	inventory_image = "lottplants_mushroom_wild.png",
	wield_image = "lottplants_mushroom_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 4,
		items = {
			{ items = {'lottfarming:brown_mushroom'}, rarity = 2},
			{ items = {'lottfarming:brown_mushroom_spore'}, rarity = 2},
			{ items = {'lottfarming:red_mushroom'}, rarity = 4},
			{ items = {'lottfarming:red_mushroom_spore'}, rarity = 4},
			{ items = {'lottfarming:blue_mushroom'}, rarity = 6},
			{ items = {'lottfarming:blue_mushroom_spore'}, rarity = 6},
			{ items = {'lottfarming:green_mushroom'}, rarity = 8},
			{ items = {'lottfarming:green_mushroom_spore'}, rarity = 8}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

-- PIPEWEED

minetest.register_node("lottplants:pipeweed_wild", {
	description = SL("Pipeweed Wild"),
	drawtype = "plantlike",
	waving = 1,
	tiles = { "lottplants_pipeweed_wild.png" },
	inventory_image = "lottplants_pipeweed_wild.png",
	wield_image = "lottplants_pipeweed_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:pipeweed'} },
			{ items = {'lottfarming:pipeweed'}, rarity = 5},
			{ items = {'lottfarming:pipeweed'}, rarity = 10}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

-- POTATO

minetest.register_node("lottplants:potato_wild", {
	description = SL("Potato Wild"),
	drawtype = "plantlike",
	waving = 1,
	tiles = { "lottplants_potato_wild.png" },
	inventory_image = "lottplants_potato_wild.png",
	wield_image = "lottplants_potato_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:potato'} },
			{ items = {'lottfarming:potato'}, rarity = 5},
			{ items = {'lottfarming:potato'}, rarity = 10}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

-- TOMATO

minetest.register_node("lottplants:tomato_wild", {
	description = SL("Wild Tomato"),
	drawtype = "plantlike",
	waving = 1,
	tiles = { "lottplants_tomato_wild.png" },
	inventory_image = "lottplants_tomato_wild.png",
	wield_image = "lottplants_tomato_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:tomato'} },
			{ items = {'lottfarming:tomato'}, rarity = 5},
			{ items = {'lottfarming:tomato'}, rarity = 10}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})

-- TURNIP

minetest.register_node("lottplants:turnip_wild", {
	description = SL("Wild Turnip"),
	drawtype = "plantlike",
	waving = 1,
	tiles = { "lottplants_turnip_wild.png" },
	inventory_image = "lottplants_turnip_wild.png",
	wield_image = "lottplants_turnip_wild.png",
	sunlight_propagates = true,
	paramtype = "light",
	drop = {
		max_items = 3,
		items = {
			{ items = {'lottfarming:turnip'} },
			{ items = {'lottfarming:turnip'}, rarity = 10 },
			{ items = {'lottfarming:turnip'}, rarity = 5}
		}
	},
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
})
