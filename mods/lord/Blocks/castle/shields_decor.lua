local S = minetest.get_translator("castle")

minetest.register_node("castle:shield", {
	description   = S("Mounted Shield"),
	tiles         = {
		"castle_shield_side.png",
		"castle_shield_side.png",
		"castle_shield_side.png",
		"castle_shield_side.png",
		"castle_shield_back.png",
		"castle_shield_front.png"
	},
	drawtype      = "nodebox",
	paramtype2    = "facedir",
	paramtype     = "light",
	groups        = { cracky = 3 },
	node_box      = {
		type  = "fixed",
		fixed = {
			{ -0.500000, -0.125000, 0.375000, 0.500000, 0.500000, 0.500000 }, --NodeBox 1
			{ -0.437500, -0.312500, 0.375000, 0.425000, 0.500000, 0.500000 }, --NodeBox 2
			{ -0.312500, -0.437500, 0.375000, 0.312500, 0.500000, 0.500000 }, --NodeBox 3
			{ -0.187500, -0.500000, 0.375000, 0.187500, 0.500000, 0.500000 }, --NodeBox 4
		},
	},
	selection_box = {
		type  = "fixed",
		fixed = {
			{ -0.500000, -0.500000, 0.375000, 0.500000, 0.500000, 0.500000 }, --NodeBox 1
		},
	},
	sounds        = default.node_sound_defaults(),
})

minetest.register_craft({
	output = "castle:shield",
	recipe = {
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" },
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" },
		{ "dye:red", "default:steel_ingot", "dye:blue" },
	}
})

minetest.register_node("castle:shield_2", {
	description   = S("Mounted Shield"),
	tiles         = {
		"castle_shield_side_2.png",
		"castle_shield_side_2.png",
		"castle_shield_side_2.png",
		"castle_shield_side_2.png",
		"castle_shield_back.png",
		"castle_shield_front_2.png"
	},
	drawtype      = "nodebox",
	paramtype2    = "facedir",
	paramtype     = "light",
	groups        = { cracky = 3 },
	node_box      = {
		type  = "fixed",
		fixed = {
			{ -0.500000, -0.125000, 0.375000, 0.500000, 0.500000, 0.500000 }, --NodeBox 1
			{ -0.437500, -0.312500, 0.375000, 0.425000, 0.500000, 0.500000 }, --NodeBox 2
			{ -0.312500, -0.437500, 0.375000, 0.312500, 0.500000, 0.500000 }, --NodeBox 3
			{ -0.187500, -0.500000, 0.375000, 0.187500, 0.500000, 0.500000 }, --NodeBox 4
		},
	},
	selection_box = {
		type  = "fixed",
		fixed = {
			{ -0.500000, -0.500000, 0.375000, 0.500000, 0.500000, 0.500000 }, --NodeBox 1
		},
	},
	sounds        = default.node_sound_defaults(),
})

minetest.register_craft({
	output = "castle:shield_2",
	recipe = {
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" },
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" },
		{ "dye:cyan", "default:steel_ingot", "dye:yellow" },
	}
})

minetest.register_node("castle:shield_3", {
	description   = S("Mounted Shield"),
	tiles         = {
		"castle_shield_side_3.png",
		"castle_shield_side_3.png",
		"castle_shield_side_3.png",
		"castle_shield_side_3.png",
		"castle_shield_back.png",
		"castle_shield_front_3.png"
	},
	drawtype      = "nodebox",
	paramtype2    = "facedir",
	paramtype     = "light",
	groups        = { cracky = 3 },
	node_box      = {
		type  = "fixed",
		fixed = {
			{ -0.500000, -0.125000, 0.375000, 0.500000, 0.500000, 0.500000 }, --NodeBox 1
			{ -0.437500, -0.312500, 0.375000, 0.425000, 0.500000, 0.500000 }, --NodeBox 2
			{ -0.312500, -0.437500, 0.375000, 0.312500, 0.500000, 0.500000 }, --NodeBox 3
			{ -0.187500, -0.500000, 0.375000, 0.187500, 0.500000, 0.500000 }, --NodeBox 4
		},
	},
	selection_box = {
		type  = "fixed",
		fixed = {
			{ -0.500000, -0.500000, 0.375000, 0.500000, 0.500000, 0.500000 }, --NodeBox 1
		},
	},
	sounds        = default.node_sound_defaults(),
})

minetest.register_craft({
	output = "castle:shield_3",
	recipe = {
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" },
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" },
		{ "dye:grey", "default:steel_ingot", "dye:green" },
	}
})
