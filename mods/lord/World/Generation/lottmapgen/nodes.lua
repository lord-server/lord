local S = minetest.get_translator("lottmapgen")

minetest.register_node("lottmapgen:angsnowblock", {
	description       = S("Snow Block"),
	tiles             = { "default_snow.png" },
	is_ground_content = true,
	drop              = 'default:snowblock',
	freezemelt        = "default:water_source",
	groups            = { crumbly = 3, melts = 1 },
	sounds            = default.node_sound_dirt_defaults({
		footstep = { name = "default_snow_footstep", gain = 0.25 },
		dug      = { name = "default_snow_footstep", gain = 0.75 },
	}),
})

minetest.register_node("lottmapgen:mordor_stone", {
	description       = S("Mordor Stone"),
	tiles             = { "lottmapgen_mordor_stone.png" },
	is_ground_content = true,
	drop              = "lottmapgen:mordor_cobble",
	groups            = { cracky = 3, stone = 1 },
	sounds            = default.node_sound_stone_defaults(),
})

stairs.register_stair_and_slab(
	"mordor_stone",
	"lottmapgen:mordor_stone",
	{ cracky = 3, stone = 1 },
	{ "lottmapgen_mordor_stone.png" },
	S("Mordor Stone Stair"),
	S("Mordor Stone Slab"),
	default.node_sound_stone_defaults(),
	true,
	S("Inner Mordor Stone Stair"),
	S("Outer Mordor Stone Stair")
)

minetest.register_node("lottmapgen:mordor_cobble", {
	description       = S("Mordor Cobble"),
	tiles             = { "lottmapgen_mordor_cobble.png" },
	is_ground_content = true,
	groups            = { cracky = 3, stone = 1 },
	sounds            = default.node_sound_stone_defaults(),
})

stairs.register_stair_and_slab(
	"mordor_cobble",
	"lottmapgen:mordor_cobble",
	{ cracky = 3, stone = 1 },
	{ "lottmapgen_mordor_cobble.png" },
	S("Mordor Cobble Stair"),
	S("Mordor Cobble Slab"),
	default.node_sound_stone_defaults(),
	true,
	S("Inner Mordor Cobble Stair"),
	S("Outer Mordor Cobble Stair")
)

minetest.register_node("lottmapgen:mordor_gravel", {
	description = S("Mordor Gravel"),
	tiles       = { "lottmapgen_mordor_gravel.png" },
	groups      = { crumbly = 2, falling_node = 1 },
	sounds      = default.node_sound_gravel_defaults(),
	drop        = {
		max_items = 1,
		items     = {
			{ items = { "default:flint" }, rarity = 16 },
			{ items = { "lottmapgen:mordor_gravel" } }
		}
	}
})

minetest.register_craft({
	type   = "cooking",
	output = "lottmapgen:mordor_stone",
	recipe = "lottmapgen:mordor_cobble",
})

minetest.register_node("lottmapgen:blacksource", {
	description                = S("Black Water Source"),
	drawtype                   = "liquid",
	waving                     = 3,
	inventory_image            = minetest.inventorycube("lottmapgen_black_water.png"),
	tiles                      = {
		{
			name             = "lottmapgen_black_water_source_animated.png",
			backface_culling = false,
			animation        = {
				type     = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length   = 2.0,
			},
		},
		{
			name             = "lottmapgen_black_water_source_animated.png",
			backface_culling = true,
			animation        = {
				type     = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length   = 2.0,
			},
		},
	},
	use_texture_alpha          = "blend",
	paramtype                  = "light",
	walkable                   = false,
	pointable                  = false,
	diggable                   = false,
	buildable_to               = true,
	drowning                   = 1,
	liquidtype                 = "source",
	liquid_alternative_flowing = "lottmapgen:blackflowing",
	liquid_alternative_source  = "lottmapgen:blacksource",
	liquid_viscosity           = 1,
	damage_per_second          = 1,
	post_effect_color          = { a = 192, r = 140, g = 140, b = 140 },
	groups                     = { water = 3, liquid = 3, puts_out_fire = 1 },
})

