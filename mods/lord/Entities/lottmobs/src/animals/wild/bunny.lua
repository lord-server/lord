

mobs:register_mob("lottmobs:bunny", {
	type = "animal",
	passive = true,
	reach = 1,
	hp_min = 1,
	hp_max = 4,
	armor = 200,
	collisionbox = {-0.268, -0.5, -0.268,  0.268, 0.167, 0.268},
	visual = "mesh",
	mesh = "mobs_bunny.b3d",
	drawtype = "front",
	textures = {
		{"mobs_bunny_grey.png"},
		{"mobs_bunny_brown.png"},
		{"mobs_bunny_white.png"},
	},
	sounds = {},
	makes_footstep_sound = false,
	walk_velocity = 1,
	run_velocity = 2,
	runaway = true,
	jump = true,
	drops = {
		{ name = "lottmobs:rabbit_raw", chance = 1, min = 1, max = 1 },
	},
	water_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		stand_start = 1,
		stand_end = 15,
		walk_start = 16,
		walk_end = 24,
		punch_start = 16,
		punch_end = 24,
	},
	follow = {"lottfarming:carrot_item", "lottother:beast_ring"},
	view_range = 8,
	replace_rate = 1,
	replace_what = { {"lottfarming:carrot", "air", 0}, {"lottfarming:cabbage_1", "air", 0}}
})
