local SL = lord.require_intllib()

lottblocks = {}

dofile(minetest.get_modpath("lottblocks").."/wooden_stuff.lua") --This has trapdoors, doors, tables and chairs in all the kinds of wood.
dofile(minetest.get_modpath("lottblocks").."/misc.lua")
dofile(minetest.get_modpath("lottblocks").."/music.lua") --This has musical insturments, and the music they play.
dofile(minetest.get_modpath("lottblocks").."/decoration.lua") --This has various decoration nodes, by catninja.
dofile(minetest.get_modpath("lottblocks").."/chests.lua")
dofile(minetest.get_modpath("lottblocks").."/lamps.lua")
dofile(minetest.get_modpath("lottblocks").."/palantiri.lua")
dofile(minetest.get_modpath("lottblocks").."/guides.lua")
dofile(minetest.get_modpath("lottblocks").."/crafting.lua")

minetest.register_node("lottblocks:snowycobble", {
	description = SL("Snowy Cobblestone"),
	tiles = {"lottblocks_snowycobble.png"},
	is_ground_content = false,
	groups = {cracky=3},
})
minetest.register_node("lottblocks:orc_brick", {
	description = SL("Orc Brick"),
	tiles = {"lottblocks_orc_brick.png"},
	is_ground_content = false,
	groups = {cracky=2},
})
stairs.register_stair_and_slab("orc_brick", "lottblocks:orc_brick",
		{cracky=2},
		{"lottblocks_orc_brick.png"},
		SL("Orc Brick Stair"),
		SL("Orc Brick Slab"),
		default.node_sound_stone_defaults()
)
minetest.register_node("lottblocks:marble_brick", {
	description = SL("Marble Brick"),
	tiles = {"lottblocks_marble_brick.png"},
	is_ground_content = false,
	groups = {cracky=2},
})
stairs.register_stair_and_slab("marble_brick", "lottblocks:marble_brick",
		{cracky=2},
		{"lottblocks_marble_brick.png"},
		SL("Marble Brick Stair"),
		SL("Marble Brick Slab"),
		default.node_sound_stone_defaults()
)
minetest.register_craft({
	output = 'lottblocks:marble_brick 4',
	recipe = {
		{'lottores:marble', 'lottores:marble'},
		{'lottores:marble', 'lottores:marble'},
	}
})
minetest.register_craft({
	output = 'lottblocks:orc_brick 4',
	recipe = {
		{'lottmapgen:mordor_stone', 'lottmapgen:mordor_stone'},
		{'lottmapgen:mordor_stone', 'lottmapgen:mordor_stone'},
	}
})

if minetest.settings:get_bool("msg_loading_mods") then minetest.log("action", minetest.get_current_modname().." mod LOADED") end
