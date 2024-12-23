local S = minetest.get_translator("lord_projectiles")

return {
    projectiles = {
		["lord_projectiles:wooden_arrow"] = {
			type        = "arrow",
			damage_tt   = 1,
			entity_name = "lord_projectiles:wooden_arrow",
			definition  = {
				description     = S("Wooden Arrow"),
				inventory_image = "items_tools_arrow.png",
				groups          = { projectiles = 1, arrow = 1 },
				stack_max       = 99,
			},
			entity_reg  = {
				initial_properties = {
					visual   = "mesh",
					mesh     = "lord_projectiles_arrow.obj",
					textures = { "projectile_arrow.png" },
				},
				max_speed        = 60,
				sound_hit_node   = { name = "lord_projectiles_arrow_hit_node",   gain = 3.0 },
				sound_hit_object = { name = "lord_projectiles_arrow_hit_object", gain = 0.1 },
				damage_groups    = { fleshy = 1 }
			},
		},
		["lord_projectiles:test_bolt"] = {
				type        = "bolt",
				damage_tt   = 1,
				entity_name = "lord_projectiles:test_bolt",
				definition  = {
					description     = S("Test Bolt"),
					inventory_image = "items_tools_arrow.png",
					groups          = { projectiles = 1, bolt = 1 },
					stack_max       = 99,
				},
				entity_reg  = {
					initial_properties = {
						visual   = "mesh",
						mesh     = "lord_projectiles_arrow.obj",
						textures = { "projectile_arrow.png" },
					},
					max_speed        = 60,
					sound_hit_node   = { name = "lord_projectiles_arrow_hit_node",   gain = 3.0 },
					sound_hit_object = { name = "lord_projectiles_arrow_hit_object", gain = 0.1 },
					damage_groups    = { fleshy = 1 }
				},
		},
	},
}