function lottmobs.register_elf(n, hpmin, hpmax, textures, wv, rv, damg, arm, drops)
	mobs:register_mob("lottmobs:elf" .. n, {
		type                 = "npc",
		hp_min               = hpmin,
		hp_max               = hpmax,
		collisionbox         = { -0.27, -1.15, -0.27, 0.27, 0.92, 0.27 },
		textures             = textures,
		visual               = "mesh",
		visual_size          = { x = 1.035, y = 1.15 },
		mesh                 = "lottarmor_character_old.b3d",
		view_range           = 20,
		makes_footstep_sound = true,
		walk_velocity        = wv,
		run_velocity         = rv,
		damage               = damg,
		armor                = arm,
		drops                = drops,
		light_resistant      = true,
		drawtype             = "front",
		water_damage         = 1,
		lava_damage          = 10,
		light_damage         = 0,
		attack_type          = "dogfight",
		follow               = "lottother:narya",
		animation            = {
			speed_normal = 15,
			speed_run    = 20,
			stand_start  = 0,
			stand_end    = 79,
			walk_start   = 168,
			walk_end     = 187,
			run_start    = 168,
			run_end      = 187,
			punch_start  = 189,
			punch_end    = 198,
		},
		sounds               = {
			war_cry = "mobs_die_yell",
			death   = "default_death",
			attack  = "mobs_slash_attack",
		},
		attacks_monsters     = true,
		on_rightclick        = function(self, clicker)
			lottmobs.guard(self, clicker, "default:goldblock")
		end,
		peaceful             = true,
		group_attack         = true,
		step                 = 1,
	})
end

function lottmobs.register_elf_archer(n, hpmin, hpmax, textures, wv, rv, damg, arm, drops)
	mobs:register_mob("lottmobs:elf_archer" .. n, {
		type                 = "npc",
		hp_min               = hpmin,
		hp_max               = hpmax,
		collisionbox         = { -0.3, -1.1, -0.3, 0.3, 0.91, 0.3 },
		textures             = textures,
		visual               = "mesh",
		visual_size          = { x = 0.95, y = 1.15 },
		mesh                 = "lottarmor_character_old.b3d",
		view_range           = 20,
		makes_footstep_sound = true,
		walk_velocity        = wv,
		run_velocity         = rv,
		damage               = damg,
		armor                = arm,
		drops                = drops,
		light_resistant      = true,
		drawtype             = "front",
		water_damage         = 1,
		lava_damage          = 10,
		light_damage         = 0,
		attack_type          = "dogshoot",
		dogshoot_switch      = 1,
		dogshoot_count_max   = 12, -- shoot for 10 seconds
		dogshoot_count2_max  = 3, -- dogfight for 3 seconds
		reach                = 3,
		shoot_interval       = 1.25,
		shoot_offset         = 0.75,
		arrow                = "lord_projectiles:steel_arrow",

		follow               = "lottother:narya",
		animation            = {
			speed_normal = 15,
			speed_run    = 20,
			stand_start  = 0,
			stand_end    = 79,
			walk_start   = 168,
			walk_end     = 187,
			run_start    = 168,
			run_end      = 187,
			punch_start  = 189,
			punch_end    = 198,
		},
		sounds               = {
			war_cry = "mobs_die_yell",
			death   = "default_death",
			attack  = "mobs_slash_attack",
		},
		attacks_monsters     = true,
		on_rightclick        = function(self, clicker)
			lottmobs.guard(self, clicker, "default:goldblock")
		end,
		peaceful             = true,
		group_attack         = true,
		step                 = 1,
	})
end

--Basic elves

