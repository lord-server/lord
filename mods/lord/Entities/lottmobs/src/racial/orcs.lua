local orc_armor = "lottarmor_chestplate_steel.png^" ..
	"lottarmor_leggings_steel.png^" ..
	"lottarmor_helmet_steel.png^" ..
	"lottarmor_boots_steel.png^" ..
	"lottarmor_shield_steel.png^" ..
	"[colorize:#00000055"

mobs:register_mob("lottmobs:orc", {
	type = "monster",
	hp_min = 15,
	hp_max = 35,
	collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
	visual = "mesh",
	mesh = "lottarmor_character_old.b3d",
	textures = {
		{"lottmobs_orc.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
		{"lottmobs_orc.png", orc_armor, "tools_sword_orc.png", "lottarmor_trans.png"},
		{"lottmobs_orc.png", orc_armor, "tools_sword_orc.png", "lottclothes_cloak_mordor.png"},
		{"lottmobs_orc_1.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
		{"lottmobs_orc_1.png", orc_armor, "tools_sword_orc.png", "lottarmor_trans.png"},
		{"lottmobs_orc_1.png", orc_armor, "tools_sword_orc.png", "lottclothes_cloak_mordor.png"},
		{"lottmobs_orc_2.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
		{"lottmobs_orc_2.png", orc_armor, "tools_sword_orc.png", "lottarmor_trans.png"},
		{"lottmobs_orc_2.png", orc_armor, "tools_sword_orc.png", "lottclothes_cloak_mordor.png"},
	},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1.5,
	armor = 200,
	run_velocity = 3,
	damage = 2,
	drops = {
		{ name = "bones:bone",               chance = 5,  min = 1, max = 2, },
		{ name = "lottmobs:rotten_meat",     chance = 7,  min = 1, max = 3, },
		{ name = "lottfarming:orc_food",     chance = 17, min = 1, max = 3, },
		{ name = "lottfarming:orc_medicine", chance = 17, min = 1, max = 3, },
		{ name = "lottfarming:potato",       chance = 14, min = 1, max = 2, },
		{ name = "lottfarming:turnip",       chance = 14, min = 1, max = 2, },
		{ name = "lottfarming:red_mushroom", chance = 10, min = 1, max = 8, },
		{ name = "lottclothes:cloak_mordor", chance = 17, min = 1, max = 1, },
		{ name = "lord_alcohol:wine",          chance = 26, min = 1, max = 2, },
	},
	light_resistant = true,
	drawtype = "front",
	water_damage = 5,
	lava_damage = 10,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	},
	jump = true,
	sounds = {
		war_cry = "mobs_barbarian_yell1",
		death = "mobs_death1",
		attack = "default_punch2",
	},
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
})

mobs:register_mob("lottmobs:orc_crossbowman", {
	type = "monster",
	hp_min = 15,
	hp_max = 35,
	collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
	visual = "mesh",
	mesh = "lottarmor_character_old.b3d",
	textures = {
		{"lottmobs_orc.png", "lottarmor_trans.png", "lord_archery_steel_crossbow.png", "lottarmor_trans.png"},
		{"lottmobs_orc.png", orc_armor, "lord_archery_steel_crossbow.png", "lottarmor_trans.png"},
		{"lottmobs_orc.png", orc_armor, "lord_archery_steel_crossbow.png", "lottclothes_cloak_mordor.png"},
		{"lottmobs_orc_1.png", "lottarmor_trans.png", "lord_archery_steel_crossbow.png", "lottarmor_trans.png"},
		{"lottmobs_orc_1.png", orc_armor, "lord_archery_steel_crossbow.png", "lottarmor_trans.png"},
		{"lottmobs_orc_1.png", orc_armor, "lord_archery_steel_crossbow.png", "lottclothes_cloak_mordor.png"},
		{"lottmobs_orc_2.png", "lottarmor_trans.png", "lord_archery_steel_crossbow.png", "lottarmor_trans.png"},
		{"lottmobs_orc_2.png", orc_armor, "lord_archery_steel_crossbow.png", "lottarmor_trans.png"},
		{"lottmobs_orc_2.png", orc_armor, "lord_archery_steel_crossbow.png", "lottclothes_cloak_mordor.png"},
	},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1.5,
	armor = 200,
	run_velocity = 3,
	damage = 2,
	drops = {
		{ name = "bones:bone",               chance = 5,  min = 1, max = 2, },
		{ name = "lottmobs:rotten_meat",     chance = 7,  min = 1, max = 3, },
		{ name = "lottfarming:orc_food",     chance = 17, min = 1, max = 3, },
		{ name = "lottfarming:orc_medicine", chance = 17, min = 1, max = 3, },
		{ name = "lottfarming:potato",       chance = 14, min = 1, max = 2, },
		{ name = "lottfarming:turnip",       chance = 14, min = 1, max = 2, },
		{ name = "lottfarming:red_mushroom", chance = 10, min = 1, max = 8, },
		{ name = "lottclothes:cloak_mordor", chance = 17, min = 1, max = 1, },
		{ name = "lord_alcohol:wine",          chance = 26, min = 1, max = 2, },
	},
	light_resistant = true,
	drawtype = "front",
	water_damage = 5,
	lava_damage = 10,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "dogshoot",
	dogshoot_switch = 1,
	dogshoot_count_max = 21, -- shoot for 21 seconds - 2 bolts
	dogshoot_count2_max = 5, -- dogfight for 5 seconds
	reach = 3,
	shoot_interval = 10,
	shoot_offset = 0.75,
	arrow = "lord_projectiles:steel_bolt",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	},
	jump = true,
	sounds = {
		war_cry = "mobs_barbarian_yell1",
		death = "mobs_death1",
		attack = "default_punch2",
	},
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
})

mobs:register_mob("lottmobs:orc_archer", {
	type = "monster",
	hp_min = 15,
	hp_max = 35,
	collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
	visual = "mesh",
	mesh = "lottarmor_character_old.b3d",
	textures = {
		{"lottmobs_orc.png", "lottarmor_trans.png", "lord_archery_apple_wood_bow.png", "lottarmor_trans.png"},
		{"lottmobs_orc.png", orc_armor, "lord_archery_apple_wood_bow.png", "lottarmor_trans.png"},
		{"lottmobs_orc.png", orc_armor, "lord_archery_apple_wood_bow.png", "lottclothes_cloak_mordor.png"},
		{"lottmobs_orc_1.png", "lottarmor_trans.png", "lord_archery_apple_wood_bow.png", "lottarmor_trans.png"},
		{"lottmobs_orc_1.png", orc_armor, "lord_archery_apple_wood_bow.png", "lottarmor_trans.png"},
		{"lottmobs_orc_1.png", orc_armor, "lord_archery_apple_wood_bow.png", "lottclothes_cloak_mordor.png"},
		{"lottmobs_orc_2.png", "lottarmor_trans.png", "lord_archery_apple_wood_bow.png", "lottarmor_trans.png"},
		{"lottmobs_orc_2.png", orc_armor, "lord_archery_apple_wood_bow.png", "lottarmor_trans.png"},
		{"lottmobs_orc_2.png", orc_armor, "lord_archery_apple_wood_bow.png", "lottclothes_cloak_mordor.png"},
	},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1.5,
	armor = 200,
	run_velocity = 3,
	damage = 2,
	drops = {
		{ name = "bones:bone",               chance = 5,  min = 1, max = 2, },
		{ name = "lottmobs:rotten_meat",     chance = 7,  min = 1, max = 3, },
		{ name = "lottfarming:orc_food",     chance = 17, min = 1, max = 3, },
		{ name = "lottfarming:orc_medicine", chance = 17, min = 1, max = 3, },
		{ name = "lottfarming:potato",       chance = 14, min = 1, max = 2, },
		{ name = "lottfarming:turnip",       chance = 14, min = 1, max = 2, },
		{ name = "lottfarming:red_mushroom", chance = 10, min = 1, max = 8, },
		{ name = "lottclothes:cloak_mordor", chance = 17, min = 1, max = 1, },
		{ name = "lord_alcohol:wine",          chance = 26, min = 1, max = 2, },
	},
	light_resistant = true,
	drawtype = "front",
	water_damage = 5,
	lava_damage = 10,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "dogshoot",
	dogshoot_switch = 1,
	dogshoot_count_max = 12, -- shoot for 10 seconds
	dogshoot_count2_max = 3, -- dogfight for 3 seconds
	reach = 3,
	shoot_interval = 2.5,
	shoot_offset = 0.75,
	arrow = "lord_projectiles:steel_arrow",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	},
	jump = true,
	sounds = {
		war_cry = "mobs_barbarian_yell1",
		death = "mobs_death1",
		attack = "default_punch2",
	},
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
})

