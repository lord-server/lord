local SL = minetest.get_translator("lottmobs")

lottmobs.register_horse("lottmobs:warg_mount", {
	description     = SL("Warg"),
	inventory_image = "lottmobs_warg_inv.png",
}, {
	riders        = { "orc" },
	physical      = true,
	collisionbox  = { -0.6, -0.01, -0.6, 0.6, 1.5, 0.6 },
	visual        = "mesh",
	stepheight    = 1.1,
	attach_height = 20,
	offset        = true,
	offset_h      = 4,
	attach_h      = 17,
	run           = true,
	hp            = 40,
	dps           = 8,
	aggressive    = true,
	mesh          = "warg_mount.b3d",
	textures      = { "lottmobs_warg.png" },
	animation     = {
		speed_normal = 10,
		stand_start  = 135,
		stand_end    = 280,
		walk_start   = 80,
		walk_end     = 130,
		punch_start  = 350,
		punch_end    = 390,
	},
	max_speed     = 7,
	forward_boost = 2.33,
	jump_boost    = 7,
	feed = {
		["lottmobs:rotten_meat"] = 6,
		["lottfarming:orc_food"] = 5,
	},
})
----------------

mobs:register_mob("lottmobs:warg", {
	--	type = "npc",
	type                 = "monster",
	race                 = "orc",
	hp_min               = 25,
	hp_max               = 40,
	collisionbox         = { -0.6, -0.1, -0.6, 0.6, 1.5, 0.6 },
	textures             = {
		{ "lottmobs_warg.png" },
	},
	visual               = "mesh",
	mesh                 = "warg.b3d",
	makes_footstep_sound = true,
	walk_velocity        = 1,
	run_velocity         = 3,
	view_range           = 15,
	armor                = 300,
	drops                = {
		{ name = "lottmobs:rotten_meat", chance = 5, min = 4, max = 10, },
		{ name = "lottclothes:felt_grey", chance = 5, min = 2, max = 7, },
	},
	light_resistant      = true,
	drawtype             = "front",
	water_damage         = 3,
	lava_damage          = 1,
	light_damage         = 0,
	damage               = 8,
	attack_type          = "dogfight", --Rather suitable name!
	animation            = {
		speed_normal = 10,
		speed_run    = 10,
		stand_start  = 135,
		stand_end    = 280,
		walk_start   = 40,
		walk_end     = 75,
		run_start    = 80,
		run_end      = 130,
		punch_start  = 350,
		punch_end    = 420,
	},
	on_rightclick        = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "bones:skeleton_body" or item:get_name() == "lottother:beast_ring" then
			if math.random(1, 3) ~= 1 then
				minetest.chat_send_player(
					clicker:get_player_name(),
					core.colorize("#ff8ea1", SL("You could not tame this beast!!!"))
				)
				return
			end
			minetest.add_entity(self.object:get_pos(), "lottmobs:warg_mount")
			if not minetest.is_creative_enabled(clicker) and item:get_name() ~= "lottother:beast_ring" then
				item:take_item()
				clicker:set_wielded_item(item)
			end
			self.object:remove()
		end
	end,
	do_custom            = lottmobs.do_custom_guard,
	jump                 = true,
	attacks_monsters     = true,
	peaceful             = true,
	group_attack         = true,
	step                 = 1,
	sounds               = {},
})