local textures1 = {
    {"lottmobs_lorien_elf_1.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
    {"lottmobs_lorien_elf_2.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
    {"lottmobs_lorien_elf_3.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
}

local drops1 = {
	{ name = "lord_trees:mallorn_sapling",     chance = 5,   min = 1, max = 3, },
	{ name = "lord_planks:mallorn",        chance = 5,   min = 1, max = 6, },
	{ name = "lottores:silveringot",          chance = 20,  min = 1, max = 7 },
	{ name = "tools:sword_silver",            chance = 20,  min = 1, max = 1 },
	{ name = "lottarmor:helmet_silver",       chance = 30,  min = 1, max = 1 },
	{ name = "lottarmor:chestplate_silver",   chance = 30,  min = 1, max = 1 },
	{ name = "tools:spear_silver",            chance = 25,  min = 1, max = 1, },
	{ name = "lottores:blue_gem",             chance = 200, min = 1, max = 1, },
	{ name = "lord_trees:yavannamire_sapling", chance = 250, min = 1, max = 1, },
	{ name = "lottores:mithril_lump",         chance = 100, min = 1, max = 2, },
}

lottmobs.register_elf("", 20, 35, textures1, 2.5, 5, 4, 200, drops1)

--Elves in full armor

local textures2 = {
    {
		"lottmobs_lorien_elf_1.png",
		"lottarmor_chestplate_galvorn.png^" ..
			"lottarmor_leggings_galvorn.png^" ..
			"lottarmor_helmet_galvorn.png^" ..
			"lottarmor_boots_galvorn.png",
		"tools_sword_galvorn.png",
		"lottarmor_trans.png",
	},
    {
		"lottmobs_lorien_elf_2.png",
		"lottarmor_chestplate_steel.png^" ..
			"lottarmor_leggings_steel.png^" ..
			"lottarmor_helmet_steel.png^" ..
			"lottarmor_boots_steel.png^" ..
			"lottarmor_shield_steel.png",
		"tools_battleaxe_steel.png",
		"lottarmor_trans.png",
	},
    {
		"lottmobs_lorien_elf_3.png",
		"lottarmor_chestplate_silver.png^" ..
			"lottarmor_leggings_silver.png^" ..
			"lottarmor_helmet_silver.png^" ..
			"lottarmor_boots_silver.png^" ..
			"lottarmor_shield_silver.png",
		"tools_sword_silver.png",
		"lottarmor_trans.png",
	},
}

local drops2 = {
	{ name = "lord_trees:mallorn_sapling",     chance = 5,   min = 1, max = 3, },
	{ name = "lord_planks:mallorn",        chance = 5,   min = 1, max = 6, },
	{ name = "lottores:silveringot",          chance = 20,  min = 1, max = 7 },
	{ name = "tools:sword_silver",            chance = 20,  min = 1, max = 1 },
	{ name = "lottarmor:helmet_silver",       chance = 30,  min = 1, max = 1 },
	{ name = "lottarmor:chestplate_silver",   chance = 30,  min = 1, max = 1 },
	{ name = "tools:spear_silver",            chance = 25,  min = 1, max = 1, },
	{ name = "lottores:blue_gem",             chance = 200, min = 1, max = 1, },
	{ name = "lord_trees:yavannamire_sapling", chance = 250, min = 1, max = 1, },
	{ name = "lottores:mithril_lump",         chance = 100, min = 1, max = 2, },
}

lottmobs.register_elf(1, 20, 35, textures2, 2, 4.5, 6, 100, drops2)

--Evels with chestplates and powerfull weapons!

local textures3 = {
    {
		"lottmobs_lorien_elf_1.png",
		"lottarmor_chestplate_galvorn.png",
		"tools_sword_elven.png",
		"lottarmor_trans.png",
	},
    {
		"lottmobs_lorien_elf_2.png",
		"lottarmor_chestplate_gold.png^lottarmor_shield_gold.png",
		"tools_spear_gold.png",
		"lottarmor_trans.png",
	},
    {
		"lottmobs_lorien_elf_3.png",
		"lottarmor_shield_steel.png",
		"tools_warhammer_steel.png",
		"lottarmor_trans.png",
	},
}

local drops3 = {
	{ name = "lord_trees:mallorn_sapling",     chance = 5,   min = 1, max = 3, },
	{ name = "lord_planks:mallorn",        chance = 5,   min = 1, max = 6, },
	{ name = "lottores:silveringot",          chance = 20,  min = 1, max = 7 },
	{ name = "tools:sword_silver",            chance = 20,  min = 1, max = 1 },
	{ name = "lottarmor:helmet_silver",       chance = 30,  min = 1, max = 1 },
	{ name = "lottarmor:chestplate_silver",   chance = 30,  min = 1, max = 1 },
	{ name = "tools:spear_silver",            chance = 25,  min = 1, max = 1, },
	{ name = "lottores:blue_gem",             chance = 200, min = 1, max = 1, },
	{ name = "lord_trees:yavannamire_sapling", chance = 250, min = 1, max = 1, },
	{ name = "lottores:mithril_lump",         chance = 100, min = 1, max = 2, },
}

lottmobs.register_elf(2, 20, 35, textures3, 2.25, 4.75, 8, 150, drops3)

--Evels with chestplates and bow!

local textures4 = {
    {
		"lottmobs_lorien_elf_1.png",
		"lottarmor_chestplate_galvorn.png",
		"lord_archery_mallorn_wood_bow.png",
		"lottarmor_trans.png",
	},
    {
		"lottmobs_lorien_elf_2.png",
		"lottarmor_chestplate_gold.png^lottarmor_shield_gold.png",
		"lord_archery_mallorn_wood_bow.png",
		"lottarmor_trans.png",
	},
    {
		"lottmobs_lorien_elf_3.png",
		"lottarmor_shield_steel.png",
		"lord_archery_mallorn_wood_bow.png",
		"lottarmor_trans.png",
	},
}

local drops4 = {
	{ name = "lord_projectiles:steel_arrow",  chance = 30, min = 1, max = 10, },
	{ name = "lord_archery:mallorn_wood_bow", chance = 5,  min = 1, max = 1, },
	{ name = "lottores:silveringot",          chance = 20, min = 1, max = 7 },
	{ name = "lottarmor:chestplate_silver",   chance = 30, min = 1, max = 1 },
}

lottmobs.register_elf_archer("", 20, 35, textures4, 2.25, 4.75, 8, 150, drops4)
