local SL = minetest.get_translator("lottmobs")


-- egg throwing item
local EGG_MASS = 0.1
local EGG_VELOCITY = 10
local EGG_DC = 0.5
local EGG_KFR = 0.01

arrows:register_throwing_weapon("lottmobs:egg", {
	arrow = {
		visual = "sprite",
		visual_size = {x=.5, y=.5},
		texture = "lottmobs_egg.png",
		velocity = EGG_VELOCITY,
		mass = EGG_MASS,
		kfr = EGG_KFR,
		damage_coefficient = EGG_DC,
		drop = false,

		hit_node = function(self, pos, node_name)
			if math.random(1, 10) > 1 then
				return
			end

			pos.y = pos.y + 1
			local node = minetest.get_node_or_nil(pos)
			if not node then
				return
			end
			local node_def = minetest.registered_nodes[node.name]
			if not node_def or node_def.walkable then
				return
			end

			minetest.add_entity(pos, "lottmobs:chicken")
		end,
	},
	craftitem = {
		shoot_sound = {
			sound = "default_place_node_hard",
			distance = 5,
		},

		description = SL("Chicken Egg"),
		inventory_image = "lottmobs_egg.png",
	},
})

mobs:register_mob("lottmobs:chicken", {
	type = "animal",
	hp_min = 5,
	hp_max = 10,
	collisionbox = {-0.3,0,-0.3, 0.3,0.8,0.3},
	textures = {
		{"lottmobs_chicken.png"},
	},
	sounds = {
		random = "mobs_chicken",
	},
	visual = "mesh",
	mesh = "chicken_model.x",
	visual_size = {x=1.5, y=1.5, z=1.5,},
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 300,
	drops = {
		{ name = "lottmobs:chicken_raw", chance = 1, min = 0, max = 1, },
		{ name = "lottmobs:egg",         chance = 1, min = 0, max = 1, },
	},
	light_resistant = true,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 10,
	light_damage = 0,
	animation = {
		speed_normal = 10,
		speed_run = 15,
		stand_start = 0,
		stand_end = 0,
		sit_start = 1,
		sit_end = 9,
		walk_start = 10,
		walk_end = 50,
	},
	follow = {"farming:wheat0", "lottother:beast_ring"},
	view_range = 5,
	jump = true,
	step=1,
	passive = true,
})
