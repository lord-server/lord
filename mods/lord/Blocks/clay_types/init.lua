local S = minetest.get_mod_translator()

-- Chamotte

minetest.register_craftitem("clay_types:chamotte_lump", {
	description = S("Chamotte Clay Lump"),
	inventory_image = "clay_types_chamotte_lump.png"
})

minetest.register_node("clay_types:chamotte_block_raw", {
	description = S("Raw Chamotte Block"),
	tiles = {"clay_types_chamotte_block_raw.png"},
	is_ground_content = false,
	groups = {crumbly = 2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("clay_types:chamotte_block_dried", {
	description = S("Dried Chamotte Block"),
	tiles = {"clay_types_chamotte_block_dried.png"},
	is_ground_content = false,
	groups = {cracky = 2, wall_connected = 1},
	sounds = default.node_sound_stone_defaults(),
})

stairs.register_stair_and_slab("chamotte_block_dried", "clay_types:chamotte_block_dried",
		{cracky=2, wall_connected = 1},
		{"clay_types_chamotte_block_dried.png"},
		S("Dried Chamotte Block Stair"),
		S("Dried Chamotte Block Slab"),
		default.node_sound_stone_defaults(),
		false,
		S("Inner Dried Chamotte Block Stair"),
		S("Outer Dried Chamotte Block Stair")
)

-- Chamotte crafts

minetest.register_craft({
	type = "cooking",
	output = "clay_types:chamotte_lump",
	recipe = "default:clay_lump",
})

minetest.register_craft({
	output = "clay_types:chamotte_block_raw",
	recipe = {
		{"clay_types:chamotte_lump", "clay_types:chamotte_lump"},
		{"clay_types:chamotte_lump", "clay_types:chamotte_lump"},
	},
})

minetest.register_craft({
	output = "clay_types:chamotte_lump 4",
	recipe = {
		{"clay_types:chamotte_block_raw"},
	},
})

minetest.register_craft({
	type = "cooking",
	output = "clay_types:chamotte_block_dried",
	recipe = "clay_types:chamotte_block_raw",
})


-- Mordor Clay

minetest.register_craftitem("clay_types:mordor_clay_lump", {
	description = S("Mordor Clay Lump"),
	inventory_image = "clay_types_mordor_clay_lump.png"
})

minetest.register_node("clay_types:mordor_clay_block_raw", {
	description = S("Raw Mordor Clay Block"),
	tiles = {"clay_types_mordor_clay_block_raw.png"},
	groups = {crumbly = 2},
	drop = "clay_types:mordor_clay_lump 4",
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("clay_types:mordor_clay_block_dried", {
	description = S("Dried Mordor Clay Block"),
	tiles = {"clay_types_mordor_clay_block_dried.png"},
	is_ground_content = false,
	groups = {cracky = 2, wall_connected = 1},
	sounds = default.node_sound_stone_defaults(),
})

stairs.register_stair_and_slab("mordor_clay_block_dried", "clay_types:mordor_clay_block_dried",
		{cracky=2, wall_connected = 1},
		{"clay_types_mordor_clay_block_dried.png"},
		S("Dried Mordor Clay Block Stair"),
		S("Dried Mordor Clay Block Slab"),
		default.node_sound_stone_defaults(),
		false,
		S("Inner Dried Mordor Clay Block Stair"),
		S("Outer Dried Mordor Clay Block Stair")
)

minetest.register_craft({
	output = "clay_types:mordor_clay_block_raw",
	recipe = {
		{"clay_types:mordor_clay_lump", "clay_types:mordor_clay_lump"},
		{"clay_types:mordor_clay_lump", "clay_types:mordor_clay_lump"},
	},
})

minetest.register_craft({
	output = "clay_types:mordor_clay_lump 4",
	recipe = {
		{"clay_types:mordor_clay_block_raw"},
	},
})

minetest.register_craft({
	type = "cooking",
	output = "clay_types:mordor_clay_block_dried",
	recipe = "clay_types:mordor_clay_block_raw",
})
