local S = minetest.get_translator("lottplants")

-- LEAVES

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

--
-- TREE
--

-- сосна (pine
minetest.register_node("lottplants:pinetrunk", {
	description = S("Pine Trunk"),
	tiles       = { "lottplants_pinetree_top.png", "lottplants_pinetree_top.png", "lottplants_pinetree.png" },
	paramtype2  = "facedir",
	drop        = "lottplants:pinetree",
	groups      = { tree = 1, choppy = 3, flammable = 2 },
	sounds      = default.node_sound_wood_defaults(),
	on_place    = minetest.rotate_node,
})

minetest.register_node("lottplants:pinetree", {
	description = S("Pine Tree"),
	tiles       = { "lottplants_pinetree_top.png", "lottplants_pinetree_top.png", "lottplants_pinetree.png" },
	paramtype2  = "facedir",
	groups      = { tree = 1, choppy = 3, flammable = 2 },
	sounds      = default.node_sound_wood_defaults(),
	on_place    = minetest.rotate_node,
	on_dig      = function(pos, node, digger)
		default.dig_tree(pos, node, "lottplants:pinetree", digger, 13, 2, "lottplants:pinetree")
	end,
})

-- ель (fir)
minetest.register_node("lottplants:firtrunk", {
	description = S("Fir Trunk"),
	tiles       = { "lottplants_fir_tree_top.png", "lottplants_fir_tree_top.png", "lottplants_fir_tree.png" },
	paramtype2  = "facedir",
	drop        = "lottplants:firtree",
	groups      = { tree = 1, choppy = 3, flammable = 2 },
	sounds      = default.node_sound_wood_defaults(),
	on_place    = minetest.rotate_node,
})

minetest.register_node("lottplants:firtree", {
	description = S("Fir Tree"),
	tiles       = { "lottplants_fir_tree_top.png", "lottplants_fir_tree_top.png", "lottplants_fir_tree.png" },
	paramtype2  = "facedir",
	groups      = { tree = 1, choppy = 3, flammable = 2 },
	sounds      = default.node_sound_wood_defaults(),
	on_place    = minetest.rotate_node,
	on_dig      = function(pos, node, digger)
		default.dig_tree(pos, node, "lottplants:firtree", digger, 13, 2, "lottplants:firtree")
	end,
})


-- берёза
minetest.register_node("lottplants:birchtrunk", {
	description = S("Birch Trunk"),
	tiles       = { "lottplants_birchtree_top.png", "lottplants_birchtree_top.png", "lottplants_birchtree.png" },
	paramtype2  = "facedir",
	drop        = "lottplants:birchtree",
	groups      = { tree = 1, choppy = 3, flammable = 2 },
	sounds      = default.node_sound_wood_defaults(),
	on_place    = minetest.rotate_node,
})

minetest.register_node("lottplants:birchtree", {
	description = S("Birch Tree"),
	tiles       = { "lottplants_birchtree_top.png", "lottplants_birchtree_top.png", "lottplants_birchtree.png" },
	paramtype2  = "facedir",
	groups      = { tree = 1, choppy = 3, flammable = 2 },
	sounds      = default.node_sound_wood_defaults(),
	on_place    = minetest.rotate_node,
	on_dig      = function(pos, node, digger)
		default.dig_tree(pos, node, "lottplants:birchtree", digger, 12, 3, "lottplants:birchtree")
	end,
})

-- ольха
minetest.register_node("lottplants:aldertrunk", {
	description = S("Alder Trunk"),
	tiles       = { "lottplants_aldertree_top.png", "lottplants_aldertree_top.png", "lottplants_aldertree.png" },
	paramtype2  = "facedir",
	drop        = "lottplants:aldertree",
	groups      = { tree = 1, choppy = 2, flammable = 2 },
	sounds      = default.node_sound_wood_defaults(),
	on_place    = minetest.rotate_node,
})

minetest.register_node("lottplants:aldertree", {
	description = S("Alder Tree"),
	tiles       = { "lottplants_aldertree_top.png", "lottplants_aldertree_top.png", "lottplants_aldertree.png" },
	paramtype2  = "facedir",
	groups      = { tree = 1, choppy = 2, flammable = 2 },
	sounds      = default.node_sound_wood_defaults(),
	on_place    = minetest.rotate_node,
	on_dig      = function(pos, node, digger)
		default.dig_tree(pos, node, "lottplants:aldertree", digger, 10, 2, "lottplants:aldertree")
	end,
})

-- лебетрон
minetest.register_node("lottplants:lebethrontrunk", {
	description = S("Lebethron Trunk"),
	tiles       = { "lottplants_lebethrontree_top.png", "lottplants_lebethrontree_top.png", "default_tree.png" },
	paramtype2  = "facedir",
	drop        = "lottplants:lebethrontree",
	groups      = { tree = 1, choppy = 1, flammable = 2 },
	sounds      = default.node_sound_wood_defaults(),
	on_place    = minetest.rotate_node,
})

minetest.register_node("lottplants:lebethrontree", {
	description = S("Lebethron Tree"),
	tiles       = { "lottplants_lebethrontree_top.png", "lottplants_lebethrontree_top.png", "default_tree.png" },
	paramtype2  = "facedir",
	groups      = { tree = 1, choppy = 1, flammable = 2 },
	sounds      = default.node_sound_wood_defaults(),
	on_place    = minetest.rotate_node,
	on_dig      = function(pos, node, digger)
		default.dig_tree(pos, node, "lottplants:lebethrontree", digger, 10, 2, "lottplants:lebethrontree")
	end,
})

-- маллорн
minetest.register_node("lottplants:mallorntrunk", {
	description = S("Mallorn Trunk"),
	tiles       = { "lottplants_mallorntree_top.png", "lottplants_mallorntree_top.png", "lottplants_mallorntree.png" },
	paramtype2  = "facedir",
	drop        = "lottplants:mallorntree",
	groups      = { tree = 1, choppy = 1, flammable = 2 },
	sounds      = default.node_sound_wood_defaults(),
	on_place    = minetest.rotate_node,
})

minetest.register_node("lottplants:mallorntree", {
	description = S("Mallorn Tree"),
	tiles       = { "lottplants_mallorntree_top.png", "lottplants_mallorntree_top.png", "lottplants_mallorntree.png" },
	paramtype2  = "facedir",
	groups      = { tree = 1, choppy = 1, flammable = 2 },
	sounds      = default.node_sound_wood_defaults(),
	on_place    = minetest.rotate_node,
	on_dig      = function(pos, node, digger)
		default.dig_tree(pos, node, "lottplants:mallorntree", digger, 30, 5, "lottplants:mallorntree")
	end,
})

-- молодой маллорн
minetest.register_node("lottplants:mallorntrunk_young", {
	description = S("Young Mallorn Trunk"),
	tiles       = { "lottplants_mallorntree_top.png", "lottplants_mallorntree_top.png", "lottplants_mallorntree.png" },
	drawtype    = "nodebox",
	paramtype   = "light",
	node_box    = {
		type  = "fixed",
		fixed = {
			{ -0.125, -0.5, -0.1875, 0.125, 0.5, 0.1875 },
			{ -0.1875, -0.5, -0.125, 0.1875, 0.5, 0.125 },
		},
	},
	paramtype2  = "facedir",
	drop        = "lottplants:mallorntree_young",
	groups      = { tree = 1, choppy = 1, flammable = 2, fuel = 1 },
	sounds      = default.node_sound_wood_defaults(),
	on_place    = minetest.rotate_node,
})

minetest.register_node("lottplants:mallorntree_young", {
	description = S("Young Mallorn Trее"),
	tiles       = { "lottplants_mallorntree_top.png", "lottplants_mallorntree_top.png", "lottplants_mallorntree.png" },
	drawtype    = "nodebox",
	paramtype   = "light",
	node_box    = {
		type  = "fixed",
		fixed = {
			{ -0.125, -0.5, -0.1875, 0.125, 0.5, 0.1875 },
			{ -0.1875, -0.5, -0.125, 0.1875, 0.5, 0.125 },
		},
	},
	paramtype2  = "facedir",
	groups      = { tree = 1, choppy = 1, flammable = 2, fuel = 1 },
	sounds      = default.node_sound_wood_defaults(),
	on_place    = minetest.rotate_node,
	on_dig      = function(pos, node, digger)
		default.dig_tree(pos, node, "lottplants:mallorntree_young", digger, 10, 1, "lottplants:mallorntree_young")
	end,
})

-- SAPLINGS

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

-- FRUITS

minetest.register_node("lottplants:plum", {
	description         = S("Plum"),
	drawtype            = "plantlike",
	visual_scale        = 1.0,
	tiles               = { "lottplants_plum.png" },
	inventory_image     = "lottplants_plum.png",
	paramtype           = "light",
	sunlight_propagates = true,
	walkable            = false,
	selection_box       = {
		type  = "fixed",
		fixed = { -0.2, -0.5, -0.2, 0.2, 0, 0.2 }
	},
	groups              = {
		fleshy = 3, dig_immediate = 3, flammable = 2, leafdecay = 3, leafdecay_drop = 1, color_violet = 1
	},
	on_use              = minetest.item_eat(2),
	sounds              = default.node_sound_leaves_defaults(),
	after_place_node    = function(pos, placer, itemstack)
		if placer:is_player() then
			minetest.set_node(pos, { name = "lottplants:plum", param2 = 1 })
		end
	end,
})

minetest.register_node("lottplants:yavannamirefruit", {
	description         = S("Yavannamire Fruit"),
	drawtype            = "plantlike",
	visual_scale        = 1.0,
	tiles               = { "lottplants_yavannamirefruit.png" },
	inventory_image     = "lottplants_yavannamirefruit.png",
	paramtype           = "light",
	sunlight_propagates = true,
	walkable            = false,
	selection_box       = {
		type  = "fixed",
		fixed = { -0.2, -0.5, -0.2, 0.2, 0, 0.2 }
	},
	groups              = { fleshy = 3, dig_immediate = 3, flammable = 2, leafdecay = 3, leafdecay_drop = 1 },
	on_use              = minetest.item_eat(4),
	sounds              = default.node_sound_leaves_defaults(),
	after_place_node    = function(pos, placer, itemstack)
		if placer:is_player() then
			minetest.set_node(pos, { name = "lottplants:yavannamirefruit", param2 = 1 })
		end
	end,
})

-- LEAFDECAY
-- Регистрация опадающей листвы и др.

-- Alders / Ольха
default.register_leafdecay({
	trunks = {"lottplants:aldertree"},
	leaves = {"lottplants:alderleaf"},
	radius = 2,
})

default.register_leafdecay({
	trunks = {"default:tree"},
	leaves = {
		"lottplants:appleleaf", "default:leaves", "default:apple", -- Apple Tree / Яблоня
		"lottplants:beechleaf", -- Beeches / Бук
		"lottplants:culumaldaleaf", "lottplants:yellowflowers", -- Culumalda / Кулумальда
		"lottplants:elmleaf", -- Elms / Вяз
		"lottplants:plumleaf", "lottplants:plum", -- Plum Tree / Слива
		"lottplants:rowanleaf", "lottplants:rowanberry", -- Rowans / Рябина
		"lottplants:whiteleaf", -- White Tree / Белое дерево
		"lottplants:yavannamireleaf", "lottplants:yavannamirefruit", -- Yavannamire / Йаванамирэ
	},
	radius = 6, -- такая большая цифра только из-за бука
})

-- Lebethron / Лебетрон
default.register_leafdecay({
	trunks = {"lottplants:lebethrontree"},
	leaves = {"lottplants:lebethronleaf"},
	radius = 2,
})

-- Birches / Береза
default.register_leafdecay({
	trunks = {"lottplants:birchtree"},
	leaves = {"lottplants:birchleaf"},
	radius = 3,
})

-- Firs / Ель
default.register_leafdecay({
	trunks = {"lottplants:firtree"},
	leaves = {"lottplants:firleaf"},
	radius = 4,
})

-- (Young) Mallorn / (Молодой) маллорн
default.register_leafdecay({
	trunks = {"lottplants:mallorntree", "lottplants:mallorntree_young"},
	leaves = {"lottplants:mallornleaf"},
	radius = 2,
})

-- Pines / Сосна
default.register_leafdecay({
	trunks = {"lottplants:pinetree"},
	leaves = {"lottplants:pineleaf"},
	radius = 2,
})

-- Mirk Large/Small / Большое/Малое дерево Лихолесья
default.register_leafdecay({
	trunks = {"default:jungletree"},
	leaves = {"lottplants:mirkleaf"},
	radius = 2,
})

--Wood

minetest.register_node("lottplants:pinewood", {
	description = S("Pine Planks"),
	tiles       = { "lottplants_pinewood.png" },
	groups      = { choppy = 3, flammable = 3, wood = 1 },
	sounds      = default.node_sound_wood_defaults(),
	paramtype2  = "facedir",
})

minetest.register_node("lottplants:firwood", {
	description = S("Fir Planks"),
	tiles       = { "lottplants_fir_wood.png" },
	groups      = { choppy = 3, flammable = 3, wood = 1 },
	sounds      = default.node_sound_wood_defaults(),
	paramtype2  = "facedir",
})

minetest.register_node("lottplants:birchwood", {
	description = S("Birch Planks"),
	tiles       = { "lottplants_birchwood.png" },
	groups      = { choppy = 3, flammable = 3, wood = 1 },
	sounds      = default.node_sound_wood_defaults(),
	paramtype2  = "facedir",
})

minetest.register_node("lottplants:alderwood", {
	description = S("Alder Planks"),
	tiles       = { "lottplants_alderwood.png" },
	groups      = { choppy = 2, flammable = 3, wood = 1 },
	sounds      = default.node_sound_wood_defaults(),
	paramtype2  = "facedir",
})

minetest.register_node("lottplants:lebethronwood", {
	description = S("Lebethron Planks"),
	tiles       = { "lottplants_lebethronwood.png" },
	groups      = { choppy = 1, flammable = 3, wood = 1 },
	sounds      = default.node_sound_wood_defaults(),
	paramtype2  = "facedir",
})

minetest.register_node("lottplants:mallornwood", {
	description = S("Mallorn Planks"),
	tiles       = { "lottplants_mallornwood.png" },
	groups      = { choppy = 1, flammable = 3, wood = 1 },
	sounds      = default.node_sound_wood_defaults(),
	paramtype2  = "facedir",
})

--Lorien grass

minetest.register_node("lottplants:lorien_grass_1", {
	description       = S("Lorien Grass"),
	drawtype          = "plantlike",
	tiles             = { "lottplants_lorien_grass_1.png" },
	-- use a bigger inventory image
	inventory_image   = "lottplants_lorien_grass_3.png",
	wield_image       = "lottplants_lorien_grass_3.png",
	paramtype         = "light",
	waving            = 1,
	walkable          = false,
	is_ground_content = true,
	buildable_to      = true,
	groups            = {
		snappy = 3, flammable = 3, flora = 1, attached_node = 1, grass = 1, color_green = 1
	},
	sounds            = default.node_sound_leaves_defaults(),
	selection_box     = {
		type  = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -5 / 16, 0.5 },
	},
	on_place          = function(itemstack, placer, pointed_thing)
		-- place a random grass node
		local stack = ItemStack("lottplants:lorien_grass_" .. math.random(1, 5))
		local ret   = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("lottplants:lorien_grass_1 " .. itemstack:get_count() - (1 - ret:get_count()))
	end,
})
minetest.register_node("lottplants:lorien_grass_2", {
	description       = S("Lorien Grass"),
	drawtype          = "plantlike",
	tiles             = { "lottplants_lorien_grass_2.png" },
	inventory_image   = "lottplants_lorien_grass_2.png",
	wield_image       = "lottplants_lorien_grass_2.png",
	paramtype         = "light",
	waving            = 1,
	walkable          = false,
	buildable_to      = true,
	is_ground_content = true,
	drop              = "lottplants:lorien_grass_1",
	groups            = {
		snappy = 3, flammable = 3, flora = 1, attached_node = 1, not_in_creative_inventory = 1, grass = 1
	},
	sounds            = default.node_sound_leaves_defaults(),
	selection_box     = {
		type  = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -5 / 16, 0.5 },
	},
})
minetest.register_node("lottplants:lorien_grass_3", {
	description       = S("Lorien Grass"),
	drawtype          = "plantlike",
	tiles             = { "lottplants_lorien_grass_3.png" },
	inventory_image   = "lottplants_lorien_grass_3.png",
	wield_image       = "lottplants_lorien_grass_3.png",
	paramtype         = "light",
	waving            = 1,
	walkable          = false,
	buildable_to      = true,
	is_ground_content = true,
	drop              = "lottplants:lorien_grass_1",
	groups            = {
		snappy = 3, flammable = 3, flora = 1, attached_node = 1, not_in_creative_inventory = 1, grass = 1
	},
	sounds            = default.node_sound_leaves_defaults(),
	selection_box     = {
		type  = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -5 / 16, 0.5 },
	},
})
minetest.register_node("lottplants:lorien_grass_4", {
	description       = S("Lorien Grass"),
	drawtype          = "plantlike",
	tiles             = { "lottplants_lorien_grass_4.png" },
	inventory_image   = "lottplants_lorien_grass_4.png",
	wield_image       = "lottplants_lorien_grass_4.png",
	paramtype         = "light",
	waving            = 1,
	walkable          = false,
	buildable_to      = true,
	is_ground_content = true,
	drop              = "lottplants:lorien_grass_1",
	groups            = {
		snappy = 3, flammable = 3, flora = 1, attached_node = 1, not_in_creative_inventory = 1, grass = 1
	},
	sounds            = default.node_sound_leaves_defaults(),
	selection_box     = {
		type  = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -5 / 16, 0.5 },
	},
})

