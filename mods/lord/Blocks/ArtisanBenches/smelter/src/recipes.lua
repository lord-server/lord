
local smelter_recipes = {
	-- level1
	{ 'default:iron_lump'         , ''                          , 'default:steel_ingot'          , 6  },
	{ 'default:iron_lump'         , 'default:iron_lump'         , 'default:steel_ingot 2'        , 12 },
	{ 'group:iron_item'           , ''                          , 'default:iron_ingot'           , 6  },
	{ 'lottores:tin_ingot'        , 'defult:copper_ingot'       , 'default:bronze_ingot 2'       , 12 },
	{ 'group:bronze_item'         , ''                          , 'default:iron_ingot'           , 6  },
	-- level2
	{ 'lottores:silver_lump'      , ''                          , 'lottores:silver_ingot'        , 6  },
	{ 'lottores:silver_lump'      , 'lottores:silver_lump'      , 'lottores:silver_ingot 2'      , 12 },
	{ 'group:silver_item'         , ''                          , 'lottores:silver_ingot'        , 6  },
	{ 'default:gold_lump'         , ''                          , 'default:gold_ingot'           , 6  },
	{ 'default:gold_lump'         , 'default:gold_lump'         , 'default:gold_ingot 2'         , 12 },
	{ 'group:gold_item'           , ''                          , 'default:gold_ingot'           , 6  },
	-- level3
	{ 'lottores:lead_lump'        , ''                          , 'lottores:lead_ingot'          , 6  },
	{ 'lottores:lead_lump'        , 'lottores:lead_lump'        , 'lottores:lead_ingot 2'        , 12 },
	{ 'group:lead_item'           , ''                          , 'lottores:lead_ingot'          , 6  },
	{ 'lottores:mithril_lump'     , ''                          , 'lottores:mithril_ingot'       , 6  },
	{ 'lottores:mithril_lump'     , 'lottores:mithril_lump'     , 'lottores:mithril_ingot 2'     , 12 },
	{ 'group:mithril_item'        , ''                          , 'lottores:mithril_ingot'       , 6  },
	{ 'lottores:lead_lump'        , 'default:mese_crystal'      , 'lottores:galvorn_ingot'       , 18 },
	{ 'group:galvorn_item'        , ''                          , 'lottores:galvorn_ingot'       , 18 },
	{ 'lottother:ringsilver_lump' , ''                          , 'lottother:ringsilver_ingot'   , 35 },
	{ 'lottother:ringsilver_lump' , 'lottother:ringsilver_lump' , 'lottother:ringsilver_ingot 2' , 70 },
}

for _, row in ipairs(smelter_recipes) do
	local smelterin1 = row[1]
	local smelterin2 = row[2]
	local smelterout = row[3]
	local cooktime   = row[4]

	-- следует проверять наличие рецепта до его удаления
	minetest.clear_craft({
		type = "cooking",
		output = smelterout,
		recipe = smelterin1,
	})

	minetest.register_craft({
		method = minetest.CraftMethod.SMELTER,
		type   = 'cooking',
		output = smelterout,
		recipe = { smelterin1 , smelterin2 },
		time   = cooktime,
	})

	if smelterin1 ~= smelterin2 then
		minetest.register_craft({
			method = minetest.CraftMethod.SMELTER,
			type   = 'cooking',
			output = smelterout,
			recipe = { smelterin2 , smelterin1 },
			time   = cooktime,
		})
	end
end
