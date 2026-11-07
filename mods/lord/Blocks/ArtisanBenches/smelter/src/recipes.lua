
local smelter_recipes = {
	-- Level: 1
	{ 1, 'default:copper_lump'      , ''                         , 'default:copper_ingot'        ,  3 },
	{ 1, 'default:copper_lump'      , 'default:copper_lump'      , 'default:copper_ingot 2'      ,  6 },
	{ 1, 'group:copper_item'        , ''                         , 'default:copper_ingot'        ,  3 },
	{ 1, 'lottores:tin_lump'        , ''                         , 'lottores:tin_ingot'          ,  3 },
	{ 1, 'lottores:tin_lump'        , 'lottores:tin_lump'        , 'lottores:tin_ingot 2'        ,  6 },
	{ 1, 'group:tin_item'           , ''                         , 'lottores:tin_ingot'          ,  3 },
	{ 1, 'default:iron_lump'        , ''                         , 'default:steel_ingot'         ,  3 },
	{ 1, 'default:iron_lump'        , 'default:iron_lump'        , 'default:steel_ingot 2'       ,  6 },
	{ 1, 'group:steel_item'         , ''                         , 'default:steel_ingot'         ,  3 },
	{ 1, 'carts:rail'               , ''                         , 'default:steel_ingot'         ,  3 },
	{ 1, 'carts:powerrail'          , ''                         , 'default:steel_ingot'         ,  3 },
	{ 1, 'carts:brakerail'          , ''                         , 'default:steel_ingot'         ,  3 },
	{ 1, 'vessels:steel_bottle'     , ''                         , 'default:steel_ingot'         ,  3 },
	{ 1, 'lottores:tin_ingot'       , 'default:copper_ingot'     , 'default:bronze_ingot 2'      ,  6 },
	{ 1, 'default:copper_ingot'     , 'lottores:tin_ingot'       , 'default:bronze_ingot 2'      ,  6 },
	{ 1, 'group:bronze_item'        , ''                         , 'default:bronze_ingot'        ,  3 },
	-- Level: 2
	{ 2, 'lottores:silver_lump'     , ''                         , 'lottores:silver_ingot'       ,  3 },
	{ 2, 'lottores:silver_lump'     , 'lottores:silver_lump'     , 'lottores:silver_ingot 2'     ,  6 },
	{ 2, 'group:silver_item'        , ''                         , 'lottores:silver_ingot'       ,  3 },
	{ 2, 'default:gold_lump'        , ''                         , 'default:gold_ingot'          ,  3 },
	{ 2, 'default:gold_lump'        , 'default:gold_lump'        , 'default:gold_ingot 2'        ,  6 },
	{ 2, 'group:gold_item'          , ''                         , 'default:gold_ingot'          ,  3 },
	{ 2, 'keys:key'                 , ''                         , 'default:gold_ingot'          ,  3 },
	{ 2, 'keys:skeleton_key'        , ''                         , 'default:gold_ingot'          ,  3 },
	-- Level: 3
	{ 3, 'lottores:lead_lump'       , 'default:mese_crystal'     , 'lottores:galvorn_ingot'      , 18 },
	{ 3, 'group:galvorn_item'       , ''                         , 'lottores:galvorn_ingot'      , 18 },
	{ 3, 'lottores:lead_lump'       , ''                         , 'lottores:lead_ingot'         ,  3 },
	{ 3, 'lottores:lead_lump'       , 'lottores:lead_lump'       , 'lottores:lead_ingot 2'       ,  6 },
	{ 3, 'group:lead_item'          , ''                         , 'lottores:lead_ingot'         ,  3 },
	{ 3, 'lottores:mithril_lump'    , ''                         , 'lottores:mithril_ingot'      ,  3 },
	{ 3, 'lottores:mithril_lump'    , 'lottores:mithril_lump'    , 'lottores:mithril_ingot 2'    ,  6 },
	{ 3, 'group:mithril_item'       , ''                         , 'lottores:mithril_ingot'      ,  3 },
	{ 3, 'lottother:ringsilver_lump', ''                         , 'lottother:ringsilver_ingot'  , 35 },
	{ 3, 'lottother:ringsilver_lump', 'lottother:ringsilver_lump', 'lottother:ringsilver_ingot 2', 70 },
}

return smelter_recipes
