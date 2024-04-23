local S = minetest.get_translator("lottblocks")

--Thanks for all the things in this file, and the related textures goes to catninja!--

-------------
--- Items ---
-------------

--- @param name string
--- @param desc string
--- @param texture_name string
--- @param leaves string
local function register_leafroof(name, desc, texture_name, leaves)
	minetest.register_node("lottblocks:"..name, {
		description       = S(desc.." Roof"),
		tiles             = { texture_name },
		use_texture_alpha = "clip",
		paramtype         = "light",
		drawtype          = "allfaces_optional",
		is_ground_content = false,
		sounds            = default.node_sound_leaves_defaults(),
		groups            = { snappy = 2, oddly_breakable_by_hand = 2, leaves = 1 },
	})

	stairs.register_stair_and_slab(
		name,
		"lottblocks:"..name,
		{ oddly_breakable_by_hand = 2, leaves = 1 },
		{ texture_name },
		S(desc.." Roof Stair"),
		S(desc.." Roof Slab"),
		default.node_sound_stone_defaults(),
		false,
		S("Inner ".. desc.." Roof Stair"),
		S("Outer "..desc.." Roof Stair")
	)

	minetest.register_craft({
	output = "lottblocks:"..name,
	recipe = {
		{ leaves, leaves },
		{ leaves, leaves },
	}
})
end

-- TREES
-- Vine tree

minetest.register_node("lottblocks:tree_vine", {
	description       = S("Tree With Vines"),
	tiles             = {
		"lottblocks_tree_vine_top.png",
		"lottblocks_tree_vine_top.png",
		"lottblocks_tree_vine.png",
		"lottblocks_tree_vine.png",
		"lottblocks_tree_vine.png",
		"lottblocks_tree_vine.png",
	},
	paramtype2        = "facedir",
	is_ground_content = false,
	sounds            = default.node_sound_wood_defaults(),
	groups            = { choppy = 2, snappy = 2, tree = 1 },
})

stairs.register_stair_and_slab(
	"tree_vine",
	"lottblocks:tree_vine",
	{ choppy = 2, snappy = 2, tree = 1 },
	{ "lottblocks_tree_vine.png" },
	S("Tree With Vines Stair"),
	S("Tree With Vines Slab"),
	default.node_sound_wood_defaults(),
	false,
	S("Inner Tree With Vines Stair"),
	S("Outer Tree With Vines Stair")
)

-- Mossy tree

minetest.register_node("lottblocks:tree_mossy", {
	description       = S("Tree With Moss"),
	tiles             = {
		"lottblocks_tree_mossy_top.png",
		"lottblocks_tree_mossy_top.png",
		"lottblocks_tree_mossy.png",
		"lottblocks_tree_mossy.png",
		"lottblocks_tree_mossy.png",
		"lottblocks_tree_mossy.png"
	},
	paramtype2        = "facedir",
	is_ground_content = false,
	sounds            = default.node_sound_wood_defaults(),
	groups            = { choppy = 2, tree = 1 },
})

stairs.register_stair_and_slab(
	"tree_mossy",
	"lottblocks:tree_mossy",
	{ choppy = 2, tree = 1 },
	{ "lottblocks_tree_mossy.png" },
	S("Tree With Moss Stair"),
	S("Tree With Moss Slab"),
	default.node_sound_wood_defaults(),
	false,
	S("Inner Tree With Moss Stair"),
	S("Outer Tree With Moss Stair")
)

-- Leafroof dark

register_leafroof("leafroof_dark", "Dark Leaf", "lottblocks_leafroof.png", "default:leaves")

-- Leafroof white

register_leafroof("leafroof_white", "White Leaf", "lottblocks_white_leafroof.png", "lord_trees:white_leaf")

-- Leafroof cherry

register_leafroof("leafroof_cherry", "Cherry Leaf", "lottblocks_cherry_leafroof.png", "lord_trees:cherry_leaf")


-- MALLORN
-- Leafroof mallorn

register_leafroof("leafroof_mallorn", "Mallorn Leaf", "lottblocks_mallornroof.png", "lord_trees:mallorn_leaf")

-- mallorn pillar

minetest.register_node("lottblocks:mallorn_pillar", {
	description       = S("Mallorn Pillar"),
	tiles             = { "lottblocks_mallorn_pillar.png" },
	paramtype         = "light",
	paramtype2        = "facedir",
	is_ground_content = false,
	groups            = { snappy = 2, choppy = 2, wooden = 1 },
})

stairs.register_stair_and_slab(
	"mallorn_pillar",
	"lottblocks:mallorn_pillar",
	{ snappy = 2, choppy = 2, wooden = 1 },
	{ "lottblocks_mallorn_pillar.png" },
	S("Mallorn Pillar Stair"),
	S("Mallorn Pillar Slab"),
	default.node_sound_wood_defaults(),
	false,
	S("Inner Mallorn Pillar Stair"),
	S("Outer Mallorn Pillar Stair")
)

-- mallorn White

minetest.register_node("lottblocks:mallorn_white", {
	description       = S("White Mallorn"),
	tiles             = { "lottblocks_mallorn_white.png" },
	paramtype         = "light",
	paramtype2        = "facedir",
	is_ground_content = false,
	groups            = { snappy = 2, choppy = 2, wooden = 1 },
})

