local S = minetest.get_translator("lottplants")


stairs.register_slab(
	"pinetree",
	"lottplants:pinetree",
	{ tree_slab = 1, choppy = 3, flammable = 2 },
	{ "lottplants_pinetree.png", },
	S("Pine Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"firtree",
	"lottplants:firtree",
	{ tree_slab = 1, choppy = 3, flammable = 2 },
	{ "lottplants_firtree.png" },
	S("Fir Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"birchtree",
	"lottplants:birchtree",
	{ tree_slab = 1, choppy = 3, flammable = 2 },
	{ "lottplants_birchtree.png", },
	S("Birch Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"aldertree",
	"lottplants:aldertree",
	{ tree_slab = 1, choppy = 3, flammable = 2 },
	{ "lottplants_aldertree.png", },
	S("Alder Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"lebethrontree",
	"lottplants:lebethrontree",
	{ tree_slab = 1, choppy = 3, flammable = 2 },
	{ "default_tree.png", },
	S("Lebethron Trunk Slab"),
	default.node_sound_wood_defaults(),
	false
)

stairs.register_slab(
	"mallorntree",
	"lottplants:mallorntree",
	{ tree_slab = 1, choppy = 3, flammable = 2 },
	{ "lottplants_mallorntree.png", },
	S("Mallorn Trunk Slab"),
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
