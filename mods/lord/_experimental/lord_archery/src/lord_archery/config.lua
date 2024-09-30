local S = minetest.get_translator("lord_archery")


return {
	bows = {
		["lord_bows:bow_wooden"] = {
			definition = {
				description       = S("Wooden Bow"),
				inventory_image   = "items_tools_bow_wooden", -- without ".png"
				groups            = { wooden = 1, bow = 1, },
				uses              = 70,
				_sound_on_release = "lord_archery_arrow_release",
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
	crossbows = {},
}
