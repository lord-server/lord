

mobs:register_mob("lottmobs:dead_men", {
	type = "monster",
	hp_min = 15,
	hp_max = 15,
	collisionbox = {-0.3,-1.15,-0.3, 0.3,0.8,0.3}, -- немного над землёй для эффекта левитирования (y1 == -1.15)
	visual = "mesh",
	mesh = "human_model.x",
	textures = {
		{"lottmobs_dead_men.png^[opacity:100"},
	},
	use_texture_alpha = true,
	makes_footstep_sound = false,
	view_range = 10,
	walk_velocity = 1,
	run_velocity = 4,
	damage = 8,
	damage_type = damage.Type.SOUL,
	armor = {soul = 100, immortal = 1},
	water_damage = 0,
	lava_damage = 0,
	light_damage = 1,
	drawtype = "front",
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		run_speed = 10, -- немного медленнее, чем ходьба(15), для эффекта левитирования
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
	drops = {
		-- money
		{ name = "lord_money:diamond_coin", chance = 100/1 , min = 1, max =  1, }, -- 1%
		{ name = "lord_money:gold_coin",    chance = 100/10, min = 1, max =  2, }, -- 10%
		{ name = "lord_money:silver_coin",  chance = 100/15, min = 1, max =  4, },
		{ name = "lord_money:copper_coin",  chance = 100/25, min = 1, max = 10, },
		-- gems
		{ name = "default:diamond",         chance = 100/20, min = 1, max = 1, },
		{ name = "default:mese_crystal",    chance = 100/16, min = 1, max = 1, },
		{ name = "lottores:white_gem",      chance = 100/2 , min = 1, max = 1, },
		{ name = "lottores:blue_gem",       chance = 100/2 , min = 1, max = 1, },
		{ name = "lottores:red_gem",        chance = 100/2 , min = 1, max = 1, },
	},
})
