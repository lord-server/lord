local mod_path    = minetest.get_modpath(minetest.get_current_modname())
dofile(mod_path .. "/rock_ores.lua")

--
-- Ore generation
--

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_coal",
	wherein        = "default:stone",
	clust_scarcity = 8*8*8,
	clust_num_ores = 8,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = 64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_coal",
	wherein        = "default:stone",
	clust_scarcity = 24*24*24,
	clust_num_ores = 27,
	clust_size     = 6,
	y_min     = -31000,
	y_max     = 0,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_iron",
	wherein        = "default:stone",
	clust_scarcity = 12*12*12,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -15,
	y_max     = 2,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_iron",
	wherein        = "default:stone",
	clust_scarcity = 9*9*9,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -63,
	y_max     = -16,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_iron",
	wherein        = "default:stone",
	clust_scarcity = 7*7*7,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_iron",
	wherein        = "default:stone",
	clust_scarcity = 24*24*24,
	clust_num_ores = 27,
	clust_size     = 6,
	y_min     = -31000,
	y_max     = -64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_mese",
	wherein        = "default:stone",
	clust_scarcity = 18*18*18,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -255,
	y_max     = -64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_mese",
	wherein        = "default:stone",
	clust_scarcity = 14*14*14,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -256,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:mese",
	wherein        = "default:stone",
	clust_scarcity = 36*36*36,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -31000,
	y_max     = -1024,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_gold",
	wherein        = "default:stone",
	clust_scarcity = 15*15*15,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -255,
	y_max     = -64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_gold",
	wherein        = "default:stone",
	clust_scarcity = 13*13*13,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -256,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_diamond",
	wherein        = "default:stone",
	clust_scarcity = 14*14*14,
	clust_num_ores = 4,
	clust_size     = 2,
	y_min     = -31000,
	y_max     = -256,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_copper",
	wherein        = "default:stone",
	clust_scarcity = 12*12*12,
	clust_num_ores = 4,
	clust_size     = 3,
	y_min     = -63,
	y_max     = -16,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:stone_with_copper",
	wherein        = "default:stone",
	clust_scarcity = 9*9*9,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:clay",
	wherein        = "default:sand",
	clust_scarcity = 15*15*15,
	clust_num_ores = 64,
	clust_size     = 5,
	y_max     = 0,
	y_min     = -10,
})



-- Ores Spawning

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:limestone_ore",
	wherein        = "default:stone",
	clust_scarcity = 9*9*9,
	clust_num_ores = 5,
	clust_size     = 2,
	y_min     = -60,
	y_max     = -10,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:limestone_ore",
	wherein        = "default:stone",
	clust_scarcity = 7*7*7,
	clust_num_ores = 5,
	clust_size     = 2,
	y_min     = -31000,
	y_max     = -61,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:limestone_ore",
	wherein        = "default:stone",
	clust_scarcity = 24*24*24,
	clust_num_ores = 15,
	clust_size     = 6,
	y_min     = -31000,
	y_max     = -50,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:silver_ore",
	wherein        = "default:stone",
	clust_scarcity = 15*15*15,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -200,
	y_max     = -50,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:silver_ore",
	wherein        = "default:stone",
	clust_scarcity = 13*13*13,
	clust_num_ores = 6,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -201,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:tin_ore",
	wherein        = "default:stone",
	clust_scarcity = 12*12*12,
	clust_num_ores = 5,
	clust_size     = 2,
	y_min     = -60,
	y_max     = -20,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:tin_ore",
	wherein        = "default:stone",
	clust_scarcity = 9*9*9,
	clust_num_ores = 10,
	clust_size     = 5,
	y_min     = -31000,
	y_max     = -61,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:lead_ore",
	wherein        = "default:stone",
	clust_scarcity = 12*12*12,
	clust_num_ores = 4,
	clust_size     = 3,
	y_min     = -60,
	y_max     = -30,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:lead_ore",
	wherein        = "default:stone",
	clust_scarcity = 9*9*9,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -61,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:rough_rock",
	wherein        = "default:stone",
	clust_scarcity = 15*15*15,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -300,
	y_max     = -70,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:rough_rock",
	wherein        = "default:stone",
	clust_scarcity = 13*13*13,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -31000,
	y_max     = -301,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:blue_gem_ore",
	wherein        = "default:stone",
	clust_scarcity = 14*14*14,
	clust_num_ores = 4,
	clust_size     = 2,
	y_min     = -31000,
	y_max     = -256,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:red_gem_ore",
	wherein        = "default:stone",
	clust_scarcity = 14*14*14,
	clust_num_ores = 4,
	clust_size     = 2,
	y_min     = -31000,
	y_max     = -256,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:white_gem_ore",
	wherein        = "default:stone",
	clust_scarcity = 14*14*14,
	clust_num_ores = 4,
	clust_size     = 2,
	y_min     = -31000,
	y_max     = -256,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:mithril_ore",
	wherein        = "default:stone",
	clust_scarcity = 18*18*18,
	clust_num_ores = 4,
	clust_size     = 3,
	y_min     = -255,
	y_max     = -128,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lottores:mithril_ore",
	wherein        = "default:stone",
	clust_scarcity = 16*16*16,
	clust_num_ores = 4,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -256,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "lord_ores:magma",
	wherein        = "lord_rocks:pyroxenite",
	biomes         = {"pyroxenite_cave"},
	clust_scarcity = 5*5*5,
	clust_num_ores = 12,
	clust_size     = 5,
	y_min     = -31000,
	y_max     = -16000,
})
