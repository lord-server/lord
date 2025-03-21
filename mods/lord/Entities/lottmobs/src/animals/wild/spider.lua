local api = require('fear_height.api')


mobs:register_mob("lottmobs:spider", {
	type = "monster",
	hp_min = 20,
	hp_max = 40,
	collisionbox = {-0.9, -0.01, -0.7, 0.7, 0.6, 0.7},
	textures = {
		{"lottmobs_spider.png"},
		{"lottmobs_spider_1.png"},
		{"lottmobs_spider_2.png"},
	},
	visual_size = {x=7,y=7},
	visual = "mesh",
	mesh = "spider_model.x",
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 3,
	armor = 200,
	damage = 3,
	drops = {
		{ name = "farming:string",        chance = 3,  min = 1, max = 6, },
		{ name = "lottmobs:spiderpoison", chance = 7,  min = 1, max = 5, },
		{ name = "wool:white",            chance = 10, min = 1, max = 3, },
		{ name = "lottmobs:meat_raw",     chance = 5,  min = 1, max = 2, },
	},
	light_resistant = true,
	drawtype = "front",
	water_damage = 5,
	lava_damage = 5,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 1,
		stand_end = 1,
		walk_start = 20,
		walk_end = 40,
		run_start = 20,
		run_end = 40,
		punch_start = 50,
		punch_end = 90,
	},
	jump = true,
	sounds = {
		war_cry = "mobs_spider",
		death = "mobs_howl",
		attack = "mobs_oerkki_attack",
	},
	step = 1,
	do_custom = function (self)
		api.set_fear_height_by_state(self)
	end
})
--mobs:register_spawn("lottmobs:spider", {"lord_ground:dirt_mirkwood"}, 20, -10, 6000, 3, 31000)
