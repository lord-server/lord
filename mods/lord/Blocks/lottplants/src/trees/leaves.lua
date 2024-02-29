local S = minetest.get_translator("lottplants")


minetest.register_node("lottplants:alderleaf", {
	description                = S("Alder Leaf"),
	drawtype                   = "mesh",
	mesh                       = "leaves_model.obj",
	tiles                      = { "lottplants_alderleaf.png" },
	use_texture_alpha          = "clip",
	inventory_image            = "lottplants_alderleaf_inv.png",
	paramtype                  = "light",
	waving                     = 2,
	walkable                   = false,
	--climbable=true,
	liquid_viscosity           = 8,
	liquidtype                 = "source",
	liquid_alternative_flowing = "lottplants:alderleaf",
	liquid_alternative_source  = "lottplants:alderleaf",
	liquid_renewable           = false,
	liquid_range               = 0,

	groups                     = { snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, color_green = 1 },
	drop                       = {
		max_items = 1,
		items     = {
			{
				items  = { 'lottplants:aldersapling' },
				rarity = 20,
			},
			{
				items = { 'lottplants:alderleaf' },
			}
		}
	},
	sounds                     = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:appleleaf", {
	description                = S("Apple Leaf"),
	drawtype                   = "mesh",
	mesh                       = "leaves_model.obj",
	tiles                      = { "lottplants_appleleaf.png" },
	use_texture_alpha          = "clip",
	inventory_image            = "lottplants_appleleaf_inv.png",
	paramtype                  = "light",
	waving                     = 2,
	walkable                   = false,
	--climbable=true,
	liquid_viscosity           = 8,
	liquidtype                 = "source",
	liquid_alternative_flowing = "lottplants:appleleaf",
	liquid_alternative_source  = "lottplants:appleleaf",
	liquid_renewable           = false,
	liquid_range               = 0,

	groups                     = { snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, color_green = 1 },
	drop                       = {
		max_items = 1,
		items     = {
			{
				items  = { 'lottplants:applesapling' },
				rarity = 20,
			},
			{
				items = { 'lottplants:appleleaf' },
			}
		}
	},
	sounds                     = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:birchleaf", {
	description                = S("Birch Leaf"),
	drawtype                   = "mesh",
	mesh                       = "leaves_model.obj",
	tiles                      = { "lottplants_birchleaf.png" },
	use_texture_alpha          = "clip",
	inventory_image            = "lottplants_birchleaf_inv.png",
	paramtype                  = "light",
	waving                     = 2,
	walkable                   = false,
	--climbable=true,
	liquid_viscosity           = 8,
	liquidtype                 = "source",
	liquid_alternative_flowing = "lottplants:birchleaf",
	liquid_alternative_source  = "lottplants:birchleaf",
	liquid_renewable           = false,
	liquid_range               = 0,

	groups                     = { snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, color_green = 1 },
	drop                       = {
		max_items = 1,
		items     = {
			{
				items  = { 'lottplants:birchsapling' },
				rarity = 20,
			},
			{
				items = { 'lottplants:birchleaf' },
			}
		}
	},
	sounds                     = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:beechleaf", {
	description                = S("Beech Leaf"),
	drawtype                   = "mesh",
	mesh                       = "leaves_model.obj",
	tiles                      = { "lottplants_beechleaf.png" },
	use_texture_alpha          = "clip",
	inventory_image            = "lottplants_beechleaf_inv.png",
	paramtype                  = "light",
	waving                     = 2,
	walkable                   = false,
	--climbable=true,
	liquid_viscosity           = 8,
	liquidtype                 = "source",
	liquid_alternative_flowing = "lottplants:beechleaf",
	liquid_alternative_source  = "lottplants:beechleaf",
	liquid_renewable           = false,
	liquid_range               = 0,

	groups                     = { snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, color_green = 1 },
	drop                       = {
		max_items = 1,
		items     = {
			{
				items  = { 'lottplants:beechsapling' },
				rarity = 20,
			},
			{
				items = { 'lottplants:beechleaf' },
			}
		}
	},
	sounds                     = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:culumaldaleaf", {
	description                = S("Culumalda Leaf"),
	drawtype                   = "mesh",
	mesh                       = "leaves_model.obj",
	tiles                      = { "lottplants_culumaldaleaf.png" },
	use_texture_alpha          = "clip",
	inventory_image            = "lottplants_culumaldaleaf_inv.png",
	paramtype                  = "light",
	waving                     = 2,
	walkable                   = false,
	--climbable=true,
	liquid_viscosity           = 8,
	liquidtype                 = "source",
	liquid_alternative_flowing = "lottplants:culumaldaleaf",
	liquid_alternative_source  = "lottplants:culumaldaleaf",
	liquid_renewable           = false,
	liquid_range               = 0,

	groups                     = { snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, color_red = 1 },
	drop                       = {
		max_items = 1,
		items     = {
			{
				items  = { 'lottplants:culumaldasapling' },
				rarity = 20,
			},
			{
				items = { 'lottplants:culumaldaleaf' },
			}
		}
	},
	sounds                     = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:yellowflowers", {
	description                = S("Yellow Flowers on Culumalda Leaf"),
	drawtype                   = "mesh",
	mesh                       = "leaves_model.obj",
	tiles                      = { "lottplants_yellowflowers.png" },
	use_texture_alpha          = "clip",
	inventory_image            = "lottplants_yellowflowers_inv.png",
	paramtype                  = "light",
	waving                     = 2,
	walkable                   = false,
	--climbable=true,
	liquid_viscosity           = 8,
	liquidtype                 = "source",
	liquid_alternative_flowing = "lottplants:yellowflowers",
	liquid_alternative_source  = "lottplants:yellowflowers",
	liquid_renewable           = false,
	liquid_range               = 0,

	groups                     = { snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, color_orange = 1 },
	drop                       = {
		max_items = 3,
		items     = {
			{ items = { 'lottplants:yellowflowers' } },
		}
	},
	sounds                     = default.node_sound_leaves_defaults(),
})


