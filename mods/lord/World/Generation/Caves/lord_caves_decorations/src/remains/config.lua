local place_on = table.keys(rocks.get_nodes())

local config = {
	common = {
		deco_type    = 'simple',
		place_on     = place_on,
		sidelen      = 32, -- we have small `fill_ratio`, so we can use at least 32 or even higher
		flags        = 'all_floors', -- генерировать только на полу
		decoration   = {
			'remains:ancient_miner_mapgen_1',
			'remains:ancient_miner_mapgen_2',
		},
		spawn_by     = 'air',
		num_spawn_by = 1,
	},

	deep_level_1 = {
		name = 'remains:ancient_miner_deep_level_1',
		y_max = -100,
		y_min = -250,
		fill_ratio = 1/48000,
	},
	deep_level_2 = {
		name = 'remains:ancient_miner_deep_level_2',
		y_max = -250,
		y_min = -1000,
		fill_ratio = 1/24000,
	},
	deep_level_3 = {
		name = 'remains:ancient_miner_deep_level_3',
		y_max = -1000,
		y_min = -30000,
		fill_ratio = 1/18000,
	}
--	deep_level_4 = {
--		name = 'remains:ancient_miner_deep_level_4',
--		y_max = -30000,
--		y_min = -31000,
--		fill_ratio = 1/8000,
--	},
}

return {
	--- @type lord_caves_decorations.remains.config
	deep_level_1 = config.deep_level_1,
	deep_level_2 = config.deep_level_2,
	deep_level_3 = config.deep_level_3,
--	deep_level_4 = config.deep_level_4,
	common = config.common
}
