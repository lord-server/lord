local S = minetest.get_translator("lord_archery")


return {
	bows = {
		["lord_archery:bow_wooden"] = {
			definition = {
				description      = S("Wooden Bow"),
				inventory_image  = "items_tools_bow_wooden", -- without ".png"
				groups           = { wooden = 1, bow = 1, allow_hold_abort = 1, archery_item = 1 },
				uses             = 180,
				sound_on_release = "lord_archery_arrow_release",
				used_projectiles = { "arrow" },
				draw_power = 1,
			},
			stages = {
				charging_time = {
					[0] = 0,
					[1] = .25,
					[2] = .75,
					[3] = 1.25,
				},
			},
		},
	},
	crossbows = {
		["lord_archery:crossbow_test"] = {
			definition = {
				description      = S("Test Crossbow"),
				inventory_image  = "lord_archery_test_crossbow", -- without ".png"
				groups           = { crossbow = 1, archery_item = 1 },
				uses             = 180,
				sound_on_release = "lord_archery_arrow_release",
				used_projectiles = { "bolt" },
				draw_power = 1,
			},
			stages = {
				charging_time = {
					[0] = 0,
					[1] = 0.5,
					[2] = 1,
				},
			},
		},
	},
}
