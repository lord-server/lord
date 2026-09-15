-- Crafting for homedecor mod (includes folding) by Vanessa Ezekowitz
--
-- Mostly my own code; overall template borrowed from game default

local S = core.get_mod_translator()

-- misc craftitems

core.register_craftitem("lord_homedecor:terracotta_base", {
	description     = S("Uncooked Terracotta Base"),
	inventory_image = "homedecor_terracotta_base.png",
})

core.register_craftitem("lord_homedecor:roof_tile_terracotta", {
	description     = S("Terracotta Roof Tile"),
	inventory_image = "homedecor_roof_tile_terracotta.png",
})

--core.register_craftitem("lord_homedecor:oil_extract", {
--description = S("Oil extract"),
--inventory_image = "homedecor_oil_extract.png",
--})

core.register_craft({
	type         = "shapeless",
	output       = "lord_homedecor:terracotta_base 8",
	recipe       = {
		"default:dirt",
		"default:clay_lump",
		"bucket:bucket_water"
	},
	replacements = { { "bucket:bucket_water", "bucket:bucket_empty" }, },
})

core.register_craft({
	type   = "cooking",
	output = "lord_homedecor:roof_tile_terracotta",
	recipe = "lord_homedecor:terracotta_base",
})

core.register_craft({
	output = "lord_homedecor:shingles_terracotta",
	recipe = {
		{ "lord_homedecor:roof_tile_terracotta", "lord_homedecor:roof_tile_terracotta" },
		{ "lord_homedecor:roof_tile_terracotta", "lord_homedecor:roof_tile_terracotta" },
	},
})

core.register_craft({
	output = "lord_homedecor:flower_pot_terracotta",
	recipe = {
		{ "lord_homedecor:roof_tile_terracotta", "default:dirt", "lord_homedecor:roof_tile_terracotta" },
		{ "", "lord_homedecor:roof_tile_terracotta", "" },
	},
})

-- кровля
core.register_craft({
	output = "lord_homedecor:shingles_wood 12",
	recipe = {
		{ "group:stick", "group:wood" },
		{ "group:wood", "group:stick" },
	},
})

core.register_craft({
	output = "lord_homedecor:shingles_wood 12",
	recipe = {
		{ "group:wood", "group:stick" },
		{ "group:stick", "group:wood" },
	},
})

core.register_craft({
	type     = "fuel",
	recipe   = "lord_homedecor:shingles_wood",
	burntime = 30,
})

----

-- мансардные стекла
core.register_craft({
	output = "lord_homedecor:skylight 4",
	recipe = {
		{ "default:glass", "default:glass" },
	},
})

core.register_craft({
	type   = "shapeless",
	output = "lord_homedecor:skylight_frosted",
	recipe = {
		"dye:white",
		"lord_homedecor:skylight"
	},
})

core.register_craft({
	type   = "cooking",
	output = "lord_homedecor:skylight",
	recipe = "lord_homedecor:skylight_frosted",
})
--

---- Various colors of shutters / окрашенные ставни
core.register_craft({
	output = "lord_homedecor:shutter_oak 2",
	recipe = {
		{ "group:stick", "group:stick" },
		{ "group:stick", "group:stick" },
		{ "group:stick", "group:stick" },
	},
})

core.register_craft({
	type     = "fuel",
	recipe   = "lord_homedecor:shutter_oak",
	burntime = 30,
})

----

core.register_craft({
	type   = "shapeless",
	output = "lord_homedecor:shutter_black 4",
	recipe = {
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"dye:black"
	},
})

core.register_craft({
	type     = "fuel",
	recipe   = "lord_homedecor:shutter_black",
	burntime = 30,
})

----

core.register_craft({
	type   = "shapeless",
	output = "lord_homedecor:shutter_dark_grey 4",
	recipe = {
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"dye:dark_grey"
	},
})

core.register_craft({
	type     = "fuel",
	recipe   = "lord_homedecor:shutter_dark_grey",
	burntime = 30,
})

----

core.register_craft({
	type   = "shapeless",
	output = "lord_homedecor:shutter_grey 4",
	recipe = {
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"dye:grey"
	},
})

core.register_craft({
	type     = "fuel",
	recipe   = "lord_homedecor:shutter_grey",
	burntime = 30,
})

--

core.register_craft({
	type   = "shapeless",
	output = "lord_homedecor:shutter_white 4",
	recipe = {
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"dye:white"
	},
})

core.register_craft({
	type     = "fuel",
	recipe   = "lord_homedecor:shutter_white",
	burntime = 30,
})

--

core.register_craft({
	type   = "shapeless",
	output = "lord_homedecor:shutter_mahogany 4",
	recipe = {
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"dye:brown"
	},
})

core.register_craft({
	type     = "fuel",
	recipe   = "lord_homedecor:shutter_mahogany",
	burntime = 30,
})

----

core.register_craft({
	type   = "shapeless",
	output = "lord_homedecor:shutter_red 4",
	recipe = {
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"dye:red"
	},
})

core.register_craft({
	type     = "fuel",
	recipe   = "lord_homedecor:shutter_red",
	burntime = 30,
})

