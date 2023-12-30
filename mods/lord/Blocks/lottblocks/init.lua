local S = minetest.get_translator("lottblocks")

lottblocks = {}

dofile(minetest.get_modpath("lottblocks").."/wooden_stuff.lua") --trapdoors, doors, tables and chairs in all woods.
dofile(minetest.get_modpath("lottblocks").."/misc.lua")
dofile(minetest.get_modpath("lottblocks").."/music.lua") --This has musical insturments, and the music they play.
dofile(minetest.get_modpath("lottblocks").."/decoration.lua") --This has various decoration nodes, by catninja.
dofile(minetest.get_modpath("lottblocks").."/chests.lua")
dofile(minetest.get_modpath("lottblocks").."/lamps.lua")
dofile(minetest.get_modpath("lottblocks").."/palantiri.lua")
dofile(minetest.get_modpath("lottblocks").."/guides.lua")

-- Snowy Cobble
minetest.register_node("lottblocks:snowycobble", {
	description = S("Snowy Cobblestone"),
	tiles = {"lottblocks_snowycobble.png"},
	is_ground_content = false,
	groups = {cracky=3},
})
stairs.register_stair_and_slab(
	"snowycobble",
	"lottblocks:snowycobble",
	{cracky=2},
	{"lottblocks_snowycobble.png"},
	S("Snowy Cobble Stair"),
	S("Snowy Cobble Slab"),
	default.node_sound_stone_defaults(),
	false,
	S("Inner Snowy Cobble Stair"),
	S("Outer Snowy Cobble Stair")
)

-- Mordor Stone Bricks
minetest.register_node("lottblocks:mordor_stone_brick", {
	description = S("Mordor Stone Brick"),
	tiles = {"lottblocks_mordor_stone_brick.png"},
	is_ground_content = false,
	groups = {cracky=2},
})
stairs.register_stair_and_slab(
		"mordor_stone_brick",
		"lottblocks:mordor_stone_brick",
		{cracky=2},
		{"lottblocks_mordor_stone_brick.png"},
		S("Mordor Stone Brick Stair"),
		S("Mordor Stone Brick Slab"),
		default.node_sound_stone_defaults(),
		false,
		S("Inner Mordor Stone Brick Stair"),
		S("Outer Mordor Stone Brick Stair")
)
minetest.register_node("lottblocks:mordor_stone_block", {
	description = S("Mordor Stone Block"),
	tiles = {"lottblocks_mordor_stone_block.png"},
	is_ground_content = false,
	groups = {cracky=2},
})
stairs.register_stair_and_slab(
		"mordor_stone_block",
		"lottblocks:mordor_stone_block",
		{cracky=2},
		{"lottblocks_mordor_stone_block.png"},
		S("Mordor Stone Block Stair"),
		S("Mordor Stone Block Slab"),
		default.node_sound_stone_defaults(),
		false,
		S("Inner Mordor Stone Block Stair"),
		S("Outer Mordor Stone Block Stair")
)
minetest.register_craft({
	output = 'lottblocks:mordor_stone_brick 4',
	recipe = {
		{'lottmapgen:mordor_stone', 'lottmapgen:mordor_stone'},
		{'lottmapgen:mordor_stone', 'lottmapgen:mordor_stone'},
	}
})
minetest.register_craft({
	output = 'lottblocks:mordor_stone_block 9',
	recipe = {
		{'lottmapgen:mordor_stone', 'lottmapgen:mordor_stone', 'lottmapgen:mordor_stone'},
		{'lottmapgen:mordor_stone', 'lottmapgen:mordor_stone', 'lottmapgen:mordor_stone'},
		{'lottmapgen:mordor_stone', 'lottmapgen:mordor_stone', 'lottmapgen:mordor_stone'},
	}
})

-- Orc Stone
minetest.register_node("lottblocks:orc_stone", {
	description = S("Orc Stone"),
	tiles = {"lottblocks_orc_stone.png"},
	is_ground_content = false,
	groups = {cracky=2, stone=1},
})
stairs.register_stair_and_slab(
		"orc_stone",
		"lottblocks:orc_stone",
		{cracky=2},
		{"lottblocks_orc_stone.png"},
		S("Orc Stone Stair"),
		S("Orc Stone Slab"),
		default.node_sound_stone_defaults(),
		false,
		S("Inner Orc Stone Stair"),
		S("Outer Orc Stone Stair")
)
minetest.register_node("lottblocks:orc_brick", {
	description = S("Orc Brick"),
	tiles = {"lottblocks_orc_brick.png"},
	is_ground_content = false,
	groups = {cracky=2, stone=1},
})
stairs.register_stair_and_slab(
		"orc_brick",
		"lottblocks:orc_brick",
		{cracky=2},
		{"lottblocks_orc_brick.png"},
		S("Orc Brick Stair"),
		S("Orc Brick Slab"),
		default.node_sound_stone_defaults(),
		false,
		S("Inner Orc Brick Stair"),
		S("Outer Orc Brick Stair")
)
minetest.register_node("lottblocks:orc_block", {
	description = S("Orc Block"),
	tiles = {"lottblocks_orc_block.png"},
	is_ground_content = false,
	groups = {cracky=2, stone=1},
})
stairs.register_stair_and_slab(
		"orc_block",
		"lottblocks:orc_block",
		{cracky=2},
		{"lottblocks_orc_block.png"},
		S("Orc Block Stair"),
		S("Orc Block Slab"),
		default.node_sound_stone_defaults(),
		false,
		S("Inner Orc Block Stair"),
		S("Outer Orc Block Stair")
)

minetest.register_craft({
	type = "cooking",
	output = "lottblocks:orc_stone",
	recipe = "lottmapgen:mordor_stone",
})
minetest.register_craft({
	type = "cooking",
	output = "lottblocks:orc_brick",
	recipe = "lottblocks:mordor_stone_brick",
})
minetest.register_craft({
	type = "cooking",
	output = "lottblocks:orc_block",
	recipe = "lottblocks:mordor_stone_block",
})
minetest.register_craft({
	output = 'lottblocks:orc_brick 4',
	recipe = {
		{'lottblocks:orc_stone', 'lottblocks:orc_stone'},
		{'lottblocks:orc_stone', 'lottblocks:orc_stone'},
	}
})
minetest.register_craft({
	output = 'lottblocks:orc_block 9',
	recipe = {
		{'lottblocks:orc_stone', 'lottblocks:orc_stone', 'lottblocks:orc_stone'},
		{'lottblocks:orc_stone', 'lottblocks:orc_stone', 'lottblocks:orc_stone'},
		{'lottblocks:orc_stone', 'lottblocks:orc_stone', 'lottblocks:orc_stone'},
	}
})


-- Marble
minetest.register_node("lottblocks:marble_brick", {
	description = S("Marble Brick"),
	tiles = {"lottblocks_marble_brick.png"},
	is_ground_content = false,
	groups = {cracky=2, stone=1},
})
stairs.register_stair_and_slab(
		"marble_brick",
		"lottblocks:marble_brick",
		{cracky=2},
		{"lottblocks_marble_brick.png"},
		S("Marble Brick Stair"),
		S("Marble Brick Slab"),
		default.node_sound_stone_defaults(),
		false,
		S("Inner Marble Brick Stair"),
		S("Outer Marble Brick Stair")
)
minetest.register_craft({
	output = 'lottblocks:marble_brick 4',
	recipe = {
		{'lottores:marble', 'lottores:marble'},
		{'lottores:marble', 'lottores:marble'},
	}
})
