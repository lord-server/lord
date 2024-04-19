local S = minetest.get_translator("lord_trees")


stairs.register_slab(
	"pinetree",
	"lord_trees:pinetree",
	{ tree_slab = 1, choppy = 3, flammable = 2 },
	{ "lord_trees_pinetree.png", },
	S("Pine Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"firtree",
	"lord_trees:firtree",
	{ tree_slab = 1, choppy = 3, flammable = 2 },
	{ "lord_trees_firtree.png" },
	S("Fir Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"birchtree",
	"lord_trees:birchtree",
	{ tree_slab = 1, choppy = 3, flammable = 2 },
	{ "lord_trees_birchtree.png", },
	S("Birch Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"aldertree",
	"lord_trees:aldertree",
	{ tree_slab = 1, choppy = 3, flammable = 2 },
	{ "lord_trees_aldertree.png", },
	S("Alder Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"lebethrontree",
	"lord_trees:lebethrontree",
	{ tree_slab = 1, choppy = 3, flammable = 2 },
	{ "default_tree.png", },
	S("Lebethron Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"mallorntree",
	"lord_trees:mallorntree",
	{ tree_slab = 1, choppy = 3, flammable = 2 },
	{ "lord_trees_mallorntree.png", },
	S("Mallorn Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"elmtree",
	"lord_trees:elmtree",
	{ tree_slab = 1, choppy = 2, flammable = 2 },
	{ "lord_trees_elmtree.png", },
	S("Elm Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"tree",
	"default:tree",
	{ tree_slab = 1, choppy = 2, flammable = 2 },
	{ "default_tree.png",},
	S("Tree Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"jungletreetree",
	"default:jungletree",
	{ tree_slab = 1, choppy = 2, flammable = 2 },
	{ "default_jungletree.png",},
	S("Jungle Tree Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)


minetest.register_craft({
	type = "fuel",
	recipe = "group:tree_slab",
	burntime = 15,
})