core.register_craft({
	type   = "shapeless",
	output = "lord_homedecor:shutter_yellow 4",
	recipe = {
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"dye:yellow"
	},
})

core.register_craft({
	type     = "fuel",
	recipe   = "lord_homedecor:shutter_yellow",
	burntime = 30,
})

--

core.register_craft({
	type   = "shapeless",
	output = "lord_homedecor:shutter_forest_green 4",
	recipe = {
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"dye:dark_green"
	},
})

core.register_craft({
	type     = "fuel",
	recipe   = "lord_homedecor:shutter_forest_green",
	burntime = 30,
})

--

core.register_craft({
	type   = "shapeless",
	output = "lord_homedecor:shutter_light_blue 4",
	recipe = {
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"dye:blue"
	},
})

core.register_craft({
	type     = "fuel",
	recipe   = "lord_homedecor:shutter_light_blue",
	burntime = 30,
})

----

core.register_craft({
	type   = "shapeless",
	output = "lord_homedecor:shutter_violet 4",
	recipe = {
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"dye:violet"
	},
})

core.register_craft({
	type     = "fuel",
	recipe   = "lord_homedecor:shutter_violet",
	burntime = 30,
})

core.register_craft({
	output = "lord_homedecor:pole_wrought_iron 6",
	recipe = {
		{ "default:steel_ingot", },
		{ "default:steel_ingot", },
		{ "default:steel_ingot", },
	},
})

-- Lighting / Освещение

-- candles / свечи

core.register_craft({
	output = "lord_homedecor:candle_thin 4",
	recipe = {
		{ "farming:string" },
		{ "bees:wax" }
	}
})

core.register_craft({
	output = "lord_homedecor:candle 2",
	recipe = {
		{ "farming:string" },
		{ "bees:wax" },
		{ "bees:wax" }
	}
})

core.register_craft({
	output = "lord_homedecor:wall_sconce 2",
	recipe = {
		{ "default:iron_lump", "", "" },
		{ "default:iron_lump", "lord_homedecor:candle", "" },
		{ "default:iron_lump", "", "" },
	}
})

core.register_craft({
	output = "lord_homedecor:candlestick_wrought_iron",
	recipe = {
		{ "" },
		{ "lord_homedecor:candle_thin" },
		{ "default:iron_lump" },
	}
})

core.register_craft({
	output = "lord_homedecor:candlestick_brass",
	recipe = {
		{ "" },
		{ "lord_homedecor:candle_thin" },
		{ "default:bronze_ingot" },
	}
})

core.register_craft({
	output = "lord_homedecor:well",
	recipe = {
		{ "lord_homedecor:shingles_wood", "lord_homedecor:shingles_wood", "lord_homedecor:shingles_wood" },
		{ "group:wood", "group:stick", "group:wood" },
		{ "default:cobble", "bucket:bucket_water", "default:cobble" }
	},
})

core.register_craft({
	output = "lord_homedecor:bench_large_1",
	recipe = {
		{ "group:wood", "group:wood", "group:wood" },
		{ "group:wood", "group:wood", "group:wood" },
		{ "lord_homedecor:pole_wrought_iron", "", "lord_homedecor:pole_wrought_iron" }
	},
})

core.register_craft({
	output = "lord_homedecor:bench_large_2_left",
	recipe = {
		{ "lord_homedecor:shutter_oak", "lord_homedecor:shutter_oak", "lord_homedecor:shutter_oak" },
		{ "group:wood", "group:wood", "group:wood" },
		{ "stairs:slab_wood", "", "stairs:slab_wood" }
	},
})

core.register_craft({
	output = "lord_homedecor:bench_large_2_left",
	recipe = {
		{ "lord_homedecor:shutter_oak", "lord_homedecor:shutter_oak", "lord_homedecor:shutter_oak" },
		{ "group:wood", "group:wood", "group:wood" },
		{ "stairs:slab_junglewood", "", "stairs:slab_junglewood" }
	},
})

core.register_craft({
	output = "lord_homedecor:simple_bench",
	recipe = {
		{ "stairs:slab_wood", "stairs:slab_wood", "stairs:slab_wood" },
		{ "stairs:slab_wood", "", "stairs:slab_wood" }
	},
})

core.register_craft({
	output = "lord_homedecor:window_flowerbox",
	recipe = {
		{ "lord_homedecor:roof_tile_terracotta", "default:dirt",                        "lord_homedecor:roof_tile_terracotta" }, -- luacheck: ignore
		{ "lord_homedecor:roof_tile_terracotta", "lord_homedecor:roof_tile_terracotta", "lord_homedecor:roof_tile_terracotta" }, -- luacheck: ignore
	},
})

core.register_craft({
	output = "lord_homedecor:stonepath 16",
	recipe = {
		{ "stairs:slab_stone", "", "stairs:slab_stone" },
		{ "", "stairs:slab_stone", "" },
		{ "stairs:slab_stone", "", "stairs:slab_stone" }
	},
})