--Stairs & Slabs

stairs.register_stair_and_slab(
	"birchwood",
	"lottplants:birchwood",
	{snappy = 2, choppy = 3, flammable = 3, wooden = 1},
	{"lottplants_birchwood.png"},
	S("Birch Wood Stair"),
	S("Birch Wood Slab"),
	default.node_sound_wood_defaults(),
	false,
	S("Inner Birch Wood Stair"),
	S("Outer Birch Wood Stair")
)

stairs.register_stair_and_slab(
	"pinewood",
	"lottplants:pinewood",
	{snappy = 2, choppy = 3, flammable = 3, wooden = 1},
	{"lottplants_pinewood.png"},
	S("Pine Wood Stair"),
	S("Pine Wood Slab"),
	default.node_sound_wood_defaults(),
	false,
	S("Inner Pine Wood Stair"),
	S("Outer Pine Wood Stair")
)

stairs.register_stair_and_slab(
	"firwood",
	"lottplants:firwood",
	{snappy = 2, choppy = 3, flammable = 3, wooden = 1},
	{"lottplants_pinewood.png"},
	S("Fir Wood Stair"),
	S("Fir Wood Slab"),
	default.node_sound_wood_defaults(),
	false,
	S("Inner Fir Wood Stair"),
	S("Outer Fir Wood Stair")
)

