local SL = lord.require_intllib()

lottmobs.register_horse("lottmobs:boar_mount", {
	description     = SL("Boar"),
	inventory_image = "lottmobs_boar.png",
}, {
	riders        = { "dwarf" },
	physical      = true,
	collisionbox  = { -0.4, -0.01, -0.4, 0.4, 1, 0.4 },
	visual        = "mesh",
	stepheight    = 1.1,
	offset        = true,
	offset_h      = 2,
	attach_h      = 14,
	reach         = 2,
	run           = true,
	hp            = 40,
	dps           = 8,
	aggressive    = true,
	mesh          = "mobs_boar_mount.x",
	textures      = { "mobs_pumba.png" },
	animation     = {
		speed_normal = 15,
		stand_start  = 25,
		stand_end    = 55,
		walk_start   = 70,
		walk_end     = 100,
		punch_start  = 70,
		punch_end    = 100,
	},
	max_speed     = 7,
	forward_boost = 1.67,
	jump_boost    = 5,
})
----------------

mobs:register_mob("lottmobs:boar", {
	type                 = "animal",
	--	type = "monster",
	passive              = false,
	attack_type          = "dogfight",
	group_attack         = true,
	reach                = 2,
	damage               = 2,
	hp_min               = 5,
	hp_max               = 15,
	armor                = 200,
	collisionbox         = { -0.4, -0.01, -0.4, 0.4, 1, 0.4 },
	visual               = "mesh",
	visual_size          = { x = 1.26, y = 1.26 },
	mesh                 = "mobs_boar.x",
	textures             = {
		{ "mobs_pumba.png" },
	},
	makes_footstep_sound = true,
	sounds               = {
		random = "mobs_pig",
		attack = "mobs_pig_angry",
	},
	walk_velocity        = 2,
	run_velocity         = 3,
	jump                 = true,
	follow               = { "default:apple", "lottfarming:potato", "lottother:beast_ring" },
	view_range           = 10,
	drops                = {
		{ name = "lottmobs:pork_raw", chance = 1, min = 1, max = 3 },
	},
	water_damage         = 1,
	lava_damage          = 5,
	light_damage         = 0,
	fear_height          = 2,
	animation            = {
		speed_normal = 15,
		stand_start  = 25,
		stand_end    = 55,
		walk_start   = 70,
		walk_end     = 100,
		punch_start  = 70,
		punch_end    = 100,
	},
	replace_rate         = 1,
	replace_what         = { { "lottfarming:potato_3", "air", 0 }, { "lottfarming:turnips_4", "air", 0 } },
	on_rightclick        = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "default:apple" or item:get_name() == "lottother:beast_ring" then
			if math.random(1, 3) ~= 1 then
				minetest.chat_send_player(
					clicker:get_player_name(),
					core.colorize("#ff8ea1", SL("You could not tame this beast!!!"))
				)
				return
			end
			minetest.add_entity(self.object:getpos(), "lottmobs:boar_mount")
			if not default.creative and item:get_name() ~= "lottother:beast_ring" then
				item:take_item()
				clicker:set_wielded_item(item)
			end
			self.object:remove()
		end
	end,
})