core.register_craft({
	output = "lord_homedecor:swing",
	recipe = {
		{ "farming:string", "", "farming:string" },
		{ "farming:string", "", "farming:string" },
		{ "farming:string", "stairs:slab_wood", "farming:string" }
	},
})

core.register_craft({
	output = "lord_homedecor:wall_lamp 2",
	recipe = {
		{ "default:glass", "default:torch", "default:glass" },
		{ "default:iron_lump", "group:stick", "" },
		{ "default:iron_lump", "group:stick", "" },
	},
})

core.register_craft({
	output = "lord_homedecor:lattice_wood 8",
	recipe = {
		{ "group:stick", "group:wood", "group:stick" },
		{ "group:wood", "", "group:wood" },
		{ "group:stick", "group:wood", "group:stick" },
	},
})

core.register_craft({
	output = "lord_homedecor:lattice_white_wood 8",
	recipe = {
		{ "group:stick", "group:wood", "group:stick" },
		{ "group:wood", "dye:white", "group:wood" },
		{ "group:stick", "group:wood", "group:stick" },
	},
})

core.register_craft({
	output = "lord_homedecor:lattice_wood_vegetal 8",
	recipe = {
		{ "group:stick", "group:wood", "group:stick" },
		{ "group:wood", "lord_trees:lebethron_leaf", "group:wood" },
		{ "group:stick", "group:wood", "group:stick" },
	},
})

core.register_craft({
	output = "lord_homedecor:lattice_white_wood_vegetal 8",
	recipe = {
		{ "group:stick", "group:wood", "group:stick" },
		{ "group:wood", "lord_trees:lebethron_leaf", "group:wood" },
		{ "group:stick", "dye:white", "group:stick" },
	},
})

core.register_craft({
	output = "lord_homedecor:stained_glass 8",
	recipe = {
		{ "", "dye:blue", "" },
		{ "dye:red", "default:glass", "dye:green" },
		{ "", "dye:yellow", "" },
	},
})

core.register_node("lord_homedecor:flower_pot_small", {
	description       = S("Small Flower Pot"),
	inventory_image   = "homedecor_flowerpot_small_inv.png",
	drawtype          = "mesh",
	paramtype         = "light",
	mesh              = "homedecor_potted_plant.obj",
	tiles             = {
		"homedecor_flower_pot_terracotta.png",
		"default_dirt.png^[colorize:#000000:175",
		"transparent_pixel.png",
	},
	use_texture_alpha = "blend",
	selection_box   = {
		type  = 'fixed',
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.0, 0.25 }
	},
	groups            = { snappy = 3, potting_soil = 1 },
	sounds            = default.node_sound_stone_defaults(),
	is_ground_content = false,
	walkable          = false,
})

core.register_craft({
	output = "lord_homedecor:flower_pot_small",
	recipe = {
		{ "default:clay_brick", "default:dirt", "default:clay_brick" },
		{ "", "default:clay_brick", "" }
	}
})

core.register_craft({
	output = "lord_homedecor:flower_pot_small 3",
	recipe = { { "lord_homedecor:flower_pot_terracotta" } }
})

core.register_craft({
	output = "lord_homedecor:shrubbery_green 3",
	recipe = {
		{ "lord_trees:lebethron_leaf", "lord_trees:lebethron_leaf", "lord_trees:lebethron_leaf" },
		{ "lord_trees:lebethron_leaf", "lord_trees:lebethron_leaf", "lord_trees:lebethron_leaf" },
		{ "group:stick", "group:stick", "group:stick" }
	}
})

for _, color in ipairs(lord_homedecor.shrub_colors) do

	core.register_craft({
		type   = "shapeless",
		output = "lord_homedecor:shrubbery_large_" .. color,
		recipe = {
			"lord_homedecor:shrubbery_" .. color
		}
	})

	core.register_craft({
		type   = "shapeless",
		output = "lord_homedecor:shrubbery_" .. color,
		recipe = {
			"lord_homedecor:shrubbery_large_" .. color
		}
	})

	if color ~= "green" then
		core.register_craft({
			type   = "shapeless",
			output = "lord_homedecor:shrubbery_large_" .. color,
			recipe = {
				"lord_homedecor:shrubbery_large_green",
				"dye:" .. color
			}
		})

		core.register_craft({
			type   = "shapeless",
			output = "lord_homedecor:shrubbery_" .. color,
			recipe = {
				"lord_homedecor:shrubbery_green",
				"dye:" .. color
			}
		})

	end
end


-- перила
for i in ipairs(lord_homedecor.banister_materials) do

	local name    = lord_homedecor.banister_materials[i][1]
	local topmat  = lord_homedecor.banister_materials[i][5]
	local vertmat = lord_homedecor.banister_materials[i][6]
	local dye1    = lord_homedecor.banister_materials[i][7]
	local dye2    = lord_homedecor.banister_materials[i][8]

	core.register_craft({
		output = "lord_homedecor:banister_" .. name .. "_horizontal 2",
		recipe = {
			{ topmat, "", dye1 },
			{ vertmat, topmat, "" },
			{ dye2, vertmat, topmat }
		},
	})
end
