local S = minetest.get_translator("lord_ores")

minetest.register_node("lord_ores:magma", {
	description = S("Magma"),
	tiles       = { "lord_ores_magma.png" },
	groups      = { rock = 1, stone = 1, cracky = 2, },
	paramtype = "light",
	light_source = 4,
	sounds = default.node_sound_stone_defaults(),
})
