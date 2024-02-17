local math_random, id
	= math.random, minetest.get_content_id

--Rarity for Trees

local TREE1 = 30
local TREE2 = 50
local TREE3 = 100
local TREE4 = 200
local TREE5 = 300
local TREE6 = 500
local TREE7 = 750
local TREE8 = 1000
local TREE9 = 2000
local TREE10 = 5000

--Rarity for Plants

local PLANT1 = 3
local PLANT2 = 5
local PLANT3 = 10
local PLANT4 = 20
local PLANT5 = 50
local PLANT6 = 100
local PLANT7 = 200
local PLANT8 = 500
local PLANT9 = 750
local PLANT10 = 1000
local PLANT11 = 2000
local PLANT12 = 5000
local PLANT13 = 10000


-- /!\ Duplication /!\ TODO: extract into single place
-- Biomes:
local BIOME_ANGMAR     = 1  -- (Angmar)
local BIOME_SNOWPLAINS = 2  -- (Snow-plains)
local BIOME_TROLLSHAWS = 3  -- (Trollshaws)
local BIOME_DUNLANDS   = 4  -- (Dunlands)
local BIOME_GONDOR     = 5  -- (Gondor)
local BIOME_ITHILIEN   = 6  -- (Ithilien)
local BIOME_LORIEN     = 7  -- (Lorien)
local BIOME_MORDOR     = 8  -- (Mordor)
local BIOME_FANGORN    = 9  -- (Fangorn)
local BIOME_MIRKWOOD   = 10 -- (Mirkwood)
local BIOME_HILLS      = 11 -- (Iron Hills)
local BIOME_ROHAN      = 12 -- (Rohan)
local BIOME_SHIRE      = 13 -- (Shire)


local id_ice          = id("default:ice")
local id_angsnowblock = id("lottmapgen:angsnowblock")
local id_frozenstone  = id("lottmapgen:frozen_stone")
local biome_grass     = {
	[BIOME_ANGMAR] = function()
		local block_id = id_angsnowblock
		if math_random(121) == 2 then
			block_id = id_ice
		elseif math_random(25) == 2 then
			block_id = id_frozenstone
		end
		return block_id
	end,
	[BIOME_SNOWPLAINS] = id("default:dirt_with_snow"), -- additionally covers with "default:snowblock" (see below)
	[BIOME_TROLLSHAWS] = id("default:dirt_with_snow"),
	[BIOME_DUNLANDS] = id("lottmapgen:dunland_grass"),
	[BIOME_GONDOR] = id("lottmapgen:gondor_grass"),
	[BIOME_ITHILIEN] = id("lottmapgen:ithilien_grass"),
	[BIOME_LORIEN] = id("lottmapgen:lorien_grass"),
	[BIOME_MORDOR] = id("lottmapgen:mordor_stone"),
	[BIOME_FANGORN] = id("lottmapgen:fangorn_grass"),
	[BIOME_MIRKWOOD] = id("lottmapgen:mirkwood_grass"),
	[BIOME_HILLS] = id("lottmapgen:ironhill_grass"),
	[BIOME_ROHAN] = id("lottmapgen:rohan_grass"),
	[BIOME_SHIRE] = id("lottmapgen:shire_grass"),
}


