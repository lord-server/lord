local SL = lord.require_intllib()

-- Kitten by Jordach / BFD

mobs:register_mob("lottmobs:kitten", {
	stepheight = 0.6,
	type = "animal",
	specific_attack = {"lottmobs:rat"},
	damage = 1,
	attack_type = "dogfight",
	attack_animals = true, -- so it can attack rats
	attack_players = false,
	reach = 1,
	passive = false,
	hp_min = 5,
	hp_max = 10,
	armor = 200,
	collisionbox = {-0.3, -0.3, -0.3, 0.3, 0.1, 0.3},
	visual = "mesh",
	visual_size = {x = 0.5, y = 0.5},
	mesh = "mobs_kitten.b3d",
	textures = {
		{"mobs_kitten_striped.png"},
		{"mobs_kitten_splotchy.png"},
		{"mobs_kitten_ginger.png"},
		{"mobs_kitten_sandy.png"},
	},
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_kitten",
	},
	walk_velocity = 0.6,
	walk_chance = 15,
	run_velocity = 4,
	runaway = true,
	jump = true,
	drops = {
		{name = "farming:string", chance = 1, min = 0, max = 1},
	},
	water_damage = 0,
	lava_damage = 5,
	fear_height = 3,
	animation = {
		speed_normal = 42,
		stand_start = 97,
		stand_end = 192,
		walk_start = 0,
		walk_end = 96,
		stoodup_start = 0,
		stoodup_end = 0,
	},
	follow = {
		"lottother:beast_ring", "lottmobs:rat",
		"lottmobs:meat_raw", "lottmobs:horsemeat_raw", "lottmobs:fish_raw",
		"lottmobs:chicken_raw", "lottmobs:pork_raw", "lottmobs:rabbit_raw",
		"lottmobs:meat", "lottmobs:fish_cooked", "lottmobs:horsemeat_cooked",
		"lottmobs:chicken_cooked", "lottmobs:pork_cooked", "lottmobs:rabbit_cooked"
	},

	view_range = 12,

	on_rightclick = function(self, clicker)

		local user = clicker:get_player_name()

		if self.owner and self.owner == user then
			if not mobs:feed_tame(self, clicker, 4, true, true) then
				mobs:capture_mob(self, clicker, 50, 50, 90, false, nil)
			end
		else
			if mobs:protect(self, clicker) then
				return
			end
			if mobs:feed_tame(self, clicker, 4, true, true) then
				self.owner = clicker:get_player_name()
			else
				local vel = self.object:get_velocity()
				self.object:set_velocity({x = vel.x * 10, y = vel.y * 10, z = vel.z * 10})
			end

		end
	end,

	on_punch = function(self, hitter, tflp, tool_capabilities, dir)

		local user = hitter:get_player_name()

		if self.owner and self.owner == user then
			self.object:set_velocity({x = 0, y = 0, z = 0})
			minetest.sound_play("mobs_kitten", {
				pos = self.object:get_pos(),
				gain = 1.0,
				max_hear_distance = 5,
			})
		else
			mobs:mob_punch(self, hitter, tflp, tool_capabilities, dir)
		end
	end,

	do_custom = function(self, dtime)

		self.hairball_timer = (self.hairball_timer or 0) + dtime
		if self.hairball_timer < 10 then
			return
		end
		self.hairball_timer = 0

		if self.child or math.random(1, 250) > 2 then
			return
		end

		local pos = self.object:get_pos()

		minetest.add_item(pos, "wool:white")

		minetest.sound_play("mobs_kitten", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 5,
		})
	end,
})

-- egg throwing item

