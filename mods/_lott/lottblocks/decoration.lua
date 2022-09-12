local SL = lord.require_intllib()

--Thanks for all the things in this file, and the related textures goes to catninja!--

-------------
--- Items ---
-------------

-- TREES
-- Vine tree

minetest.register_node("lottblocks:tree_vine", {
	description       = SL("Tree With Vines"),
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
	SL("Tree With Vines Stair"),
	SL("Tree With Vines Slab"),
	default.node_sound_wood_defaults(),
	false,
	SL("Inner Tree With Vines Stair"),
	SL("Outer Tree With Vines Stair")
)

-- Mossy tree

minetest.register_node("lottblocks:tree_mossy", {
	description       = SL("Tree With Moss"),
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
	SL("Tree With Moss Stair"),
	SL("Tree With Moss Slab"),
	default.node_sound_wood_defaults(),
	false,
	SL("Inner Tree With Moss Stair"),
	SL("Outer Tree With Moss Stair")
)

-- Leafroof dark

minetest.register_node("lottblocks:leafroof_dark", {
	description       = SL("Dark Leaf Roof"),
	tiles             = { "lottblocks_leafroof.png" },
	use_texture_alpha = "clip",
	paramtype         = "light",
	drawtype          = "allfaces_optional",
	is_ground_content = false,
	sounds            = default.node_sound_leaves_defaults(),
	groups            = { snappy = 2, oddly_breakable_by_hand = 2, leaves = 1 },
})

stairs.register_stair_and_slab(
	"leafroof_dark",
	"lottblocks:leafroof_dark",
	{ oddly_breakable_by_hand = 2, leaves = 1 },
	{ "lottblocks_leafroof.png" },
	SL("Dark Leaf Roof Stair"),
	SL("Dark Leaf Roof Slab"),
	default.node_sound_stone_defaults(),
	false,
	SL("Inner Dark Leaf Roof Stair"),
	SL("Outer Dark Leaf Roof Stair")
)


-- MALLORN
-- Leafroof mallorn

minetest.register_node("lottblocks:leafroof_mallorn", {
	description       = SL("Mallorn Leaf Roof"),
	tiles             = { "lottblocks_mallornroof.png" },
	use_texture_alpha = "clip",
	paramtype         = "light",
	drawtype          = "allfaces_optional",
	is_ground_content = false,
	sounds            = default.node_sound_leaves_defaults(),
	groups            = { oddly_breakable_by_hand = 2, leaves = 1 },
})

stairs.register_stair_and_slab(
	"leafroof_mallorn",
	"lottblocks:leafroof_mallorn",
	{ oddly_breakable_by_hand = 2, leaves = 1 },
	{ "lottblocks_mallornroof.png" },
	SL("Mallorn Leaf Roof Stair"),
	SL("Mallorn Leaf Roof Slab"),
	default.node_sound_leaves_defaults(),
	false,
	SL("Inner Mallorn Leaf Roof Stair"),
	SL("Outer Mallorn Leaf Roof Stair")
)

-- mallorn pillar

minetest.register_node("lottblocks:mallorn_pillar", {
	description       = SL("Mallorn Pillar"),
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
	SL("Mallorn Pillar Stair"),
	SL("Mallorn Pillar Slab"),
	default.node_sound_wood_defaults(),
	false,
	SL("Inner Mallorn Pillar Stair"),
	SL("Outer Mallorn Pillar Stair")
)

-- mallorn White

minetest.register_node("lottblocks:mallorn_white", {
	description       = SL("White Mallorn"),
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
	SL("White Mallorn Stair"),
	SL("White Mallorn Slab"),
	default.node_sound_wood_defaults(),
	false,
	SL("Inner White Mallorn Stair"),
	SL("Outer White Mallorn Stair")
)

-- DWARFSTONE
-- white

minetest.register_node("lottblocks:dwarfstone_white", {
	description       = SL("White Dwarf Stone"),
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
	SL("White Dwarf Stone Stair"),
	SL("White Dwarf Stone Slab"),
	default.node_sound_stone_defaults(),
	false,
	SL("Inner White Dwarf Stone Stair"),
	SL("Outer White Dwarf Stone Stair")
)

-- black

minetest.register_node("lottblocks:dwarfstone_black", {
	description       = SL("Black Dwarf Stone"),
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
	SL("Black Dwarf Stone Stair"),
	SL("Black Dwarf Stone Slab"),
	default.node_sound_stone_defaults(),
	false,
	SL("Inner Black Dwarf Stone Stair"),
	SL("Outer Black Dwarf Stone Stair")
)

-- stripe

minetest.register_node("lottblocks:dwarfstone_stripe", {
	description       = SL("Stripe Dwarf Stone"),
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

-- leafroof dark


minetest.register_craft({
	output = 'lottblocks:leafroof_dark',
	recipe = {
		{ 'default:leaves', 'default:leaves' },
		{ 'default:leaves', 'default:leaves' },
	}
})

-- MALLORN
-- leafroof mallorn

minetest.register_craft({
	output = 'lottblocks:leafroof_mallorn',
	recipe = {
		{ 'lottplants:mallornleaf', 'lottplants:mallornleaf' },
		{ 'lottplants:mallornleaf', 'lottplants:mallornleaf' },
	}
})

-- White mallorn

minetest.register_craft({
	output = 'lottblocks:mallorn_white',
	recipe = {
		{ 'dye:white' },
		{ 'lottplants:mallornwood' },
	}
})

-- Mallorn pillar

minetest.register_craft({
	output = 'lottblocks:mallorn_pillar',
	recipe = {
		{ 'lottplants:mallorntree', 'default:gold_ingot' },
		{ 'default:gold_ingot', 'lottplants:mallorntree' },
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
