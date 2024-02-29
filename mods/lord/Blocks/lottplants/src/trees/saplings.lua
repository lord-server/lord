local S = minetest.get_translator("lottplants")


minetest.register_node("lottplants:aldersapling", {
	description     = S("Alder Sapling"),
	drawtype        = "plantlike",
	visual_scale    = 1.0,
	tiles           = { "lottplants_aldersapling.png" },
	inventory_image = "lottplants_aldersapling.png",
	wield_image     = "lottplants_aldersapling.png",
	paramtype       = "light",
	waving          = 1,
	walkable        = false,
	selection_box     = {
		type  = "fixed",
		fixed = { -0.2, -0.5, -0.2, 0.2, 0.3, 0.2 },
	},
	groups          = { snappy = 2, dig_immediate = 3, flammable = 2, sapling = 1 },
	sounds          = default.node_sound_defaults(),
})

minetest.register_node("lottplants:applesapling", {
	description     = S("Apple Tree Sapling"),
	drawtype        = "plantlike",
	visual_scale    = 1.0,
	tiles           = { "lottplants_applesapling.png" },
	inventory_image = "lottplants_applesapling.png",
	wield_image     = "lottplants_applesapling.png",
	paramtype       = "light",
	waving          = 1,
	walkable        = false,
	selection_box     = {
		type  = "fixed",
		fixed = { -0.2, -0.5, -0.2, 0.2, 0.3, 0.2 },
	},
	groups          = { snappy = 2, dig_immediate = 3, flammable = 2, sapling = 1 },
	sounds          = default.node_sound_defaults(),
})

minetest.register_node("lottplants:birchsapling", {
	description     = S("Birch Sapling"),
	drawtype        = "plantlike",
	visual_scale    = 1.0,
	tiles           = { "lottplants_birchsapling.png" },
	inventory_image = "lottplants_birchsapling.png",
	wield_image     = "lottplants_birchsapling.png",
	paramtype       = "light",
	waving          = 1,
	walkable        = false,
	selection_box     = {
		type  = "fixed",
		fixed = { -0.2, -0.5, -0.2, 0.2, 0.3, 0.2 },
	},
	groups          = { snappy = 2, dig_immediate = 3, flammable = 2, sapling = 1 },
	sounds          = default.node_sound_defaults(),
})

minetest.register_node("lottplants:beechsapling", {
	description     = S("Beech Sapling"),
	drawtype        = "plantlike",
	visual_scale    = 1.0,
	tiles           = { "lottplants_beechsapling.png" },
	inventory_image = "lottplants_beechsapling.png",
	wield_image     = "lottplants_beechsapling.png",
	paramtype       = "light",
	waving          = 1,
	walkable        = false,
	selection_box     = {
		type  = "fixed",
		fixed = { -0.2, -0.5, -0.2, 0.2, 0.3, 0.2 },
	},
	groups          = { snappy = 2, dig_immediate = 3, flammable = 2, sapling = 1 },
	sounds          = default.node_sound_defaults(),
})

minetest.register_node("lottplants:culumaldasapling", {
	description     = S("Culumalda Sapling"),
	drawtype        = "plantlike",
	visual_scale    = 1.0,
	tiles           = { "lottplants_culumaldasapling.png" },
	inventory_image = "lottplants_culumaldasapling.png",
	wield_image     = "lottplants_culumaldasapling.png",
	paramtype       = "light",
	waving          = 1,
	walkable        = false,
	selection_box     = {
		type  = "fixed",
		fixed = { -0.2, -0.5, -0.2, 0.2, 0.3, 0.2 },
	},
	groups          = { snappy = 2, dig_immediate = 3, flammable = 2, sapling = 1 },
	sounds          = default.node_sound_defaults(),
})

minetest.register_node("lottplants:elmsapling", {
	description     = S("Elm Sapling"),
	drawtype        = "plantlike",
	visual_scale    = 1.0,
	tiles           = { "lottplants_elmsapling.png" },
	inventory_image = "lottplants_elmsapling.png",
	wield_image     = "lottplants_elmsapling.png",
	paramtype       = "light",
	waving          = 1,
	walkable        = false,
	selection_box     = {
		type  = "fixed",
		fixed = { -0.2, -0.5, -0.2, 0.2, 0.3, 0.2 },
	},
	groups          = { snappy = 2, dig_immediate = 3, flammable = 2, sapling = 1 },
	sounds          = default.node_sound_defaults(),
})

minetest.register_node("lottplants:firsapling", {
	description     = S("Fir Sapling"),
	drawtype        = "plantlike",
	visual_scale    = 1.0,
	tiles           = { "lottplants_firsapling.png" },
	inventory_image = "lottplants_firsapling.png",
	wield_image     = "lottplants_firsapling.png",
	paramtype       = "light",
	waving          = 1,
	walkable        = false,
	selection_box     = {
		type  = "fixed",
		fixed = { -0.2, -0.5, -0.2, 0.2, 0.3, 0.2 },
	},
	groups          = { snappy = 2, dig_immediate = 3, flammable = 2, sapling = 1 },
	sounds          = default.node_sound_defaults(),
})

