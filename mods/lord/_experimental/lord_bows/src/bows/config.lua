local S = minetest.get_translator("lord_bows")


return {
	bows = {
		["lord_bows:bow_wooden"] = {
			definition = {
				description       = S("Wooden Bow"),
				inventory_image   = "items_tools_bow_wooden", -- without ".png"
				groups            = { wooden = 1, bow = 1, },
				uses              = 70,
			},
			bow_stages = {
				charging_time = {
					[0] = 0,
					[1] = 0.5,
					[2] = 1,
					[3] = 1.5,
				},
			},
		},
	},
	projectiles = {
		["lord_bows:arrow"] = {
			damage             = 10,
			speed              = 20,
			entity_name        = "lord_bows:arrow",
			projectile_texture = { "projectile_arrow.png" },
			definition         = {
				description         = S("Arrow"),
				inventory_image     = "items_tools_arrow.png",
				groups              = { projectiles = 1, arrow = 1, },
				stack_max           = 99
			},
		},
	},
}
