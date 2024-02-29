local S = minetest.get_translator("lottplants")


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
	on_dig      = function(pos, node, digger)
		default.dig_tree(pos, node, "lottplants:pinetree", digger, 13, 2)
	end,
	on_place = function(itemstack, placer, pointed_thing)
		return default.place_tree(itemstack, placer, pointed_thing, "lottplants:pinetrunk")
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
	on_dig      = function(pos, node, digger)
		default.dig_tree(pos, node, "lottplants:firtree", digger, 13, 2)
	end,
	on_place = function(itemstack, placer, pointed_thing)
		return default.place_tree(itemstack, placer, pointed_thing, "lottplants:firtrunk")
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
	on_dig      = function(pos, node, digger)
		default.dig_tree(pos, node, "lottplants:birchtree", digger, 12, 3)
	end,
	on_place = function(itemstack, placer, pointed_thing)
		return default.place_tree(itemstack, placer, pointed_thing, "lottplants:birchtrunk")
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
	on_dig      = function(pos, node, digger)
		default.dig_tree(pos, node, "lottplants:aldertree", digger, 10, 2)
	end,
	on_place = function(itemstack, placer, pointed_thing)
		return default.place_tree(itemstack, placer, pointed_thing, "lottplants:aldertrunk")
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
	on_dig      = function(pos, node, digger)
		default.dig_tree(pos, node, "lottplants:lebethrontree", digger, 10, 2)
	end,
	on_place = function(itemstack, placer, pointed_thing)
		return default.place_tree(itemstack, placer, pointed_thing, "lottplants:lebethrontrunk")
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
	on_dig      = function(pos, node, digger)
		default.dig_tree(pos, node, "lottplants:mallorntree", digger, 30, 5)
	end,
	on_place = function(itemstack, placer, pointed_thing)
		return default.place_tree(itemstack, placer, pointed_thing, "lottplants:mallorntrunk")
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
	on_dig      = function(pos, node, digger)
		default.dig_tree(pos, node, "lottplants:mallorntree_young", digger, 10, 1)
	end,
	on_place = function(itemstack, placer, pointed_thing)
		return default.place_tree(itemstack, placer, pointed_thing, "lottplants:mallorntrunk_young")
	end,
})
