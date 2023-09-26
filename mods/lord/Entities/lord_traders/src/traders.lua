local mod_path = minetest.get_modpath(minetest.get_current_modname())
local require = function(name) return dofile(mod_path .. "/src/" .. name:gsub("%.", "/") .. ".lua") end


local trader = require("traders.trader")


trader.register(":lottmobs:elf_trader", {
	race          = "elf",
	hp_min        = 20,
	hp_max        = 50,
	collisionbox  = { -0.3, -1.1, -0.3, 0.3, 0.91, 0.3 },
	textures      = {
		{ "lottmobs_elf_trader.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png" },
	},
	visual_size   = { x = 0.95, y = 1.15 },
	view_range    = 20,
	walk_velocity = 1.5,
	run_velocity  = 5,
	damage        = 6,
	armor         = 200,
	animation     = {
		speed_run = 20,
	},
	sounds        = {
		attack  = "mobs_slash_attack",
	},
})

trader.register(":lottmobs:human_trader", {
	race         = "man",
	hp_min       = 15,
	hp_max       = 35,
	collisionbox = { -0.3, -1.0, -0.3, 0.3, 0.8, 0.3 },
	textures     = {
		{ "lottmobs_human_trader.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png" },
	},
	view_range   = 12,
	run_velocity = 3,
	armor        = 100,
	damage       = 5,
})

trader.register(":lottmobs:hobbit_trader", {
	race             = "hobbit",
	hp_min           = 5,
	hp_max           = 15,
	collisionbox     = { -0.3, -0.75, -0.3, 0.3, 0.7, 0.3 },
	textures         = {
		{ "lottmobs_hobbit_trader.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png" },
	},
	visual_size      = { x = 1.1, y = 0.75 },
	armor            = 300,
	lava_damage      = 5,
	follow           = nil,
	attacks_monsters = false,
	group_attack     = false,
	passive          = true,
	sounds           = nil,
})

trader.register(":lottmobs:dwarf_trader", {
	race         = "dwarf",
	hp_min       = 20,
	hp_max       = 30,
	collisionbox = { -0.3, -.85, -0.3, 0.3, 0.68, 0.3 },
	textures     = {
		{ "lottmobs_dwarf_trader.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png" },
	},
	visual_size  = { x = 1.1, y = 0.85 },
	view_range   = 10,
	run_velocity = 2,
	armor        = 200,
	damage       = 4,
})

mobs:spawn_specific("lottmobs:elf_trader",   {"lottmapgen:lorien_grass"},  {"air"}, -1, 20, 30, 90000, 2, -31000, 31000)
mobs:spawn_specific("lottmobs:human_trader", {"lottmapgen:rohan_grass"},   {"air"}, -1, 20, 30, 90000, 2, -31000, 31000)
mobs:spawn_specific("lottmobs:human_trader", {"lottmapgen:gondor_grass"},  {"air"}, -1, 20, 30, 90000, 2, -31000, 31000)
mobs:spawn_specific("lottmobs:hobbit_trader",{"lottmapgen:shire_grass"},   {"air"}, -1, 20, 30, 90000, 2, -31000, 31000)
mobs:spawn_specific("lottmobs:dwarf_trader", {"lottmapgen:ironhill_grass"},{"air"}, -1, 20, 30, 90000, 2, -31000, 31000)