mobs:register_mob("lottmobs:raiding_orc", {
	type = "monster",
	hp_min = 15,
	hp_max = 35,
	collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
	visual = "mesh",
	mesh = "lottarmor_character_old.b3d",
	textures = {
		{"lottmobs_orc.png",   orc_armor, "tools_sword_orc.png", "lottarmor_trans.png"},
		{"lottmobs_orc_1.png", orc_armor, "tools_sword_orc.png", "lottarmor_trans.png"},
		{"lottmobs_orc_2.png", orc_armor, "tools_sword_orc.png", "lottarmor_trans.png"},
	},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	armor = 200,
	run_velocity = 3,
	damage = 3,
	drops = {
		{ name = "default:sword_steel",        chance = 5,  min = 1, max = 1, },
		{ name = "lottarmor:helmet_steel",     chance = 12, min = 1, max = 1, },
		{ name = "lottarmor:chestplate_steel", chance = 12, min = 1, max = 1, },
		{ name = "lottarmor:leggings_steel",   chance = 12, min = 1, max = 1, },
		{ name = "lottarmor:boots_steel",      chance = 12, min = 1, max = 1, },
		{ name = "lottarmor:shield_steel",     chance = 12, min = 1, max = 1, },
		{ name = "lottmobs:rotten_meat",       chance = 5,  min = 1, max = 3, },
		{ name = "lottfarming:orc_food",       chance = 15, min = 1, max = 3, },
		{ name = "farming:bread",              chance = 5,  min = 1, max = 3, },
		{ name = "lord_alcohol:wine",            chance = 20, min = 1, max = 5, },
		{ name = "lottfarming:potato",         chance = 5,  min = 1, max = 5, },
	},
	light_resistant = true,
	drawtype = "front",
	water_damage = 5,
	lava_damage = 10,
	light_damage = 2,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	},
	jump = true,
	sounds = {
		war_cry = "mobs_barbarian_yell1",
		death = "mobs_death1",
		attack = "default_punch2",
	},
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
})