stairs.register_stair_and_slab(
	"mallorn_white",
	"lottblocks:mallorn_white",
	{ snappy = 2, choppy = 2, wooden = 1 },
	{ "lottblocks_mallorn_white.png" },
	S("White Mallorn Stair"),
	S("White Mallorn Slab"),
	default.node_sound_wood_defaults(),
	false,
	S("Inner White Mallorn Stair"),
	S("Outer White Mallorn Stair")
)

-- DWARFSTONE
-- white

minetest.register_node("lottblocks:dwarfstone_white", {
	description       = S("White Dwarf Stone"),
	tiles             = {
		"lottblocks_dwarfstone_white_top.png",
		"lottblocks_dwarfstone_white_top.png",
		"lottblocks_dwarfstone_white_side.png",
		"lottblocks_dwarfstone_white_side.png",
		"lottblocks_dwarfstone_white_side.png",
		"lottblocks_dwarfstone_white_side.png",
	},
	paramtype2        = "facedir",
	is_ground_content = false,
	groups            = { cracky = 3 },
})

stairs.register_stair_and_slab(
	"dwarfstone_white",
	"lottblocks:dwarfstone_white",
	{ cracky = 2 },
	{ "lottblocks_dwarfstone_white_top.png" },
	S("White Dwarf Stone Stair"),
	S("White Dwarf Stone Slab"),
	default.node_sound_stone_defaults(),
	false,
	S("Inner White Dwarf Stone Stair"),
	S("Outer White Dwarf Stone Stair")
)

-- black

minetest.register_node("lottblocks:dwarfstone_black", {
	description       = S("Black Dwarf Stone"),
	tiles             = {
		"lottblocks_dwarfstone_black_top.png",
		"lottblocks_dwarfstone_black_top.png",
		"lottblocks_dwarfstone_black_side.png",
		"lottblocks_dwarfstone_black_side.png",
		"lottblocks_dwarfstone_black_side.png",
		"lottblocks_dwarfstone_black_side.png",
	},
	paramtype2        = "facedir",
	is_ground_content = false,
	groups            = { cracky = 3 },
})

stairs.register_stair_and_slab(
	"dwarfstone_black",
	"lottblocks:dwarfstone_black",
	{ cracky = 2 },
	{ "lottblocks_dwarfstone_black_top.png" },
	S("Black Dwarf Stone Stair"),
	S("Black Dwarf Stone Slab"),
	default.node_sound_stone_defaults(),
	false,
	S("Inner Black Dwarf Stone Stair"),
	S("Outer Black Dwarf Stone Stair")
)

-- stripe

minetest.register_node("lottblocks:dwarfstone_stripe", {
	description       = S("Stripe Dwarf Stone"),
	tiles             = {
		"lottblocks_dwarfstone_stripe_top.png",
		"lottblocks_dwarfstone_stripe_bottom.png",
		"lottblocks_dwarfstone_stripe_l.png",
		"lottblocks_dwarfstone_stripe_l.png",
		"lottblocks_dwarfstone_stripe_r.png",
		"lottblocks_dwarfstone_stripe_r.png",
	},
	paramtype2        = "facedir",
	is_ground_content = false,
	groups            = { cracky = 3 },
})

--------------
--- Crafts ---
--------------

--TREES
-- vine

minetest.register_craft({
	output = 'lottblocks:tree_vine 4',
	recipe = {
		{ 'default:tree', 'default:grass_1' },
		{ 'default:grass_1', 'default:tree' },
	}
})

-- mossy tree

minetest.register_craft({
	output = 'lottblocks:tree_mossy 4',
	recipe = {
		{ 'default:grass_1', 'default:grass_1', 'default:grass_1' },
		{ 'default:grass_1', 'default:tree', 'default:grass_1' },
		{ 'default:grass_1', 'default:grass_1', 'default:grass_1' },
	}
})

-- MALLORN

-- White mallorn

minetest.register_craft({
	output = 'lottblocks:mallorn_white',
	recipe = {
		{ 'dye:white' },
		{ 'lord_planks:mallorn' },
	}
})

-- Mallorn pillar

minetest.register_craft({
	output = 'lottblocks:mallorn_pillar',
	recipe = {
		{ 'lord_trees:mallorn_tree', 'default:gold_ingot' },
		{ 'default:gold_ingot', 'lord_trees:mallorn_tree' },
	}
})

-- DWARFSTONE
-- white

minetest.register_craft({
	output = 'lottblocks:dwarfstone_white 4',
	recipe = {
		{ 'default:steel_ingot', 'default:stone', 'default:steel_ingot' },
		{ 'default:stone', 'default:steel_ingot', 'default:stone' },
		{ 'default:steel_ingot', 'default:stone', 'default:steel_ingot' },
	}
})

-- black

minetest.register_craft({
	output = 'lottblocks:dwarfstone_black 4',
	recipe = {
		{ 'default:coal_lump', 'default:stone', 'default:coal_lump' },
		{ 'default:stone', 'default:coal_lump', 'default:stone' },
		{ 'default:coal_lump', 'default:stone', 'default:coal_lump' },
	}
})

-- stripe

minetest.register_craft({
	output = 'lottblocks:dwarfstone_stripe 4',
	recipe = {
		{ 'default:stone', 'default:coal_lump' },
		{ 'default:stone', 'default:coal_lump' },
	}
})
