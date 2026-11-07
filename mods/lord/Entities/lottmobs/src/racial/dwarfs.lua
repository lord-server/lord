local api = require('fear_height.api')


function lottmobs.register_dwarf(n, hpmin, hpmax, textures, wv, rv, damg, arm, drops)
	legacy_mobs:register_mob("lottmobs:dwarf" .. n, {
		type                 = "npc",
		hp_min               = hpmin,
		hp_max               = hpmax,
		collisionbox         = { -0.375, -0.85, -0.375, 0.375, 0.68, 0.375 },
		textures             = textures,
		visual               = "mesh",
		visual_size          = { x = 1.0625, y = 0.85 },
		mesh                 = "lottarmor_character_old.b3d",
		view_range           = 12,
		makes_footstep_sound = true,
		walk_velocity        = wv,
		run_velocity         = rv,
		armor                = arm,
		damage               = damg,
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
		jump                 = true,
		sounds               = {
			war_cry = "mobs_die_yell",
			death   = "default_death",
			attack  = "default_punch2",
		},
		attacks_monsters     = true,
		on_rightclick        = function(self, clicker)
			lottmobs.guard(self, clicker, "default:goldblock")
		end,
		peaceful             = true,
		group_attack         = true,
		step                 = 1,
		do_custom = function (self)
			api.set_fear_height_by_state(self)
		end
	})
end

