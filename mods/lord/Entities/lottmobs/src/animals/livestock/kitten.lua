

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
		{ name = "farming:string", chance = 1, min = 0, max = 1 },
	},
	water_damage = 0,
	lava_damage = 5,
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
			mobs.mob_punch(self, hitter, tflp, tool_capabilities, dir)
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
