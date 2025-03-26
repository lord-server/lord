local S = minetest.get_mod_translator()


stairs.register_slab(
	"pinetree",
	"lord_trees:pine_tree",
	{ tree_slab = 1, choppy = 3, flammable = 2 },
	{ "lord_trees_pine_tree.png", },
	S("Pine Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"firtree",
	"lord_trees:fir_tree",
	{ tree_slab = 1, choppy = 3, flammable = 2 },
	{ "lord_trees_fir_tree.png" },
	S("Fir Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"birchtree",
	"lord_trees:birch_tree",
	{ tree_slab = 1, choppy = 3, flammable = 2 },
	{ "lord_trees_birch_tree.png", },
	S("Birch Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"aldertree",
	"lord_trees:alder_tree",
	{ tree_slab = 1, choppy = 3, flammable = 2 },
	{ "lord_trees_alder_tree.png", },
	S("Alder Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"lebethrontree",
	"lord_trees:lebethron_tree",
	{ tree_slab = 1, choppy = 3, flammable = 2 },
	{ "default_tree.png", },
	S("Lebethron Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"mallorntree",
	"lord_trees:mallorn_tree",
	{ tree_slab = 1, choppy = 3, flammable = 2 },
	{ "lord_trees_mallorn_tree.png", },
	S("Mallorn Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"elmtree",
	"lord_trees:elm_tree",
	{ tree_slab = 1, choppy = 2, flammable = 2 },
	{ "lord_trees_elm_tree.png", },
	S("Elm Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"plumtree",
	"lord_trees:plum_tree",
	{ tree_slab = 1, choppy = 2, flammable = 2 },
	{ "lord_trees_plum_tree.png", },
	S("Plum Trunk Slab"),
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

stairs.register_slab(
	"whitetree",
	"lord_trees:white_tree",
	{ tree_slab = 1, choppy = 2, flammable = 2 },
	{ "lord_trees_white_tree.png",},
	S("White Tree Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"Yavannamire",
	"lord_trees:yavannamire_tree",
	{ tree_slab = 1, choppy = 2, flammable = 2 },
	{ "lord_trees_yavannamire_tree.png",},
	S("Yavannamire Tree Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

minetest.register_craft({
	type = "fuel",
	recipe = "group:tree_slab",
	burntime = 15,
})
