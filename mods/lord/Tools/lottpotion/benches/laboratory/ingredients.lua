local SL = minetest.get_mod_translator()

-- Base Ingredients
minetest.register_node("lottpotion:glass_bottle_mese", {
	description     = SL("Glass Bottle (Mese Water)"),
	drawtype        = "plantlike",
	tiles           = { "vessels_glass_bottle.png^lottpotion_water_mese.png" },
	inventory_image = "vessels_glass_bottle.png^lottpotion_water_mese.png",
	wield_image     = "vessels_glass_bottle.png^lottpotion_water_mese.png",
	paramtype       = "light",
	walkable        = false,
	selection_box   = {
		type  = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.4, 0.25 }
	},
	groups          = { vessel = 1, dig_immediate = 3, attached_node = 1 },
	sounds          = default.node_sound_glass_defaults(),
})

minetest.register_node("lottpotion:glass_bottle_geodes", {
	description     = SL("Glass Bottle (Geodes Crystal Water)"),
	drawtype        = "plantlike",
	tiles           = { "vessels_glass_bottle.png^lottpotion_water_geodes.png" },
	inventory_image = "vessels_glass_bottle.png^lottpotion_water_geodes.png",
	wield_image     = "vessels_glass_bottle.png^lottpotion_water_geodes.png",
	paramtype       = "light",
	walkable        = false,
	selection_box   = {
		type  = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.4, 0.25 }
	},
	groups          = { vessel = 1, dig_immediate = 3, attached_node = 1 },
	sounds          = default.node_sound_glass_defaults(),
})

minetest.register_node("lottpotion:glass_bottle_seregon", {
	description     = SL("Glass Bottle (Seregon Water)"),
	drawtype        = "plantlike",
	tiles           = { "vessels_glass_bottle.png^lottpotion_water_seregon.png" },
	inventory_image = "vessels_glass_bottle.png^lottpotion_water_seregon.png",
	wield_image     = "vessels_glass_bottle.png^lottpotion_water_seregon.png",
	paramtype       = "light",
	walkable        = false,
	selection_box   = {
		type  = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.4, 0.25 }
	},
	groups          = { vessel = 1, dig_immediate = 3, attached_node = 1 },
	sounds          = default.node_sound_glass_defaults(),
})

-- Negative Base Ingredients
minetest.register_node("lottpotion:glass_bottle_obsidian", {
	description     = SL("Glass Bottle (Obsidian Water)"),
	drawtype        = "plantlike",
	tiles           = { "vessels_glass_bottle.png^lottpotion_water_obsidian.png" },
	inventory_image = "vessels_glass_bottle.png^lottpotion_water_obsidian.png",
	wield_image     = "vessels_glass_bottle.png^lottpotion_water_obsidian.png",
	paramtype       = "light",
	walkable        = false,
	selection_box   = {
		type  = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.4, 0.25 }
	},
	groups          = { vessel = 1, dig_immediate = 3, attached_node = 1 },
	sounds          = default.node_sound_glass_defaults(),
})

minetest.register_node("lottpotion:glass_bottle_bonedust", {
	description     = SL("Glass Bottle (Bonedust Water)"),
	drawtype        = "plantlike",
	tiles           = { "vessels_glass_bottle.png^lottpotion_water_bonedust.png" },
	inventory_image = "vessels_glass_bottle.png^lottpotion_water_bonedust.png",
	wield_image     = "vessels_glass_bottle.png^lottpotion_water_bonedust.png",
	paramtype       = "light",
	walkable        = false,
	selection_box   = {
		type  = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.4, 0.25 }
	},
	groups          = { vessel = 1, dig_immediate = 3, attached_node = 1 },
	sounds          = default.node_sound_glass_defaults(),
})

minetest.register_node("lottpotion:glass_bottle_mordor", {
	description     = SL("Glass Bottle (Mordor Water)"),
	drawtype        = "plantlike",
	tiles           = { "vessels_glass_bottle.png^lottpotion_water_mordor.png" },
	inventory_image = "vessels_glass_bottle.png^lottpotion_water_mordor.png",
	wield_image     = "vessels_glass_bottle.png^lottpotion_water_mordor.png",
	paramtype       = "light",
	walkable        = false,
	selection_box   = {
		type  = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.4, 0.25 }
	},
	groups          = { vessel = 1, dig_immediate = 3, attached_node = 1 },
	sounds          = default.node_sound_glass_defaults(),
})
