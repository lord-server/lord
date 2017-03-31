local SL = lord.require_intllib()

lottmobs:register_horse("lottmobs:boar_mount", {
	description = SL("Boar"),
	inventory_image = "lottmobs_boar.png",
	}, {
	riders = {"dwarf"},
	physical = true,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	stepheight = 1.1,
--	attach_height = -120,
	offset = true,
	offset_h = 2,
	attach_h = 14,
--	attach_r = 10,
	reach = 2,
	run = true,
	hp = 40,
	dps = 8,
	aggressive = true,
	mesh = "mobs_boar_mount.x",
	textures = {"mobs_pumba.png"},
	animation = {
		speed_normal = 15,
		stand_start = 25,
		stand_end = 55,
		walk_start = 70,
		walk_end = 100,
		punch_start = 70,
		punch_end = 100,
	},
	max_speed = 7,
	forward_boost = 1.67,
	jump_boost = 5,
})
----------------

mobs:register_mob("lottmobs:boar", {
	type = "animal",
--	type = "monster",
--	race = "GAMEorc",
	passive = false,
	attack_type = "dogfight",
	group_attack = true,
	reach = 2,
	damage = 2,
	hp_min = 5,
	hp_max = 15,
	armor = 200,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	visual_size = {x = 1.26, y = 1.26},
	mesh = "mobs_boar.x",
	textures = {
		{"mobs_pumba.png"},
	},
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_pig",
		attack = "mobs_pig_angry",
	},
	walk_velocity = 2,
	run_velocity = 3,
	jump = true,
	follow = {"default:apple", "farming:potato"},
	view_range = 10,
	drops = {
		{name = "lottmobs:pork_raw", chance = 1, min = 1, max = 3},
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 2,
	animation = {
		speed_normal = 15,
		stand_start = 25,
		stand_end = 55,
		walk_start = 70,
		walk_end = 100,
		punch_start = 70,
		punch_end = 100,
	},
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "default:apple" then
        	minetest.add_entity(self.object:getpos(), "lottmobs:boar_mount")
        	if not minetest.setting_getbool("creative_mode") then
				item:take_item()
        		clicker:set_wielded_item(item)
        	end
		self.object:remove()
		end
	end,
})
--mobs:register_spawn("lottmobs:warg", {"lottmapgen:mordor_stone"}, 20, -1, 5000, 3, 31000)
--mobs:register_spawn("lottmobs:warg", {"default:snowblock"}, 15, -1, 7500, 3, 31000)
--mobs:register_spawn("lottmobs:warg", {"lottmapgen:angsnowblock"}, 20, -1, 5000, 5, 31000)

minetest.register_craftitem("lottmobs:pork_raw", {
	description = SL("Raw Porkchop"),
	inventory_image = "mobs_pork_raw.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craftitem("lottmobs:pork_cooked", {
	description = SL("Cooked Porkchop"),
	inventory_image = "mobs_pork_cooked.png",
	on_use = minetest.item_eat(8),
})

minetest.register_craft({
	type = "cooking",
	output = "lottmobs:pork_cooked",
	recipe = "lottmobs:pork_raw",
	cooktime = 5,
})