minetest.register_node("lottplants:elmleaf", {
	description                = S("Elm Leaf"),
	drawtype                   = "mesh",
	mesh                       = "leaves_model.obj",
	tiles                      = { "lottplants_elmleaf.png" },
	use_texture_alpha          = "clip",
	inventory_image            = "lottplants_elmleaf_inv.png",
	paramtype                  = "light",
	waving                     = 2,
	walkable                   = false,
	--climbable=true,
	liquid_viscosity           = 8,
	liquidtype                 = "source",
	liquid_alternative_flowing = "lottplants:elmleaf",
	liquid_alternative_source  = "lottplants:elmleaf",
	liquid_renewable           = false,
	liquid_range               = 0,

	groups                     = { snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, color_green = 1 },
	drop                       = {
		max_items = 1,
		items     = {
			{
				items  = { 'lottplants:elmsapling' },
				rarity = 20,
			},
			{
				items = { 'lottplants:elmleaf' },
			}
		}
	},
	sounds                     = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:firleaf", {
	description                = S("Fir Leaf"),
	drawtype                   = "mesh",
	mesh                       = "leaves_model.obj",
	tiles                      = { "lottplants_firleaf.png" },
	use_texture_alpha          = "clip",
	inventory_image            = "lottplants_firleaf_inv.png",
	paramtype                  = "light",
	waving                     = 2,
	walkable                   = false,
	--climbable=true,
	liquid_viscosity           = 8,
	liquidtype                 = "source",
	liquid_alternative_flowing = "lottplants:firleaf",
	liquid_alternative_source  = "lottplants:firleaf",
	liquid_renewable           = false,
	liquid_range               = 0,

	groups                     = { snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, color_green = 1 },
	drop                       = {
		max_items = 1,
		items     = {
			{
				items  = { 'lottplants:firsapling' },
				rarity = 20,
			},
			{
				items = { 'lottplants:firleaf' },
			}
		}
	},
	sounds                     = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:lebethronleaf", {
	description                = S("Lebethron Leaf"),
	drawtype                   = "mesh",
	mesh                       = "leaves_model.obj",
	tiles                      = { "lottplants_lebethronleaf.png" },
	use_texture_alpha          = "clip",
	inventory_image            = "lottplants_lebethronleaf_inv.png",
	paramtype                  = "light",
	waving                     = 2,
	walkable                   = false,
	--climbable=true,
	liquid_viscosity           = 8,
	liquidtype                 = "source",
	liquid_alternative_flowing = "lottplants:lebethronleaf",
	liquid_alternative_source  = "lottplants:lebethronleaf",
	liquid_renewable           = false,
	liquid_range               = 0,

	groups                     = { snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, color_green = 1 },
	drop                       = {
		max_items = 1,
		items     = {
			{
				items  = { 'lottplants:lebethronsapling' },
				rarity = 20,
			},
			{
				items = { 'lottplants:lebethronleaf' },
			}
		}
	},
	sounds                     = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:mallornleaf", {
	description                = S("Mallorn Leaf"),
	drawtype                   = "mesh",
	mesh                       = "leaves_model.obj",
	tiles                      = { "lottplants_mallornleaf.png" },
	use_texture_alpha          = "clip",
	inventory_image            = "lottplants_mallornleaf_inv.png",
	paramtype                  = "light",
	waving                     = 2,
	walkable                   = false,
	--climbable=true,
	liquid_viscosity           = 8,
	liquidtype                 = "source",
	liquid_alternative_flowing = "lottplants:mallornleaf",
	liquid_alternative_source  = "lottplants:mallornleaf",
	liquid_renewable           = false,
	liquid_range               = 0,
	groups                     = { snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, color_yellow = 1 },
	drop                       = {
		max_items = 1,
		items     = {
			{
				items  = { 'lottplants:mallornsapling' },
				rarity = 20,
			},
			{
				items = { 'lottplants:mallornleaf' },
			}
		}
	},
	sounds                     = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:pineleaf", {
	description                = S("Pine Leaf"),
	drawtype                   = "mesh",
	mesh                       = "leaves_model.obj",
	tiles                      = { "lottplants_pineleaf.png" },
	use_texture_alpha          = "clip",
	inventory_image            = "lottplants_pineleaf_inv.png",
	paramtype                  = "light",
	waving                     = 2,
	walkable                   = false,
	--climbable=true,
	liquid_viscosity           = 8,
	liquidtype                 = "source",
	liquid_alternative_flowing = "lottplants:pineleaf",
	liquid_alternative_source  = "lottplants:pineleaf",
	liquid_renewable           = false,
	liquid_range               = 0,

	groups                     = { snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, color_green = 1 },
	drop                       = {
		max_items = 1,
		items     = {
			{
				items  = { 'lottplants:pinesapling' },
				rarity = 20,
			},
			{
				items = { 'lottplants:pineleaf' },
			}
		}
	},
	sounds                     = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:plumleaf", {
	description                = S("Plum Leaf"),
	drawtype                   = "mesh",
	mesh                       = "leaves_model.obj",
	tiles                      = { "lottplants_plumleaf.png" },
	use_texture_alpha          = "clip",
	inventory_image            = "lottplants_plumleaf_inv.png",
	paramtype                  = "light",
	waving                     = 2,
	walkable                   = false,
	--climbable=true,
	liquid_viscosity           = 8,
	liquidtype                 = "source",
	liquid_alternative_flowing = "lottplants:plumleaf",
	liquid_alternative_source  = "lottplants:plumleaf",
	liquid_renewable           = false,
	liquid_range               = 0,

	groups                     = { snappy = 3, leafdecay = 3, flammable = 2, leaves = 1 },
	drop                       = {
		max_items = 1,
		items     = {
			{
				items  = { 'lottplants:plumsapling' },
				rarity = 20,
			},
			{
				items = { 'lottplants:plumleaf' },
			}
		}
	},
	sounds                     = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:rowanleaf", {
	description                = S("Rowan Leaf"),
	drawtype                   = "mesh",
	mesh                       = "leaves_model.obj",
	tiles                      = { "lottplants_rowanleaf.png" },
	use_texture_alpha          = "clip",
	inventory_image            = "lottplants_rowanleaf_inv.png",
	walkable                   = false,
	--climbable=true,
	liquid_viscosity           = 8,
	liquidtype                 = "source",
	liquid_alternative_flowing = "lottplants:rowanleaf",
	liquid_alternative_source  = "lottplants:rowanleaf",
	liquid_renewable           = false,
	liquid_range               = 0,

	paramtype                  = "light",
	waving                     = 2,
	groups                     = { snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, color_yellow = 1 },
	drop                       = {
		max_items = 1,
		items     = {
			{ items = { 'lottplants:rowansapling' }, rarity = 20 },
			{ items = { 'lottfarming:berries' }, rarity = 200 },
			{ items = { 'lottplants:rowanleaf' } },
		}
	},
	sounds                     = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:rowanberry", {
	description                = S("Rowan Leaf with Berries"),
	drawtype                   = "mesh",
	mesh                       = "leaves_model.obj",
	tiles                      = { "lottplants_rowanberry.png" },
	use_texture_alpha          = "clip",
	inventory_image            = "lottplants_rowanberry_inv.png",
	paramtype                  = "light",
	waving                     = 2,
	walkable                   = false,
	--climbable=true,
	liquid_viscosity           = 8,
	liquidtype                 = "source",
	liquid_alternative_flowing = "lottplants:rowanberry",
	liquid_alternative_source  = "lottplants:rowanberry",
	liquid_renewable           = false,
	liquid_range               = 0,

	groups                     = { snappy = 3, leafdecay = 3, flammable = 2, leaves = 1 },
	drop                       = {
		max_items = 2,
		items     = {
			{ items = { 'lottplants:rowanleaf' } },
			{ items = { 'lottfarming:berries' } },
		}
	},
	sounds                     = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:whiteleaf", {
	description                = S("White Leaf"),
	drawtype                   = "mesh",
	mesh                       = "leaves_model.obj",
	tiles                      = { "lottplants_whiteleaf.png" },
	use_texture_alpha          = "clip",
	inventory_image            = "lottplants_whiteleaf_inv.png",
	paramtype                  = "light",
	waving                     = 2,
	walkable                   = false,
	--climbable=true,
	liquid_viscosity           = 8,
	liquidtype                 = "source",
	liquid_alternative_flowing = "lottplants:whiteleaf",
	liquid_alternative_source  = "lottplants:whiteleaf",
	liquid_renewable           = false,
	liquid_range               = 0,

	groups                     = { snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, color_white = 1 },
	drop                       = {
		max_items = 1,
		items     = {
			{
				items  = { 'lottplants:whitesapling' },
				rarity = 20,
			},
			{
				items = { 'lottplants:whiteleaf' },
			}
		}
	},
	sounds                     = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottplants:yavannamireleaf", {
	description                = S("Yavannamire Leaf"),
	drawtype                   = "mesh",
	mesh                       = "leaves_model.obj",
	tiles                      = { "lottplants_yavannamireleaf.png" },
	use_texture_alpha          = "clip",
	inventory_image            = "lottplants_yavannamireleaf_inv.png",
	paramtype                  = "light",
	waving                     = 2,
	walkable                   = false,
	--climbable=true,
	liquid_viscosity           = 8,
	liquidtype                 = "source",
	liquid_alternative_flowing = "lottplants:yavannamireleaf",
	liquid_alternative_source  = "lottplants:yavannamireleaf",
	liquid_renewable           = false,
	liquid_range               = 0,

	groups                     = { snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, color_green = 1 },
	drop                       = {
		max_items = 1,
		items     = {
			{
				items  = { 'lottplants:yavannamiresapling' },
				rarity = 20,
			},
			{
				items = { 'lottplants:yavannamireleaf' },
			}
		}
	},
	sounds                     = default.node_sound_leaves_defaults(),
})