local biome_airspace = {
	[BIOME_ANGMAR] = {
		flora = {
			plants = {
				[id("default:dry_shrub")] = PLANT3,
				[id("lottplants:seregon")] = PLANT6,
				[id("flowers:tulip_black")] = PLANT8,
			},
			trees = {
				[lottmapgen_pinetree] = TREE7,
				[lottmapgen_firtree]  = TREE8,
				[id("lottmapgen:beechgen")] = TREE10,
			},
		},
		buildings = {
			[id("lottmapgen:angmarfort")] = PLANT13,
		}
	},
	[BIOME_SNOWPLAINS] = id("default:snowblock"),
	[BIOME_TROLLSHAWS] = {
		flora = {
			plants = {
				[id("default:dry_shrub")] = PLANT3,
			},
			trees = {
				[lottmapgen_pinetree] = TREE4,
				[lottmapgen_firtree]  = TREE3,
				[id("lottmapgen:beechgen")] = TREE10,
			},
		},
		buildings = {},
	},
	[BIOME_DUNLANDS] = {
		flora = {
			plants = {
				[lottmapgen_grass] = PLANT3,
				[id("farming:cotton_wild")] = PLANT10,
			},
			trees = {
				[lottmapgen_defaulttree] = TREE5,
				[lottmapgen_appletree]   = TREE7,
			},
		},
		buildings = {},
	},
	[BIOME_GONDOR] = {
		flora = {
			plants = {
				[lottmapgen_grass] = PLANT3,
				[lottmapgen_farmingplants] = PLANT8,
				[lottmapgen_farmingrareplants] = PLANT13,
				[id("lottplants:mallos")] = PLANT6,
				[id("flowers:tulip")] = PLANT8,
				[id("flowers:rose")] = PLANT9,
			},
			trees = {
				[lottmapgen_defaulttree] = TREE7,
				[lottmapgen_aldertree] = TREE8,
				[lottmapgen_appletree] = TREE9,
				[lottmapgen_plumtree] = TREE8,
				[lottmapgen_elmtree] = TREE10,
				[lottmapgen_whitetree] = PLANT13,
			},
		},
		buildings = {
			[id("lottmapgen:gondorfort")] = PLANT13,
		},
	},
	[BIOME_ITHILIEN] = {
		flora = {
			plants = {
				[lottmapgen_farmingplants] = PLANT8,
				[id("lottplants:melon_wild")] = PLANT13,
				[lottmapgen_ithildinplants] = PLANT5,
				[id("flowers:dandelion_white")] = PLANT7,
				[id("flowers:dandelion_yellow")] = PLANT7,
				[id("flowers:viola")] = PLANT10,
			},
			trees = {
				[lottmapgen_defaulttree] = TREE3,
				[lottmapgen_lebethrontree] = TREE6,
				[lottmapgen_appletree] = TREE3,
				[lottmapgen_culumaldatree] = TREE5,
				[lottmapgen_plumtree] = TREE5,
				[lottmapgen_elmtree] = PLANT9,
			},
		},
		buildings = {},
	},
	[BIOME_LORIEN] = {
		flora = {
			plants = {
				[lottmapgen_lorien_grass] = PLANT2,
				[lottmapgen_lorienplants] = PLANT4,
				[id("flowers:dandelion_white")] = PLANT5,
			},
			trees = {
				[lottmapgen_mallornsmalltree] = TREE3,
				[lottmapgen_young_mallorn] = TREE2,
				[id("lottmapgen:mallorngen")] = TREE5,
			},
		},
		buildings = {
			[id("lottmapgen:mallornhouse")] = PLANT13 * 2,
			[id("lottmapgen:lorienhouse")] = PLANT13 * 2,
		},
	},
	[BIOME_MORDOR] = {
		flora = {
			plants = {
				[id("lottplants:brambles_of_mordor")] = PLANT4,
				[id("default:dry_shrub")] = PLANT5,
			},
			trees = {
				[lottmapgen_burnedtree] = TREE8,
			},
		},
		buildings = {
			[id("lottmapgen:orcfort")] = PLANT13,
		},
	},
	[BIOME_FANGORN] = {
		flora = {
			plants = {
				[lottmapgen_farmingplants] = PLANT4,
				[id("lottplants:melon_wild")] = PLANT9,
				[id("flowers:geranium")] = PLANT10,
				[id("farming:cotton_wild")] = PLANT10,
			},
			trees = {
				[lottmapgen_defaulttree] = TREE3,
				[lottmapgen_rowantree] = TREE4,
				[lottmapgen_appletree] = TREE4,
				[lottmapgen_birchtree] = TREE5,
				[lottmapgen_plumtree] = TREE5,
				[lottmapgen_elmtree] = TREE7,
				[lottmapgen_oaktree] = TREE6,
			},
		},
		buildings = {},
	},
	[BIOME_MIRKWOOD] = {
		flora = {
			plants = {
				[id("flowers:tulip_black")] = PLANT8,
				[id("default:junglegrass")] = PLANT3,
				[lottmapgen_fern] = PLANT1,
			},
			trees = {
				[id("lottmapgen:mirktreegen")] = TREE2,
				[lottmapgen_jungletree] = TREE4,
			},
		},
		buildings = {
			[id("lottmapgen:mirkhouse")] = PLANT13,
		},
	},
	[BIOME_HILLS] = {
		flora = {
			plants = {
				[id("default:grass_1")] = PLANT8,
				[id("flowers:chrysanthemum_green")] = PLANT8,
			},
			trees = {
				[id("lottmapgen:beechgen")] = TREE10,
				[lottmapgen_pinetree] = TREE4,
				[lottmapgen_firtree] = TREE6,
			},
		},
		buildings = {},
	},
	[BIOME_ROHAN] = {
		flora = {
			plants = {
				[lottmapgen_dry_grass] = PLANT3,
				[lottmapgen_grass] = PLANT5,
				[lottmapgen_farmingplants] = PLANT8,
				[id("lottplants:melon_wild")] = PLANT13,
				[id("lottplants:pilinehtar")] = PLANT6,
				[id("flowers:chrysanthemum_green")] = PLANT9,
			},
			trees = {
				[lottmapgen_defaulttree] = TREE7,
				[lottmapgen_appletree] = TREE7,
				[lottmapgen_plumtree] = TREE8,
				[lottmapgen_elmtree] = TREE10,
			},
		},
		buildings = {
			[id("lottmapgen:rohanfort")] = PLANT13,
		},
	},
	[BIOME_SHIRE] = {
		flora = {
			plants = {
				[lottmapgen_grass_1_3] = PLANT4,
				[lottmapgen_farmingplants] = PLANT7,
				[id("lottplants:melon_wild")] = PLANT9,
				[id("flowers:dandelion_white")] = PLANT7,
				[id("flowers:dandelion_yellow")] = PLANT7,
				[id("flowers:chrysanthemum_green")] = PLANT9,
				[id("flowers:geranium")] = PLANT10,
				[id("flowers:viola")] = PLANT11,
			},
			trees = {
				[lottmapgen_defaulttree] = TREE7,
				[lottmapgen_appletree] = TREE7,
				[lottmapgen_plumtree] = TREE7,
				[lottmapgen_oaktree] = TREE7,
			},
		},
		buildings = {
			[id("lottmapgen:hobbithole")] = PLANT13,
		},
	},
}

return {
	biome_grass = biome_grass,
	biome_airspace = biome_airspace,
}
