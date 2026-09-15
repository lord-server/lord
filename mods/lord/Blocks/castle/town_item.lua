local S = core.get_mod_translator()


core.register_alias("darkage:box", "castle:crate")
core.register_alias("cottages:straw", "farming:straw")
core.register_alias("castle:straw", "farming:straw")
core.register_alias("darkage:straw", "farming:straw")
core.register_alias("cottages:straw_bale", "castle:bound_straw")
core.register_alias("darkage:straw_bale", "castle:bound_straw")
core.register_alias("darkage:lamp", "castle:street_light")


core.register_node("castle:dungeon_stone", {
	description = S("Dungeon Stone"),
	drawtype    = "normal",
	tiles       = { "castle_dungeon_stone.png" },
	groups      = { cracky = 2, stone = 1, wall_connected = 1},
	paramtype   = "light",
	sounds      = default.node_sound_stone_defaults(),
})

core.register_craft({
	output = "castle:dungeon_stone 2",
	recipe = {
		{ "default:stonebrick", "default:obsidian" },
	}
})

core.register_craft({
	output = "castle:dungeon_stone 2",
	recipe = {
		{ "default:stonebrick" },
		{ "default:obsidian" },

	}
})

core.register_node("castle:bound_straw", {
	description = S("Bound Straw"),
	drawtype    = "normal",
	tiles       = { "castle_straw_bale.png" },
	groups      = { choppy = 4, flammable = 1, oddly_breakable_by_hand = 3, grass = 1 },
	paramtype   = "light",
	sounds      = default.node_sound_leaves_defaults(),
})

core.register_craft({
	output = "castle:bound_straw",
	recipe = {
		{ "farming:straw", "castle:ropes" },
	}
})

core.register_node("castle:pavement", {
	description = S("Paving Stone"),
	drawtype    = "normal",
	tiles       = { "castle_pavement_brick.png" },
	groups      = { cracky = 2, wall_connected = 1 },
	paramtype   = "light",
	sounds      = default.node_sound_stone_defaults(),
})

core.register_craft({
	output = "castle:pavement 4",
	recipe = {
		{ "default:stone", "default:cobble" },
		{ "default:cobble", "default:stone" },
	}
})

core.register_node("castle:light", {
	drawtype            = "glasslike",
	description         = S("Light Block"),
	sunlight_propagates = true,
	light_source        = 14,
	tiles               = { "castle_street_light.png" },
	groups              = { cracky = 2 },
	paramtype           = "light",
	sounds              = default.node_sound_glass_defaults(),
})

core.register_craft({
	output = "castle:light",
	recipe = {
		{ "group:stick", "default:glass", "group:stick" },
		{ "default:glass", "default:torch", "default:glass" },
		{ "group:stick", "default:glass", "group:stick" },
	}
})