minetest.register_alias("lottmapgen:mirkleaves", "lottplants:mirkleaf")
minetest.register_node("lottplants:mirkleaf", {
	description                = S("Mirkwood Leaves"),
	drawtype                   = "mesh",
	mesh                       = "leaves_model.obj",
	tiles                      = { "lottplants_mirkleaf.png" },
	use_texture_alpha          = "clip",
	inventory_image            = "lottplants_mirkleaf_inv.png",
	paramtype                  = "light",
	waving                     = 2,
	sunlight_propagates        = false,
	is_ground_content          = false,
	walkable                   = false,
	--climbable=true,
	liquid_viscosity           = 8,
	liquidtype                 = "source",
	liquid_alternative_flowing = "lottplants:mirkleaf",
	liquid_alternative_source  = "lottplants:mirkleaf",
	liquid_renewable           = false,
	liquid_range               = 0,

	groups                     = { snappy = 3, leafdecay = 3, flammable = 2, leaves = 1, color_green = 1 },
	drop                       = {
		max_items = 1,
		items     = {
			{
				items  = { 'lottplants:mirksapling' },
				rarity = 20,
			},
			{
				items = { 'lottplants:mirkleaf' },
			}
		}
	},
	sounds                     = default.node_sound_leaves_defaults(),
})
