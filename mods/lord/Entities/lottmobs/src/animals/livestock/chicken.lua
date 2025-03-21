local SL = minetest.get_mod_translator()

archery.register_throwable("lottmobs:egg", {
	definition = {
		description      = SL("Chicken Egg"),
		inventory_image  = "lottmobs_egg", -- without ".png"
		groups           = { throwable = 1 },
		wield_scale      = vector.new(1, 1, 0.5),
		--sound_on_release = "lord_archery_arrow_release",
		draw_power       = 0.5,
		just_an_item     = true,
	},
	stage_conf = {
		charging_time = {
			[0] = 0,
			[1] = 0.25,
			[2] = 0.5,
		},
	},
	projectile_reg = {
		type        = "throwable",
		damage_tt   = 1,
		entity_name = "lottmobs:egg",
		entity_reg  = {
			initial_properties = {
				visual    = "item",
				wield_item = "lottmobs:egg",
				visual_size = vector.new(0.25, 0.25, 0.25),
			},
			max_speed        = 20,
			--sound_hit_node   = { name = "lord_projectiles_explosion", gain = 3.0 },
			--sound_hit_object = { name = "lord_projectiles_explosion", gain = 3.0 },
			damage_groups    = { fleshy = 1, },
			rotation_formula = "rolling",
			on_hit_node      = function(projectile, node_pos, move_result)
				local spawn_chicken = math.random(1, 20) == 1
				if spawn_chicken then
					minetest.add_entity(projectile.object:get_pos(), "lottmobs:chicken")
				end
				local radius = 0.5
				local rad_vec = vector.new(radius, radius, radius)
				local min_pos = vector.subtract(node_pos, rad_vec)
				local max_pos = vector.add(node_pos, rad_vec)
				minetest.add_particlespawner({
					pos = {
						min = min_pos,
						max = max_pos,
					},
					time = 0.1,
					amount = 10,
					size = { min = 1, max = 3 },
					texture = {
						name = "lottmobs_egg.png",
						alpha_tween = { 1, 0 },
						scale = 1,
					},
					vel = {
						min = vector.new(-2, 3, -2),
						max = vector.new(2, 7, 2),
					},
					acc = {
						min = vector.new(-0, -9.81, -0),
						max = vector.new(0, -9.81, 0),
					},
					exptime = { min = 0.1, max = 2 },
				})
			end,
			after_hit_node   = function(projectile)
				projectile.object:remove()
			end
		}
	}
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
	follow = {"farming:seed_wheat", "lottother:beast_ring"},
	view_range = 5,
	jump = true,
	step=1,
	passive = true,
})
