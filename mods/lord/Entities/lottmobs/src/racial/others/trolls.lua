local api = require('fear_height.api')


mobs:register_mob("lottmobs:battle_troll", {
	type = "monster",
	hp_min = 45,
	hp_max = 60,
	collisionbox = {-0.7, -0.01, -0.7, 0.7, 2.6, 0.7},
	visual = "mesh",
	mesh = "troll_model.x",
	textures = {
		{"lottmobs_battle_troll.png"},
	},
	visual_size = {x=8, y=8},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 1,
	damage = 6,
	drops = {
		{ name = "bones:bone",                   chance = 5,  min = 1, max = 5, },
		{ name = "lottmobs:rotten_meat",         chance = 5,  min = 1, max = 5, },
		{ name = "lottweapons:steel_warhammer",  chance = 10, min = 1, max = 1, },
		{ name = "lottweapons:bronze_warhammer", chance = 10, min = 1, max = 5, },
		{ name = "lottweapons:silver_warhammer", chance = 10, min = 1, max = 5, },
		{ name = "lottweapons:tin_warhammer",    chance = 10, min = 1, max = 5, },
		{ name = "lottweapons:copper_warhammer", chance = 10, min = 1, max = 5, },
	},
	light_resistant = true,
	armor = 100,
	drawtype = "front",
	water_damage = 5,
	lava_damage = 1,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		stand_start = 0,
		stand_end = 19,
		walk_start = 20,
		walk_end = 35,
		punch_start = 36,
		punch_end = 48,
		speed_normal = 15,
		speed_run = 15,
	},
	jump = true,
	sounds = {
		war_cry = "mobs_howl",
		death = "mobs_howl",
		attack = "mobs_stone_death",
	},
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
})


mobs:register_mob("lottmobs:troll", {
	type = "monster",
	hp_min = 50,
	hp_max = 65,
	collisionbox = {-0.7, -0.01, -0.7, 0.7, 2.6, 0.7},
	visual = "mesh",
	mesh = "troll_model.x",
	textures = {
		{"lottmobs_troll.png"},
		{"lottmobs_troll_1.png"},
		{"lottmobs_troll_2.png"},
		{"lottmobs_troll_3.png"},
	},
	visual_size = {x=8, y=8},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 1,
	damage = 10,
	armor = 100,
	drops = {
		{ name = "default:stone",                chance = 5,  min = 1, max = 7, },
		{ name = "default:stone_with_coal",      chance = 15, min = 1, max = 4, },
		{ name = "lottweapons:steel_battleaxe",  chance = 10, min = 1, max = 1, },
		{ name = "lottweapons:steel_warhammer",  chance = 10, min = 1, max = 1, },
		{ name = "lottweapons:bronze_battleaxe", chance = 10, min = 1, max = 1, },
		{ name = "lottweapons:bronze_warhammer", chance = 10, min = 1, max = 1, },
		{ name = "lottweapons:tin_battleaxe",    chance = 10, min = 1, max = 1, },
		{ name = "lottweapons:tin_warhammer",    chance = 10, min = 1, max = 1, },
		{ name = "lottweapons:copper_battleaxe", chance = 10, min = 1, max = 1, },
		{ name = "lottweapons:copper_warhammer", chance = 10, min = 1, max = 1, },
		{ name = "lottweapons:silver_battleaxe", chance = 10, min = 1, max = 1, },
		{ name = "lottweapons:silver_warhammer", chance = 10, min = 1, max = 1, },
	},
	drawtype = "front",
	water_damage = 0,
	lava_damage = 0,
	light_damage = 60,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		stand_start = 0,
		stand_end = 19,
		walk_start = 20,
		walk_end = 35,
		punch_start = 36,
		punch_end = 48,
		speed_normal = 15,
		speed_run = 15,
	},
	jump = true,
	sounds = {
		war_cry = "mobs_die_yell",
		death = "default_death",
		attack = "default_punch2",
	},
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
    do_custom = function(self)
        api.set_fear_height_by_state(self)
    end
})