minetest.register_node("lottplants:lebethronsapling", {
	description     = S("Lebethron Sapling"),
	drawtype        = "plantlike",
	visual_scale    = 1.0,
	tiles           = { "lottplants_lebethronsapling.png" },
	inventory_image = "lottplants_lebethronsapling.png",
	wield_image     = "lottplants_lebethronsapling.png",
	paramtype       = "light",
	waving          = 1,
	walkable        = false,
	selection_box     = {
		type  = "fixed",
		fixed = { -0.2, -0.5, -0.2, 0.2, 0.3, 0.2 },
	},
	groups          = { snappy = 2, dig_immediate = 3, flammable = 2, sapling = 1 },
	sounds          = default.node_sound_defaults(),
})

minetest.register_node("lottplants:mallornsapling", {
	description     = S("Mallorn Sapling"),
	drawtype        = "plantlike",
	visual_scale    = 1.0,
	tiles           = { "lottplants_mallornsapling.png" },
	inventory_image = "lottplants_mallornsapling.png",
	wield_image     = "lottplants_mallornsapling.png",
	paramtype       = "light",
	waving          = 1,
	walkable        = false,
	selection_box     = {
		type  = "fixed",
		fixed = { -0.2, -0.5, -0.2, 0.2, 0.3, 0.2 },
	},
	groups          = { snappy = 2, dig_immediate = 3, flammable = 2, sapling = 1 },
	sounds          = default.node_sound_defaults(),
})

minetest.register_node("lottplants:pinesapling", {
	description     = S("Pine Sapling"),
	drawtype        = "plantlike",
	visual_scale    = 1.0,
	tiles           = { "lottplants_pinesapling.png" },
	inventory_image = "lottplants_pinesapling.png",
	wield_image     = "lottplants_pinesapling.png",
	paramtype       = "light",
	waving          = 1,
	walkable        = false,
	selection_box     = {
		type  = "fixed",
		fixed = { -0.2, -0.5, -0.2, 0.2, 0.3, 0.2 },
	},
	groups          = { snappy = 2, dig_immediate = 3, flammable = 2, sapling = 1 },
	sounds          = default.node_sound_defaults(),
})

minetest.register_node("lottplants:plumsapling", {
	description     = S("Plum Tree Sapling"),
	drawtype        = "plantlike",
	visual_scale    = 1.0,
	tiles           = { "lottplants_plumsapling.png" },
	inventory_image = "lottplants_plumsapling.png",
	wield_image     = "lottplants_plumsapling.png",
	paramtype       = "light",
	waving          = 1,
	walkable        = false,
	selection_box     = {
		type  = "fixed",
		fixed = { -0.2, -0.5, -0.2, 0.2, 0.3, 0.2 },
	},
	groups          = { snappy = 2, dig_immediate = 3, flammable = 2, sapling = 1 },
	sounds          = default.node_sound_defaults(),
})

minetest.register_node("lottplants:rowansapling", {
	description     = S("Rowan Sapling"),
	drawtype        = "plantlike",
	visual_scale    = 1.0,
	tiles           = { "lottplants_rowansapling.png" },
	inventory_image = "lottplants_rowansapling.png",
	wield_image     = "lottplants_rowansapling.png",
	paramtype       = "light",
	waving          = 1,
	walkable        = false,
	selection_box     = {
		type  = "fixed",
		fixed = { -0.2, -0.5, -0.2, 0.2, 0.3, 0.2 },
	},
	groups          = { snappy = 2, dig_immediate = 3, flammable = 2, sapling = 1 },
	sounds          = default.node_sound_defaults(),
})

minetest.register_node("lottplants:whitesapling", {
	description     = S("White Tree Sapling"),
	drawtype        = "plantlike",
	visual_scale    = 1.0,
	tiles           = { "lottplants_whitesapling.png" },
	inventory_image = "lottplants_whitesapling.png",
	wield_image     = "lottplants_whitesapling.png",
	paramtype       = "light",
	waving          = 1,
	walkable        = false,
	selection_box     = {
		type  = "fixed",
		fixed = { -0.2, -0.5, -0.2, 0.2, 0.3, 0.2 },
	},
	groups          = { snappy = 2, dig_immediate = 3, flammable = 2, sapling = 1 },
	sounds          = default.node_sound_defaults(),
})

minetest.register_node("lottplants:yavannamiresapling", {
	description     = S("Yavannamire Sapling"),
	drawtype        = "plantlike",
	visual_scale    = 1.0,
	tiles           = { "lottplants_yavannamiresapling.png" },
	inventory_image = "lottplants_yavannamiresapling.png",
	wield_image     = "lottplants_yavannamiresapling.png",
	paramtype       = "light",
	waving          = 1,
	walkable        = false,
	selection_box     = {
		type  = "fixed",
		fixed = { -0.2, -0.5, -0.2, 0.2, 0.3, 0.2 },
	},
	groups          = { snappy = 2, dig_immediate = 3, flammable = 2, sapling = 1 },
	sounds          = default.node_sound_defaults(),
})

minetest.register_node("lottplants:mirksapling", {
	description     = S("Mirkwood Sapling"),
	drawtype        = "plantlike",
	visual_scale    = 1.0,
	tiles           = { "lottplants_mirksapling.png" },
	inventory_image = "lottplants_mirksapling.png",
	wield_image     = "lottplants_mirksapling.png",
	paramtype       = "light",
	waving          = 1,
	walkable        = false,
	selection_box     = {
		type  = "fixed",
		fixed = { -0.2, -0.5, -0.2, 0.2, 0.3, 0.2 },
	},
	groups          = { snappy = 2, dig_immediate = 3, flammable = 2, sapling = 1 },
	sounds          = default.node_sound_defaults(),
})
