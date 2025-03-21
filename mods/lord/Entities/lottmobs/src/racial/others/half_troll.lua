local api = require('fear_height.api')


mobs:register_mob("lottmobs:half_troll", {
	type = "monster",
	hp_min = 20,
	hp_max = 30,
	collisionbox = {-0.3,-1.0,-0.3, 0.3,0.8,0.3},
	visual = "mesh",
	mesh = "human_model.x",
	textures = {
		{"lottmobs_half_troll.png"},
	},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 3,
	damage = 4,
	armor = 100,
	drops = {
		{ name = "default:sword_steel",      chance = 10, min = 1, max = 1, },
		{ name = "default:sword_bronze",     chance = 10, min = 1, max = 1, },
		{ name = "lottores:coppersword",     chance = 10, min = 1, max = 5, },
		{ name = "lottores:tinsword",        chance = 10, min = 1, max = 5, },
		{ name = "lottores:goldsword",       chance = 10, min = 1, max = 1, },
		{ name = "lottfarming:potato",       chance = 10, min = 1, max = 2, },
		{ name = "lottfarming:turnip",       chance = 10, min = 1, max = 2, },
		{ name = "lottfarming:red_mushroom", chance = 7,  min = 1, max = 8, },
		{ name = "lord_alcohol:wine",        chance = 20, min = 1, max = 2, },
	},
	light_resistant = true,
	drawtype = "front",
	water_damage = 0,
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
		war_cry = "mobs_die_yell",
		death = "default_death",
		attack = "default_punch2",
	},
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
	do_custom = function (self)
		api.set_fear_height_by_state(self)
	end
})