--Normal Dwarfs
local textures1 = {
    {
		"lottmobs_dwarf_1.png", "lottarmor_trans.png",
		"lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"
	},
    {
		"lottmobs_dwarf_2.png", "lottarmor_trans.png",
		"lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
    {
		"lottmobs_dwarf_3.png", "lottarmor_trans.png",
		"lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"
	},
}

local drops1 = {
	{ name = "default:diamond",       chance = 30, min = 1, max = 2, },
	{ name = "default:iron_lump",     chance = 3,  min = 1, max = 7, },
	{ name = "default:copper_lump",   chance = 4,  min = 1, max = 4, },
	{ name = "default:iron_ingot",    chance = 3,  min = 1, max = 7, },
	{ name = "lottores:tin_lump",     chance = 8,  min = 1, max = 2, },
	{ name = "default:copper_lump",   chance = 8,  min = 1, max = 2, },
	{ name = "default:bronze_ingot",  chance = 5,  min = 1, max = 6, },
	{ name = "lottores:mithril_lump", chance = 50, min = 1, max = 3, },
}

lottmobs.register_dwarf("", 20, 30, textures1, 2, 4, 5, { soul = 100, fleshy = 175 }, drops1)

--Dwarfs with gold armor & warhammers. (mithril look is reserved for `dwarf_king`, see below)
local textures2 = {
    {
		"lottmobs_dwarf_1.png",
		"lottarmor_helmet_gold.png^" ..
			"lottarmor_chestplate_gold.png^" ..
			"lottarmor_leggings_gold.png^" ..
			"lottarmor_boots_gold.png^" ..
			"lottarmor_shield_gold.png",
		"tools_warhammer_gold.png",
		"lottarmor_trans.png",
	},
    {
		"lottmobs_dwarf_2.png",
		"lottarmor_helmet_gold.png^" ..
			"lottarmor_chestplate_gold.png^" ..
			"lottarmor_leggings_gold.png^" ..
			"lottarmor_boots_gold.png^" ..
			"lottarmor_shield_gold.png",
		"tools_warhammer_gold.png",
		"lottarmor_trans.png",
	},
    {
		"lottmobs_dwarf_3.png",
		"lottarmor_helmet_gold.png^" ..
			"lottarmor_chestplate_gold.png^" ..
			"lottarmor_leggings_gold.png^" ..
			"lottarmor_boots_gold.png^" ..
			"lottarmor_shield_gold.png",
		"tools_warhammer_gold.png",
		"lottarmor_trans.png",
	},
}

local drops2 = {
	{ name = "default:obsidian",      chance = 70, min = 1, max = 1, },
	{ name = "default:diamond",       chance = 30, min = 1, max = 2, },
	{ name = "default:iron_lump",     chance = 3,  min = 1, max = 7, },
	{ name = "default:copper_lump",   chance = 4,  min = 1, max = 4, },
	{ name = "default:iron_ingot",    chance = 3,  min = 1, max = 7, },
	{ name = "lottores:tin_lump",     chance = 8,  min = 1, max = 2, },
	{ name = "default:copper_lump",   chance = 8,  min = 1, max = 2, },
	{ name = "default:bronze_ingot",  chance = 5,  min = 1, max = 6, },
	{ name = "lottores:mithril_lump", chance = 50, min = 1, max = 3, },
}

lottmobs.register_dwarf("1", 30, 40, textures2, 2.75, 3.5, 13, { soul = 100, fleshy = 75 }, drops2)

--Dwarfs with steel armor & swords.
local textures3 = {
    {
		"lottmobs_dwarf_1.png",
		"lottarmor_helmet_steel.png^" ..
			"lottarmor_chestplate_steel.png^" ..
			"lottarmor_leggings_steel.png^" ..
			"lottarmor_boots_steel.png^" ..
			"lottarmor_shield_steel.png",
		"tools_sword_steel.png",
		"lottarmor_trans.png",
	},
    {
		"lottmobs_dwarf_2.png",
		"lottarmor_helmet_steel.png^" ..
			"lottarmor_chestplate_steel.png^" ..
			"lottarmor_leggings_steel.png^" ..
			"lottarmor_boots_steel.png^" ..
			"lottarmor_shield_steel.png",
		"tools_sword_steel.png",
		"lottarmor_trans.png",
	},
    {
		"lottmobs_dwarf_3.png",
		"lottarmor_helmet_steel.png^" ..
			"lottarmor_chestplate_steel.png^" ..
			"lottarmor_leggings_steel.png^" ..
			"lottarmor_boots_steel.png^" ..
			"lottarmor_shield_steel.png",
		"tools_sword_steel.png",
		"lottarmor_trans.png",
	},
}

local drops3 = {
	{ name = "default:diamond",       chance = 30, min = 1, max = 2, },
	{ name = "default:iron_lump",     chance = 3,  min = 1, max = 7, },
	{ name = "default:copper_lump",   chance = 4,  min = 1, max = 4, },
	{ name = "default:iron_ingot",    chance = 3,  min = 1, max = 7, },
	{ name = "lottores:tin_lump",     chance = 8,  min = 1, max = 2, },
	{ name = "default:copper_lump",   chance = 8,  min = 1, max = 2, },
	{ name = "default:bronze_ingot",  chance = 5,  min = 1, max = 6, },
	{ name = "lottores:mithril_lump", chance = 50, min = 1, max = 3, },
}

lottmobs.register_dwarf("2", 25, 25, textures3, 2.5, 3.5, 7, { soul = 100, fleshy = 100 }, drops3)


-- --------------------
--        King
-- --------------------

--Mithril-armored look, reserved for `dwarf_king` (see below).
local king_textures = {
    {
		"lottmobs_dwarf_1.png",
		"lottarmor_helmet_mithril.png^" ..
			"lottarmor_chestplate_mithril.png^" ..
			"lottarmor_leggings_mithril.png^" ..
			"lottarmor_boots_mithril.png^" ..
			"lottarmor_shield_mithril.png",
		"tools_warhammer_mithril.png",
		"lottarmor_trans.png",
	},
    {
		"lottmobs_dwarf_2.png",
		"lottarmor_helmet_mithril.png^" ..
			"lottarmor_chestplate_mithril.png^" ..
			"lottarmor_leggings_mithril.png^" ..
			"lottarmor_boots_mithril.png^" ..
			"lottarmor_shield_mithril.png",
		"tools_warhammer_mithril.png",
		"lottarmor_trans.png",
	},
    {
		"lottmobs_dwarf_3.png",
		"lottarmor_helmet_mithril.png^" ..
			"lottarmor_chestplate_mithril.png^" ..
			"lottarmor_leggings_mithril.png^" ..
			"lottarmor_boots_mithril.png^" ..
			"lottarmor_shield_mithril.png",
		"tools_warhammer_mithril.png",
		"lottarmor_trans.png",
	},
}

-- A bigger, tougher dwarf carrying the Hearth of Khazad-dûm (Smelter level 3 upgrade ingredient).
-- Based on the mithril-armored dwarf (toughest existing variant), deeper and rarer than the
-- Uruk-hai captain (Crucible) — this is the mid-boss, captain is the mini-boss.
legacy_mobs:register_mob(":lord_mobs:dwarf_king", {
	type                 = "npc", -- faction "npc": friendly to dwarves/humans/elves/hobbits, hostile to orcs
	specific_attack      = { "player" }, -- plus force-attack non-orc-race players too
	hp_min               = 60,
	hp_max               = 75,
	collisionbox         = { -0.45, -1.02, -0.45, 0.45, 0.816, 0.45 },
	textures             = king_textures,
	visual               = "mesh",
	vnsisual_size          = { x = 1.3, y = 1.2 },
	mesh                 = "lottarmor_character_old.b3d",
	view_range           = 20,
	makes_footstep_sound = true,
	walk_velocity        = 2,
	run_velocity         = 5,
	armor                = { soul = 75, fleshy = 65 },
	damage               = 10,
	drops                = {
		{ name = "lord_smelter:hearth",     chance = 100/60, min = 1, max = 1, },
		{ name = "lottores:mithril_lump",   chance = 100/20, min = 2, max = 3, },
		{ name = "lord_money:diamond_coin", chance = 100/20, min = 1, max = 1, },
		{ name = "lord_money:gold_coin",    chance = 100/40, min = 2, max = 5, },
		{ name = "lord_money:silver_coin",  chance = 100/60, min = 5, max = 9, },
	},
	light_resistant      = true,
	drawtype             = "front",
	water_damage         = 1,
	lava_damage          = 10,
	light_damage         = 0,
	on_rightclick        = nil,
	attack_type          = "dogfight",
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
	jump                 = true,
	sounds               = {
		war_cry = "mobs_die_yell",
		death   = "default_death",
		attack  = "default_punch2",
	},
	attacks_monsters     = true,
	peaceful             = true,
	group_attack         = true,
	step                 = 1,
	do_custom = function (self)
		api.set_fear_height_by_state(self)
	end
})
