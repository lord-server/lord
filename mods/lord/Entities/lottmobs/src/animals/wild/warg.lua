local S   = core.get_mod_translator()
local api = require('fear_height.api')


legacy_mobs:register_mob("lottmobs:warg", {
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
	-- Clips in `warg.b3d` (frames 1..421):
	--    1.. 36 - rest pose (T-pose, between clips)
	--   40.. 78 - walk
	--   84..131 - run
	--  135..280 - stand (idle: tail wag 175..215, head turn 250..275)
	--  305..335 - pose with moved legs (probably sit/lay) - NOT USED (no such animation in `legacy_mobs`)
	--  355..390 - head/tail movement                      - NOT USED (no such animation in `legacy_mobs`)
	--  398..421 - attack (leap)
	animation            = {
		speed_normal = 10, -- stand (slow, calm idle)
		-- walk:
		walk_start   = 40,
		walk_end     = 78,
		walk_speed   = 20,
		-- run:
		run_start    = 84,
		run_end      = 131,
		run_speed    = 90,
		-- stand (idle):
		stand_start  = 135,
		stand_end    = 280,
		stand_speed  = 10,
		-- attack:
		punch_start  = 398,
		punch_end    = 421,
		punch_speed  = 40,
	},
	on_rightclick        = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "bones:skeleton_body" or item:get_name() == "lottother:beast_ring" then
			if math.random(1, 3) ~= 1 then
				core.chat_send_player(
					clicker:get_player_name(),
					core.colorize("#ff8ea1", S("You could not tame this beast!!!"))
				)
				return
			end
			core.add_entity(self.object:get_pos(), "lottmobs:warg_mount")
			if not core.is_creative_enabled(clicker) and item:get_name() ~= "lottother:beast_ring" then
				item:take_item()
				clicker:set_wielded_item(item)
			end
			self.object:remove()
		end
	end,
	jump                 = true,
	attacks_monsters     = true,
	peaceful             = true,
	group_attack         = true,
	step                 = 1,
	sounds               = {},
	do_custom = function (self)
		api.set_fear_height_by_state(self)
	end
})