stairs.register_stair_and_slab(
	"alderwood",
	"lottplants:alderwood",
	{snappy = 2, choppy = 2, flammable = 3, wooden = 1},
	{"lottplants_alderwood.png"},
	S("Alder Wood Stair"),
	S("Alder Wood Slab"),
	default.node_sound_wood_defaults(),
	false,
	S("Inner Alder Wood Stair"),
	S("Outer Alder Wood Stair")
)

stairs.register_stair_and_slab(
	"lebethronwood",
	"lottplants:lebethronwood",
	{snappy = 2, choppy = 1, flammable = 3, wooden = 1},
	{"lottplants_lebethronwood.png"},
	S("Lebethron Wood Stair"),
	S("Lebethron Wood Slab"),
	default.node_sound_wood_defaults(),
	false,
	S("Inner Lebethron Wood Stair"),
	S("Outer Lebethron Wood Stair")
)

stairs.register_stair_and_slab(
	"mallornwood",
	"lottplants:mallornwood",
	{snappy = 2, choppy = 1, flammable = 3, wooden = 1},
	{"lottplants_mallornwood.png"},
	S("Mallorn Wood Stair"),
	S("Mallorn Wood Slab"),
	default.node_sound_wood_defaults(),
	false,
	S("Inner Mallorn Wood Stair"),
	S("Outer Mallorn Wood Stair")
)

