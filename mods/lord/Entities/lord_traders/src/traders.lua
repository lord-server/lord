
local trader = require("traders.trader")

-- TODO move this into lord_mobs_common & use for other humanlike mobs
local MODEL_HEIGHT = 1.8
local lord_mobs = {}
lord_mobs.humanlike                   = {
	height  = { man = 1, elf = 1.15, hobbit = 0.75, dwarf = 0.85 },
	fatness = { man = 1, elf = 0.90, hobbit = 1.1,  dwarf = 1.25 }
}
lord_mobs.humanlike.get_collision_box = function(race)
	local h = lord_mobs.humanlike.height[race]
	local f = lord_mobs.humanlike.fatness[race]
	local mh = MODEL_HEIGHT

	return {
		-0.3 * f,       -h,  -0.3 * f,
		 0.3 * f, (mh-1)*h,   0.3 * f
	}
end
lord_mobs.humanlike.get_visual_size   = function(race)
	local h = lord_mobs.humanlike.height[race]
	local f = lord_mobs.humanlike.fatness[race]

	return { x = h * f, y = h }
end
local get_collision_box               = lord_mobs.humanlike.get_collision_box
local get_visual_size                 = lord_mobs.humanlike.get_visual_size
-- end TODO-------------------------------------------------------------------

trader.register(":lottmobs:elf_trader", {
	race          = "elf",
	hp_min        = 20,
	hp_max        = 50,
	collisionbox  = get_collision_box("elf"),
	visual_size   = get_visual_size("elf"),
	textures      = {
		{ "lottmobs_elf_trader.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png" },
	},
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
	collisionbox = get_collision_box("man"),
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
	collisionbox     = get_collision_box("hobbit"),
	visual_size      = get_visual_size("hobbit"),
	textures         = {
		{ "lottmobs_hobbit_trader.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png" },
	},
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
	collisionbox = get_collision_box("dwarf"),
	visual_size  = get_visual_size("dwarf"),
	textures     = {
		{ "lottmobs_dwarf_trader.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png" },
	},
	view_range   = 10,
	run_velocity = 2,
	armor        = 200,
	damage       = 4,
})

mobs:spawn_specific("lottmobs:elf_trader",   {"lord_ground:dirt_lorien"},  {"air"}, -1, 20, 30, 90000, 2, -31000, 31000)
mobs:spawn_specific("lottmobs:human_trader", {"lord_ground:dirt_rohan"},   {"air"}, -1, 20, 30, 90000, 2, -31000, 31000)
mobs:spawn_specific("lottmobs:human_trader", {"lord_ground:dirt_gondor"},  {"air"}, -1, 20, 30, 90000, 2, -31000, 31000)
mobs:spawn_specific("lottmobs:hobbit_trader",{"lord_ground:dirt_shire"},   {"air"}, -1, 20, 30, 90000, 2, -31000, 31000)
mobs:spawn_specific("lottmobs:dwarf_trader", {"lord_ground:dirt_iron_hills"},{"air"},-1,20, 30, 90000, 2, -31000, 31000)