mobs:register_mob("lottmobs:uruk_hai", {
	type = "monster",
	hp_min = 25,
	hp_max = 40,
	collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
	visual = "mesh",
	mesh = "human_model.x",
	textures = {
		{"lottmobs_uruk_hai.png"},
		{"lottmobs_uruk_hai_1.png"},
		{"lottmobs_uruk_hai_2.png"},
		{"lottmobs_uruk_hai_3.png"},
	},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	armor = 100,
	run_velocity = 3,
	damage = 4,
	drops = {
		{ name = "default:bronze_sword",         chance = 10, min = 1, max = 1, },
		{ name = "lottarmor:helmet_bronze",      chance = 20, min = 1, max = 1, },
		{ name = "lottarmor:chestplate_bronze",  chance = 20, min = 1, max = 1, },
		{ name = "lottarmor:leggings_bronze",    chance = 20, min = 1, max = 1, },
		{ name = "lottarmor:boots_bronze",       chance = 10, min = 1, max = 1, },
		{ name = "lottweapons:bronze_warhammer", chance = 15, min = 1, max = 1, },
		{ name = "lottweapons:bronze_battleaxe", chance = 15, min = 1, max = 1, },
		{ name = "lottweapons:bronze_spear",     chance = 15, min = 1, max = 1, },
		{ name = "lottfarming:potato",           chance = 5,  min = 1, max = 5, },
		{ name = "lottmobs:rotten_meat",         chance = 5,  min = 1, max = 3, },
	},
	light_resistant = true,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	},
	jump = true,
	sounds = {
		war_cry = "mobs_barbarian_yell2",
		death = "mobs_death2",
		attack = "mobs_slash_attack",
	},
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
})
