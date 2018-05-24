local SL = lord.require_intllib()

-- Baked Clay by TenPlus1

local clay = {
	{"white", "White"},
	{"grey", "Grey"},
	{"black", "Black"},
	{"red", "Red"},
	{"yellow", "Yellow"},
	{"green", "Green"},
	{"cyan", "Cyan"},
	{"blue", "Blue"},
	{"magenta", "Magenta"},
	{"orange", "Orange"},
	{"violet", "Violet"},
	{"brown", "Brown"},
	{"pink", "Pink"},
	{"dark_grey", "Dark Grey"},
	{"dark_green", "Dark Green"},
}

for _, clay in pairs(clay) do

	-- node definition

	minetest.register_node("bakedclay:" .. clay[1], {
		description = SL(clay[2] .. " Baked Clay"),
		tiles = {"baked_clay_" .. clay[1] ..".png"},
		groups = {cracky = 3, bakedclay = 1},
		sounds = default.node_sound_stone_defaults(),
	})

	-- craft from dye and any baked clay

	minetest.register_craft({
		output = "bakedclay:" .. clay[1] .. " 8",
		recipe = {
			{"group:bakedclay", "group:bakedclay", "group:bakedclay"},
			{"group:bakedclay", "dye:" .. clay[1], "group:bakedclay"},
			{"group:bakedclay", "group:bakedclay", "group:bakedclay"}
		},
	})

	minetest.register_craft({
		output = "bakedclay:" .. clay[1] .. " 4",
		recipe = {
			{"", "group:bakedclay", ""},
			{"group:bakedclay", "dye:" .. clay[1], "group:bakedclay"},
			{"", "group:bakedclay", ""}
		},
	})

	-- register stairsplus stairs if found
	if minetest.get_modpath("moreblocks") and stairsplus then

		stairsplus:register_all("bakedclay", "baked_clay_" .. clay[1], "bakedclay:" .. clay[1], {
			description = SL(clay[2] .. " Baked Clay"),
			tiles = {"baked_clay_" .. clay[1] .. ".png"},
			groups = {cracky = 3},
			sounds = default.node_sound_stone_defaults(),
		})

		stairsplus:register_alias_all("bakedclay", clay[1], "bakedclay", "baked_clay_" .. clay[1])
		minetest.register_alias("stairs:slab_bakedclay_".. clay[1], "bakedclay:slab_baked_clay_" .. clay[1])
		minetest.register_alias("stairs:stair_bakedclay_".. clay[1], "bakedclay:stair_baked_clay_" .. clay[1])

	-- register stair and slab (unless stairs redo active)
	elseif stairs and not stairs.mod then

		stairs.register_stair_and_slab("bakedclay_".. clay[1], "bakedclay:".. clay[1],
			{cracky = 3},
			{"baked_clay_" .. clay[1] .. ".png"},
			SL(clay[2] .. " Baked Clay Stair"),
			SL(clay[2] .. " Baked Clay Slab"),
			default.node_sound_stone_defaults())
	end
end

-- cook clay block into white baked clay

minetest.register_craft({
	type = "cooking",
	output = "bakedclay:white",
	recipe = "default:clay",
})

-- 2x2 red bakedclay makes 16x clay brick
minetest.register_craft( {
	output = "default:clay_brick 16",
	recipe = {
		{"bakedclay:red", "bakedclay:red"},
		{"bakedclay:red", "bakedclay:red"},
	}
})

print ("[MOD] Baked Clay loaded")