-- trunk slabs
stairs.register_slab(
	"pinetrunk",
	"lottplants:pinetrunk",
	{ tree_slab = 1, choppy = 3, flammable = 2 },
	{ "lottplants_pinetree_top.png", "lottplants_pinetree_top.png", "lottplants_pinetree.png" },
	S("Pine Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"firtrunk",
	"lottplants:firtrunk",
	{ tree_slab = 1, choppy = 3, flammable = 2 },
	{ "lottplants_fir_tree_top.png", "lottplants_fir_tree_top.png", "lottplants_fir_tree.png" },
	S("Fir Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"birchtrunk",
	"lottplants:birchtrunk",
	{ tree_slab = 1, choppy = 3, flammable = 2 },
	{ "lottplants_birchtree_top.png", "lottplants_birchtree_top.png", "lottplants_birchtree.png" },
	S("Birch Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"aldertrunk",
	"lottplants:aldertrunk",
	{ tree_slab = 1, choppy = 3, flammable = 2 },
	{ "lottplants_aldertree_top.png", "lottplants_aldertree_top.png", "lottplants_aldertree.png" },
	S("Alder Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"lebethrontrunk",
	"lottplants:lebethrontrunk",
	{ tree_slab = 1, choppy = 3, flammable = 2 },
	{ "lottplants_lebethrontree_top.png", "lottplants_lebethrontree_top.png", "default_tree.png" },
	S("Lebethron Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"mallorntrunk",
	"lottplants:mallorntrunk",
	{ tree_slab = 1, choppy = 3, flammable = 2 },
	{ "lottplants_mallorntree_top.png", "lottplants_mallorntree_top.png", "lottplants_mallorntree.png" },
	S("Mallorn Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"treetrunk",
	"default:tree_trunk",
	{ tree_slab = 1, choppy = 2, flammable = 2 },
	{ "default_tree_top.png", "default_tree_top.png", "default_tree.png"},
	S("Tree Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"jungletreetrunk",
	"default:jungle_tree_trunk",
	{ tree_slab = 1, choppy = 2, flammable = 2 },
	{"default_jungletree_top.png", "default_jungletree_top.png", "default_jungletree.png"},
	S("Jungle Tree Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)



--Crafting

minetest.register_craft({
	output = 'lottplants:birchwood 4',
	recipe = {
		{ 'lottplants:birchtree' },
	}
})

minetest.register_craft({
	output = 'lottplants:pinewood 4',
	recipe = {
		{ 'lottplants:pinetree' },
	}
})

minetest.register_craft({
	output = 'lottplants:firwood 4',
	recipe = {
		{ 'lottplants:firtree' },
	}
})

minetest.register_craft({
	output = 'lottplants:alderwood 4',
	recipe = {
		{ 'lottplants:aldertree' },
	}
})

minetest.register_craft({
	output = 'lottplants:lebethronwood 4',
	recipe = {
		{ 'lottplants:lebethrontree' },
	}
})

minetest.register_craft({
	output = 'lottplants:mallornwood 4',
	recipe = {
		{ 'lottplants:mallorntree' },
	}
})

minetest.register_craft({
	output = 'lottplants:mallornwood 2',
	recipe = {
		{ 'lottplants:mallorntree_young' },
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:tree_slab",
	burntime = 15,
})

--Fireflies / Светлячки

minetest.register_node("lottplants:fireflies", {
	description  = S("Fireflies"),
	drawtype     = "glasslike",
	tiles        = {
		{
			name      = "lottplants_fireflies.png",
			animation = {
				type     = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length   = 2,
			},
		},
	},
	use_texture_alpha = "clip",
	paramtype    = "light",
	light_source = 8,
	walkable     = false,
	pointable    = true,
	diggable     = true,
	climbable    = false,
	buildable_to = true,
	drop         = "",
})

minetest.register_abm({
	nodenames = { "air" },
	neighbors = {
		"lottplants_elanor",
		"lottplants:niphredil",
	},
	interval  = 15,
	chance    = 600,
	action    = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.get_timeofday() > 0.74 or minetest.get_timeofday() < 0.22 then
			--local water_nodes = minetest.find_nodes_in_area(minp, maxp, "group:water")
			--if #water_nodes > 0 then
			if minetest.find_node_near(pos, 3, "lottplants:fireflies") == nil then
				minetest.set_node(pos, { name = "lottplants:fireflies" })
			end
		end
	end,
})
