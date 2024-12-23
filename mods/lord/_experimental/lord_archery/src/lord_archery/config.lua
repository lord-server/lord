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
			stage_conf = {
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
			stage_conf = {
				charging_time = {
					[0] = 0,
					[1] = 0.5,
					[2] = 1,
					[3] = 1.5,
				},
			},
		},
	},
	throwables = {
		["lord_archery:javelin_test"] = {
			definition = {
				description      = S("Test Javelin"),
				inventory_image  = "lord_archery_test_javelin", -- without ".png"
				groups           = { javelin = 1, throwable = 1 },
				uses             = 180,
				sound_on_release = "lord_archery_arrow_release",
				--used_projectiles = { "bolt" },
				draw_power = 1,
			},
			stage_conf = {
				charging_time = {
					[0] = 0,
					[1] = 0.5,
					[2] = 1.5,
				},
			},
			projectile_reg = {
				damage_tt   = 5,
				entity_name = "lord_archery:test_javelin",
				entity_reg  = {
					initial_properties = {
						visual   = "mesh",
						mesh     = "lord_projectiles_arrow.obj",
						textures = { "projectile_arrow.png" },
					},
					max_speed        = 60,
					sound_hit_node   = { name = "lord_projectiles_arrow_hit_node",   gain = 3.0 },
					sound_hit_object = { name = "lord_projectiles_arrow_hit_object", gain = 0.1 },
					damage_groups    = { fleshy = 5 }
				},
			},
		},
	},
}
