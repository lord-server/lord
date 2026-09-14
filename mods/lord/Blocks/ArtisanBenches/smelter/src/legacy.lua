--удаляем рецепты с использованием печи
local furnace_recipes = {
	-- steel ingot
	{ 'default:iron_lump',         'default:steel_ingot'        }, -- default (MTG)
	{ 'group:steel_item',          'default:steel_ingot'        }, -- lord_default
	{ 'carts:rail',                'default:steel_ingot'        }, -- lord_overwrites_mtg_carts
	{ 'carts:powerrail',           'default:steel_ingot'        }, -- lord_overwrites_mtg_carts
	{ 'carts:brakerail',           'default:steel_ingot'        }, -- lord_overwrites_mtg_carts
	{ 'vessels:steel_bottle',      'default:steel_ingot'        }, -- vessels (MTG)
	-- bronze ingot
	{ 'group:bronze_item',         'default:bronze_ingot'       }, -- lord_default
	-- silver ingot
	{ 'lottores:silver_lump',      'lottores:silver_ingot'      }, -- lottores
	{ 'group:silver_item',         'lottores:silver_ingot'      }, -- lottores
	-- gold ingot
	{ 'default:gold_lump',         'default:gold_ingot'         }, -- default (MTG)
	{ 'group:gold_item',           'default:gold_ingot'         }, -- lord_default
	{ 'keys:key',                  'default:gold_ingot'         }, -- keys (MTG)
	{ 'keys:skeleton_key',         'default:gold_ingot'         }, -- keys (MTG)
	-- lead ingot
	{ 'lottores:lead_lump',        'lottores:lead_ingot'        }, -- lottores
	{ 'group:lead_item',           'lottores:lead_ingot'        }, -- lottores
	-- galvorn ingot
	{ 'group:galvorn_item',        'lottores:galvorn_ingot'     }, -- lottores
	-- mithril ingot
	{ 'lottores:mithril_lump',     'lottores:mithril_ingot'     }, -- lottores
	{ 'group:mithril_item',        'lottores:mithril_ingot'     }, -- lottores
	-- ringsilver ingot
	{ 'lottother:ringsilver_lump', 'lottother:ringsilver_ingot' }, -- lottother
}

for _, row in ipairs(furnace_recipes) do
	core.clear_craft({
		type   = 'cooking',
		recipe = row[1],
	})
end

-- lord_overwrites_mtg_default
core.clear_craft({
	type   = 'shapeless',
	recipe = { 'lottores:tin_ingot', 'default:copper_ingot' },
})

-- медь и олово в печке:
--   переопределяем время переплавки с дефолтных 3 на 6,
--   чтобы Плавильня (время 3) для них была быстрее и имела смысл
local furnace_time_overrides = {
	{ 'default:copper_lump', 'default:copper_ingot' },
	{ 'group:copper_item',   'default:copper_ingot' },
	{ 'lottores:tin_lump',   'lottores:tin_ingot'   },
	{ 'group:tin_item',      'lottores:tin_ingot'   },
}
for _, row in ipairs(furnace_time_overrides) do
	core.clear_craft({
		type   = 'cooking',
		recipe = row[1],
	})
	core.register_craft({
		type     = 'cooking',
		output   = row[2],
		recipe   = row[1],
		cooktime = 6,
	})
end
