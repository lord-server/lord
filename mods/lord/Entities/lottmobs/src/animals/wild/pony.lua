local SL = minetest.get_mod_translator()


mobs:register_mob("lottmobs:shirepony", {
	type                 = "animal",
	hp_min               = 5,
	hp_max               = 7,
	collisionbox         = { -0.4, -0.01, -0.4, 0.4, 1, 0.4 },
	textures             = {
		{ "lottmobs_shirepony.png" },
	},
	visual               = "mesh",
	mesh                 = "shirepony_model.x",
	makes_footstep_sound = true,
	walk_velocity        = 1,
	armor                = 200,
	visual_size          = { x = 1.3, y = 1.3 },
	drops                = {
		{ name   = "lottmobs:horsemeat_raw",
		  chance = 1,
		  min    = 2,
		  max    = 3, },
	},
	drawtype             = "front",
	water_damage         = 1,
	lava_damage          = 5,
	light_damage         = 0,
	sounds               = {
		random = "",
	},
	animation            = {
		speed_normal = 15,
		stand_start  = 0,
		stand_end    = 40,
		walk_start   = 45,
		walk_end     = 85,
	},
	replace_rate         = 1,
	replace_what         = {
		{ "farming:wheat_8", "air", 0 }, { "farming:wheat_7", "air", 0 }, { "farming:wheat_6", "air", 0 },
		{ "farming:wheat_5", "air", 0 }, { "farming:wheat_4", "air", 0 }, { "farming:wheat_3", "air", 0 },
		{ "lottfarming:barley_3", "air", 0 }, { "lottfarming:barley_wild", "air", 0 }
	},
	follow               = {
		"farming:wheat", "lottother:beast_ring", "lottfarming:sheaf_barley", "lottfarming:carrot_item"
	},
	view_range           = 5,
	on_rightclick        = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "lottfarming:sheaf_barley" or item:get_name() == "lottother:beast_ring" then
			if math.random(1, 3) ~= 1 then
				minetest.chat_send_player(
					clicker:get_player_name(),
					core.colorize("#ff8ea1", SL("You could not tame this beast!!!"))
				)
				return
			end
			minetest.add_entity(self.object:get_pos(), "lottmobs:shireponyh1")
			if not minetest.is_creative_enabled(clicker) and item:get_name() ~= "lottother:beast_ring" then
				item:take_item()
				clicker:set_wielded_item(item)
			end
			self.object:remove()
		end
	end,
	jump                 = true,
	step                 = 1,
	passive              = true,
})

mobs:register_mob("lottmobs:shireponyblack", {
	type                 = "animal",
	hp_min               = 5,
	hp_max               = 7,
	collisionbox         = { -0.4, -0.01, -0.4, 0.4, 1, 0.4 },
	textures             = {
		{ "lottmobs_shireponyblack.png" },
	},
	visual               = "mesh",
	mesh                 = "shirepony_model.x",
	makes_footstep_sound = true,
	walk_velocity        = 1,
	armor                = 200,
	visual_size          = { x = 1.3, y = 1.3 },
	drops                = {
		{ name   = "lottmobs:horsemeat_raw",
		  chance = 1,
		  min    = 2,
		  max    = 3, },
	},
	drawtype             = "front",
	water_damage         = 1,
	lava_damage          = 5,
	light_damage         = 0,
	sounds               = {
		random = "",
	},
	animation            = {
		speed_normal = 15,
		stand_start  = 0,
		stand_end    = 40,
		walk_start   = 45,
		walk_end     = 85,
	},
	replace_rate         = 1,
	replace_what         = {
		{ "farming:wheat_8", "air", 0 }, { "farming:wheat_7", "air", 0 }, { "farming:wheat_6", "air", 0 },
		{ "farming:wheat_5", "air", 0 }, { "farming:wheat_4", "air", 0 }, { "farming:wheat_3", "air", 0 },
		{ "lottfarming:barley_3", "air", 0 }, { "lottfarming:barley_wild", "air", 0 }
	},
	follow               = {
		"farming:wheat", "lottother:beast_ring", "lottfarming:sheaf_barley", "lottfarming:carrot_item"
	},
	view_range           = 5,
	on_rightclick        = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "lottfarming:sheaf_barley" or item:get_name() == "lottother:beast_ring" then
			if math.random(1, 3) ~= 1 then
				minetest.chat_send_player(
					clicker:get_player_name(),
					core.colorize("#ff8ea1", SL("You could not tame this beast!!!"))
				)
				return
			end
			minetest.add_entity(self.object:get_pos(), "lottmobs:shireponyblackh1")
			if not minetest.is_creative_enabled(clicker) and item:get_name() ~= "lottother:beast_ring" then
				item:take_item()
				clicker:set_wielded_item(item)
			end
			self.object:remove()
		end
	end,
	jump                 = true,
	step                 = 1,
	passive              = true,
	fear_height = 3,
})
