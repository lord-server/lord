dofile(minetest.get_modpath("lottmobs").."/src/trader.lua")

local common_trader_definition = {
	type                 = "npc",
	visual               = "mesh",
	animation            = {
		speed_normal = 15,
		speed_run    = 15,
		stand_start  = 0,
		stand_end    = 79,
		walk_start   = 168,
		walk_end     = 187,
		run_start    = 168,
		run_end      = 187,
		punch_start  = 189,
		punch_end    = 198,
	},
	makes_footstep_sound = true,
	walk_velocity        = 1, -- except elves (1.5)
	light_resistant      = true,
	drawtype             = "front",
	water_damage         = 1,
	lava_damage          = 10, -- except hobbits (5)
	light_damage         = 0,
	attack_type          = "dogfight",
	follow               = "lottother:narya", -- except hobbits
	jump                 = true,
	drops                = {
		{ name = "lord_money:copper_coin", chance = 2, min = 1, max = 30, },
		{ name = "lord_money:silver_coin", chance = 6, min = 1, max = 9, },
		{ name = "lord_money:gold_coin",   chance = 9, min = 1, max = 3, },
	},
	attacks_monsters     = true, -- except hobbits
	group_attack         = true, -- except hobbits
	sounds       = { -- except hobbits (nil)
		war_cry = "mobs_die_yell",
		death   = "default_death",
		attack  = "default_punch2", -- except elves (mobs_slash_attack)
	}
}

local function register_trader(name, definition)
	local def            = table.merge(common_trader_definition, definition)
	local race_privilege = "GAME" .. def.race -- GAMEelf, GAMEman, GAMEhobbit, GAMEdwarf
	def.on_rightclick    = function(self, clicker)
		lottmobs_trader(self, clicker, def.race, race_privilege)
	end

	mobs:register_mob(name, def)
end

register_trader("lottmobs:elf_trader", {
	race          = "elf",
	hp_min        = 20,
	hp_max        = 50,
	collisionbox  = { -0.3, -1.1, -0.3, 0.3, 0.91, 0.3 },
	textures      = {
		{ "lottmobs_elf_trader.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png" },
	},
	visual_size   = { x = 0.95, y = 1.15 },
	mesh          = "lottarmor_character_old.b3d",
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

register_trader("lottmobs:human_trader", {
	race         = "man",
	hp_min       = 15,
	hp_max       = 35,
	collisionbox = { -0.3, -1.0, -0.3, 0.3, 0.8, 0.3 },
	textures     = {
		{ "lottmobs_human_trader.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png" },
	},
	mesh         = "lottarmor_character_old.b3d",
	view_range   = 12,
	run_velocity = 3,
	armor        = 100,
	damage       = 5,
})

register_trader("lottmobs:hobbit_trader", {
	race             = "hobbit",
	hp_min           = 5,
	hp_max           = 15,
	collisionbox     = { -0.3, -0.75, -0.3, 0.3, 0.7, 0.3 },
	textures         = {
		{ "lottmobs_hobbit_trader.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png" },
	},
	visual_size      = { x = 1.1, y = 0.75 },
	mesh             = "lottarmor_character_old.b3d",
	armor            = 300,
	lava_damage      = 5,
	follow           = nil,
	attacks_monsters = false,
	group_attack     = false,
	passive          = true,
	sounds           = nil,
})

register_trader("lottmobs:dwarf_trader", {
	race         = "dwarf",
	hp_min       = 20,
	hp_max       = 30,
	collisionbox = { -0.3, -.85, -0.3, 0.3, 0.68, 0.3 },
	textures     = {
		{ "lottmobs_dwarf_trader.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png" },
	},
	visual_size  = { x = 1.1, y = 0.85 },
	mesh         = "lottarmor_character_old.b3d",
	view_range   = 10,
	run_velocity = 2,
	armor        = 200,
	damage       = 4,
})

mobs:spawn_specific("lottmobs:elf_trader",   {"lottmapgen:lorien_grass"},  {"air"},  0, 20, 30, 90000, 2, -31000, 31000)
mobs:spawn_specific("lottmobs:human_trader", {"lottmapgen:rohan_grass"},   {"air"}, -1, 20, 30, 90000, 2, -31000, 31000)
mobs:spawn_specific("lottmobs:human_trader", {"lottmapgen:gondor_grass"},  {"air"}, -1, 20, 30, 90000, 2, -31000, 31000)
mobs:spawn_specific("lottmobs:hobbit_trader",{"lottmapgen:shire_grass"},   {"air"}, -1, 20, 30, 90000, 2, -31000, 31000)
mobs:spawn_specific("lottmobs:dwarf_trader", {"lottmapgen:ironhill_grass"},{"air"}, -1, 20, 30, 90000, 2, -31000, 31000)