local EGG_MASS = 0.05
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
		-- файлов нет
		-- random = "mobs_chicken",
	},
	visual = "mesh",
	mesh = "chicken_model.x",
	visual_size = {x=1.5, y=1.5, z=1.5,},
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 300,
		drops = {
		{name = "lottmobs:chicken_raw",
		chance = 1,
		min = 0,
		max = 1,},
		{name = "lottmobs:egg",
		chance = 1,
		min = 0,
		max = 1,},
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

--[[mobs:register_mob("lottmobs:sheep", {
	type = "animal",
	passive = true,
	hp_min = 8,
	hp_max = 10,
	armor = 200,
	collisionbox = {-0.5, -1, -0.5, 0.5, 0.3, 0.5},
	visual = "mesh",
	mesh = "mobs_sheep.b3d",
	textures = {
		{"mobs_sheep_base.png^mobs_sheep_wool.png"}, --White
		{"mobs_sheep_base.png^(mobs_sheep_wool.png^[colorize:#663300a0)"}, --Black
		{"mobs_sheep_base.png^(mobs_sheep_wool.png^[colorize:#000000b0)"}, --Brown
		{"mobs_sheep_base.png^(mobs_sheep_wool.png^[colorize:#5b5b5bb0)"}, --Grey
	},
	gotten_texture = {"mobs_sheep_shaved.png"},
	gotten_mesh = "mobs_sheep_shaved.b3d",
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_sheep",
	},
	walk_velocity = 1,
	run_velocity = 2,
	runaway = true,
	jump = true,
	drops = {
		{name = "lottmobs:meat_raw", chance = 1, min = 1, max = 2},
		{name = "wool:white", chance = 1, min = 1, max = 1},
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 80,
		walk_start = 81,
		walk_end = 100,
	},
	follow = {"farming:wheat", "default:grass_5"},
	view_range = 8,
	replace_rate = 10,
	replace_what = {"default:grass_3", "default:grass_4", "default:grass_5", "farming:wheat_8"},
	replace_with = "air",
	replace_offset = -1,
	fear_height = 3,

	on_rightclick = function(self, clicker)
		if mobs:feed_tame(self, clicker, 8, true, true) then
			if self.gotten == false then
				self.object:set_properties({
					textures = {"mobs_sheep_base.png^mobs_sheep_wool.png"},
					mesh = "mobs_sheep.b3d",
				})
			end
			return
		end

		local item = clicker:get_wielded_item()
		local itemname = item:get_name()

		if itemname == "mobs:shears" then
			if self.gotten ~= false
			or self.child ~= false
			or not minetest.get_modpath("wool") then
				return
			end
			self.gotten = true -- shaved
			local obj = minetest.add_item(
				self.object:getpos(),
				ItemStack( "wool:" .. col[1] .. " " .. math.random(1, 3) )
			)
			if obj then
				obj:setvelocity({
					x = math.random(-1, 1),
					y = 5,
					z = math.random(-1, 1)
				})
			end
			item:add_wear(650) -- 100 uses
			clicker:set_wielded_item(item)
			self.object:set_properties({
				textures = {"mobs_sheep_shaved.png"},
				mesh = "mobs_sheep_shaved.b3d",
			})
			return
		end
	end
})]]--

--[[mobs:register_spawn("lottmobs:sheep",
    {"lottmapgen:shire_grass", "lottmapgen:gondor_grass", "lottmapgen:dunland_grass",
	"lottmapgen:ithilien_grass"},
    20, 10, 10000, 1, 31000)]]--

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
		{name = "lottmobs:rabbit_raw", chance = 1, min = 1, max = 1},
	},
	water_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 2,
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

mobs:register_mob("lottmobs:rat", {
	type = "animal",
	passive = true,
	hp_min = 1,
	hp_max = 4,
	armor = 200,
	collisionbox = {-0.2, -1, -0.2, 0.2, -0.8, 0.2},
	visual = "mesh",
	mesh = "mobs_rat.b3d",
	textures = {
		{"mobs_rat.png"},
		{"mobs_rat2.png"},
	},
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_rat",
	},
	walk_velocity = 1,
	run_velocity = 2,
	runaway = true,
	jump = true,
	water_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	fear_height = 2,
})
