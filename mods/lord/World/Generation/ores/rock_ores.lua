for name, _ in pairs(rocks.get_lord_rocks()) do
	local stripped_name = name:replace("lord_rocks:", "")

	-- MTG ores

	-- Coal
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lord_ores:" .. stripped_name .. "_with_coal",
		wherein        = name,
		clust_scarcity = 8*8*8,
		clust_num_ores = 8,
		clust_size     = 3,
		y_min     = -31000,
		y_max     = 64,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lord_ores:" .. stripped_name .. "_with_coal",
		wherein        = name,
		clust_scarcity = 24*24*24,
		clust_num_ores = 27,
		clust_size     = 6,
		y_min     = -31000,
		y_max     = 0,
	})

	-- Iron
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lord_ores:" .. stripped_name .. "_with_iron",
		wherein        = name,
		clust_scarcity = 9*9*9,
		clust_num_ores = 5,
		clust_size     = 3,
		y_min     = -63,
		y_max     = -16,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lord_ores:" .. stripped_name .. "_with_iron",
		wherein        = name,
		clust_scarcity = 7*7*7,
		clust_num_ores = 5,
		clust_size     = 3,
		y_min     = -31000,
		y_max     = -64,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lord_ores:" .. stripped_name .. "_with_iron",
		wherein        = name,
		clust_scarcity = 24*24*24,
		clust_num_ores = 27,
		clust_size     = 6,
		y_min     = -31000,
		y_max     = -64,
	})

	-- Copper
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lord_ores:" .. stripped_name .. "_with_copper",
		wherein        = name,
		clust_scarcity = 12*12*12,
		clust_num_ores = 4,
		clust_size     = 3,
		y_min     = -63,
		y_max     = -16,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lord_ores:" .. stripped_name .. "_with_copper",
		wherein        = name,
		clust_scarcity = 9*9*9,
		clust_num_ores = 5,
		clust_size     = 3,
		y_min     = -31000,
		y_max     = -64,
	})

	-- Mese
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lord_ores:" .. stripped_name .. "_with_mese",
		wherein        = name,
		clust_scarcity = 18*18*18,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min     = -255,
		y_max     = -64,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lord_ores:" .. stripped_name .. "_with_mese",
		wherein        = name,
		clust_scarcity = 14*14*14,
		clust_num_ores = 5,
		clust_size     = 3,
		y_min     = -31000,
		y_max     = -256,
	})

	-- Mese blocks
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:mese",
		wherein        = name,
		clust_scarcity = 36*36*36,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min     = -31000,
		y_max     = -1024,
	})

	-- Gold
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lord_ores:" .. stripped_name .. "_with_gold",
		wherein        = name,
		clust_scarcity = 15*15*15,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min     = -255,
		y_max     = -64,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lord_ores:" .. stripped_name .. "_with_gold",
		wherein        = name,
		clust_scarcity = 13*13*13,
		clust_num_ores = 5,
		clust_size     = 3,
		y_min     = -31000,
		y_max     = -256,
	})

	-- Diamond
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lord_ores:" .. stripped_name .. "_with_diamond",
		wherein        = name,
		clust_scarcity = 14*14*14,
		clust_num_ores = 4,
		clust_size     = 2,
		y_min     = -31000,
		y_max     = -256,
	})


	-- lottores

	-- Limestone
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lottores:limestone_ore",
		wherein        = name,
		clust_scarcity = 9*9*9,
		clust_num_ores = 5,
		clust_size     = 2,
		y_min     = -60,
		y_max     = -10,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lottores:limestone_ore",
		wherein        = name,
		clust_scarcity = 7*7*7,
		clust_num_ores = 5,
		clust_size     = 2,
		y_min     = -31000,
		y_max     = -61,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lottores:limestone_ore",
		wherein        = name,
		clust_scarcity = 24*24*24,
		clust_num_ores = 15,
		clust_size     = 6,
		y_min     = -31000,
		y_max     = -50,
	})

	-- Silver
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lord_ores:" .. stripped_name .. "_with_silver",
		wherein        = name,
		clust_scarcity = 15*15*15,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min     = -200,
		y_max     = -50,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lord_ores:" .. stripped_name .. "_with_silver",
		wherein        = name,
		clust_scarcity = 13*13*13,
		clust_num_ores = 6,
		clust_size     = 3,
		y_min     = -31000,
		y_max     = -201,
	})

	-- Tin
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lord_ores:" .. stripped_name .. "_with_tin",
		wherein        = name,
		clust_scarcity = 12*12*12,
		clust_num_ores = 5,
		clust_size     = 2,
		y_min     = -60,
		y_max     = -20,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lord_ores:" .. stripped_name .. "_with_tin",
		wherein        = name,
		clust_scarcity = 9*9*9,
		clust_num_ores = 10,
		clust_size     = 5,
		y_min     = -31000,
		y_max     = -61,
	})

	-- Lead
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lord_ores:" .. stripped_name .. "_with_lead",
		wherein        = name,
		clust_scarcity = 12*12*12,
		clust_num_ores = 4,
		clust_size     = 3,
		y_min     = -60,
		y_max     = -30,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lord_ores:" .. stripped_name .. "_with_lead",
		wherein        = name,
		clust_scarcity = 9*9*9,
		clust_num_ores = 5,
		clust_size     = 3,
		y_min     = -31000,
		y_max     = -61,
	})

	-- Rough rock
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lottores:rough_rock",
		wherein        = name,
		clust_scarcity = 15*15*15,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min     = -300,
		y_max     = -70,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lottores:rough_rock",
		wherein        = name,
		clust_scarcity = 13*13*13,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min     = -31000,
		y_max     = -301,
	})

	-- Mithril
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lord_ores:" .. stripped_name .. "_with_mithril",
		wherein        = name,
		clust_scarcity = 18*18*18,
		clust_num_ores = 4,
		clust_size     = 3,
		y_min     = -255,
		y_max     = -128,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lord_ores:" .. stripped_name .. "_with_mithril",
		wherein        = name,
		clust_scarcity = 16*16*16,
		clust_num_ores = 4,
		clust_size     = 3,
		y_min     = -31000,
		y_max     = -256,
	})

	-- Gems
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lord_ores:" .. stripped_name .. "_with_blue_gem",
		wherein        = name,
		clust_scarcity = 14*14*14,
		clust_num_ores = 4,
		clust_size     = 2,
		y_min     = -31000,
		y_max     = -256,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lord_ores:" .. stripped_name .. "_with_red_gem",
		wherein        = name,
		clust_scarcity = 14*14*14,
		clust_num_ores = 4,
		clust_size     = 2,
		y_min     = -31000,
		y_max     = -256,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "lord_ores:" .. stripped_name .. "_with_white_gem",
		wherein        = name,
		clust_scarcity = 14*14*14,
		clust_num_ores = 4,
		clust_size     = 2,
		y_min     = -31000,
		y_max     = -256,
	})

end
