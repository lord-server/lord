local S = minetest.get_translator("lottplants")

--- Also we use:
---  - Apple tree planks from MTG (default:wood)
---  - Jungle tree planks from MTG (default:junglewood)

minetest.register_node("lottplants:alderwood", {
	description  = S("Alder Planks"),
	tiles        = { "lottplants_alderwood.png" },
	groups       = { choppy = 2, flammable = 3, wood = 1 },
	sounds       = default.node_sound_wood_defaults(),
	paramtype2   = "facedir",
	place_param2 = 0,
})

minetest.register_node("lottplants:birchwood", {
	description  = S("Birch Planks"),
	tiles        = { "lottplants_birchwood.png" },
	groups       = { choppy = 3, flammable = 3, wood = 1 },
	sounds       = default.node_sound_wood_defaults(),
	paramtype2   = "facedir",
	place_param2 = 0,
})

minetest.register_node("lottplants:pinewood", {
	description  = S("Pine Planks"),
	tiles        = { "lottplants_pinewood.png" },
	groups       = { choppy = 3, flammable = 3, wood = 1 },
	sounds       = default.node_sound_wood_defaults(),
	paramtype2   = "facedir",
	place_param2 = 0,
})

minetest.register_node("lottplants:lebethronwood", {
	description  = S("Lebethron Planks"),
	tiles        = { "lottplants_lebethronwood.png" },
	groups       = { choppy = 1, flammable = 3, wood = 1 },
	sounds       = default.node_sound_wood_defaults(),
	paramtype2   = "facedir",
	place_param2 = 0,
})

minetest.register_node("lottplants:mallornwood", {
	description  = S("Mallorn Planks"),
	tiles        = { "lottplants_mallornwood.png" },
	groups       = { choppy = 1, flammable = 3, wood = 1 },
	sounds       = default.node_sound_wood_defaults(),
	paramtype2   = "facedir",
	place_param2 = 0,
})

minetest.register_node(":lord_homedecor:hardwood", {
	tiles = {"lottblocks_hardwood.png"},
	is_ground_content = true,
	description = S("Hardwood"),
	groups = {choppy=1,flammable=1,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("lottplants:firwood", {
	description  = S("Fir Planks"),
	tiles        = { "lottplants_fir_wood.png" },
	groups       = { choppy = 3, flammable = 3, wood = 1 },
	sounds       = default.node_sound_wood_defaults(),
	paramtype2   = "facedir",
	place_param2 = 0,
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
	{"lottplants_fir_wood.png"},
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

stairs.register_stair_and_slab(
	"hardwood",
	"lord_homedecor:hardwood",
	{choppy=1,flammable=1},
	{"lottblocks_hardwood.png"},
	S("Hardwood stair"),
	S("Hardwood slab"),
	default.node_sound_wood_defaults(),
	false,
	S("Inner Hardwood stair"),
	S("Outer Hardwood stair")
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

-- additional craft from young mallorn
minetest.register_craft({
	output = 'lottplants:mallornwood 2',
	recipe = {
		{ 'lottplants:mallorntree_young' },
	}
})

-- different craft for hardwood
minetest.register_craft({
	output = 'lord_homedecor:hardwood 2',
	recipe = {
		{"default:wood", "default:junglewood"},
		{"default:junglewood", "default:wood"},
	}
})
minetest.register_craft({
	output = 'lord_homedecor:hardwood 2',
	recipe = {
		{"default:junglewood", "default:wood"},
		{"default:wood", "default:junglewood"},
	}
})

-- hardwood burned slower
minetest.register_craft({
	type = "fuel",
	recipe = "lord_homedecor:hardwood",
	burntime = 28,
})