minetest.register_node("lottmapgen:blackflowing", {
	drawtype                   = "flowingliquid",
	tiles                      = { "lottmapgen_black_water.png" },
	special_tiles              = {
		{
			image            = "lottmapgen_black_water_flow.png",
			backface_culling = false,
			animation        = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1 }
		},
		{
			image            = "lottmapgen_black_water_flow.png",
			backface_culling = true,
			animation        = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1 }
		},
	},
	use_texture_alpha          = "blend",
	paramtype                  = "light",
	walkable                   = false,
	pointable                  = false,
	diggable                   = false,
	buildable_to               = true,
	liquidtype                 = "flowing",
	liquid_alternative_flowing = "lottmapgen:blackflowing",
	liquid_alternative_source  = "lottmapgen:blacksource",
	liquid_viscosity           = 1,
	damage_per_second          = 1,
	post_effect_color          = { a = 192, r = 140, g = 140, b = 140 }, -- {a=224, r=31, g=56, b=8},
	groups                     = { water = 3, liquid = 3, puts_out_fire = 1, not_in_creative_inventory = 1 },
})

minetest.register_node("lottmapgen:black_river_source", {
	description                = S("Black River Source"),
	drawtype                   = "liquid",
	inventory_image            = minetest.inventorycube("lottmapgen_black_water.png"),
	tiles                      = { "lottmapgen_black_water.png" },
	use_texture_alpha          = "blend",
	paramtype                  = "light",
	walkable                   = false,
	pointable                  = false,
	diggable                   = false,
	buildable_to               = true,
	drowning                   = 1,
	liquidtype                 = "source",
	liquid_alternative_flowing = "lottmapgen:black_river_flowing",
	liquid_alternative_source  = "lottmapgen:black_river_source",
	liquid_viscosity           = 1,
	liquid_renewable           = false,
	liquid_range               = 2,
	damage_per_second          = 1,
	post_effect_color          = { a = 192, r = 140, g = 140, b = 140 },
	groups                     = { water = 3, liquid = 3, puts_out_fire = 1 },
})

minetest.register_node("lottmapgen:black_river_flowing", {
	drawtype                   = "flowingliquid",
	tiles                      = { "lottmapgen_black_water.png" },
	special_tiles              = {
		{
			image            = "lottmapgen_black_water_flow.png",
			backface_culling = false,
			animation        = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1 }
		},
		{
			image            = "lottmapgen_black_water_flow.png",
			backface_culling = true,
			animation        = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1 }
		},
	},
	use_texture_alpha          = "blend",
	paramtype                  = "light",
	walkable                   = false,
	pointable                  = false,
	diggable                   = false,
	buildable_to               = true,
	liquidtype                 = "flowing",
	liquid_alternative_flowing = "lottmapgen:black_river_flowing",
	liquid_alternative_source  = "lottmapgen:black_river_source",
	liquid_viscosity           = 1,
	liquid_renewable           = false,
	liquid_range               = 2,
	post_effect_color          = { a = 192, r = 140, g = 140, b = 140 }, -- {a=224, r=31, g=56, b=8},
	groups                     = { water = 3, liquid = 3, puts_out_fire = 1, not_in_creative_inventory = 1 },
})

bucket.register_liquid(
	"lottmapgen:blacksource",
	"lottmapgen:blackflowing",
	"lottmapgen:bucket_mordor",
	"lottmapgen_bucket_mordor_water.png",
	S("Mordor Water Bucket")
)

-- Grasses

minetest.register_node("lottmapgen:default_grass", {
	tiles             = {
		"default_grass.png",
		"default_dirt.png",
		{ name = "default_dirt.png^default_grass_side.png", tileable_vertical = false }
	},
	is_ground_content = true,
	groups            = { crumbly = 3, soil = 1, grass = 1, not_in_creative_inventory = 1, spreading_dirt_type = 1 },
	drop              = 'default:dirt',
	sounds            = default.node_sound_dirt_defaults()
})
