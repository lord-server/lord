local S = minetest.get_translator("lord_projectiles")

return {
    projectiles = {
		["lord_projectiles:wooden_arrow"] = {
			damage             = 5,
			entity_name        = "lord_projectiles:wooden_arrow",
			definition         = {
				description         = S("Wooden Arrow"),
				inventory_image     = "items_tools_arrow.png",
				groups              = { projectiles = 1, arrow = 1, },
				stack_max           = 99,
			},
			entity_reg        = {
				visual           = "mesh",
				mesh             = "lord_projectiles_arrow.obj",
				textures         = { "projectile_arrow.png" },
				max_speed        = 20,
				sound_hit_node   = { name = "lord_projectiles_arrow_hit_node",   gain = 3.0 },
				sound_hit_object = { name = "lord_projectiles_arrow_hit_object", gain = 0.1 },
				drag_coefficient = 4,
				damage_groups    = { fleshy = 5 }
			},
		},
	},
}