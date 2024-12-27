local S = minetest.get_translator("lord_projectiles")

return {
    projectiles = {
		["lord_projectiles:flint_arrow"] = {
			type        = "arrow",
			damage_tt   = 2,
			entity_name = "lord_projectiles:flint_arrow",
			definition  = {
				description     = S("Flint Arrow"),
				inventory_image = "lord_projectiles_flint_arrow.png",
				groups          = { projectile = 1, arrow = 1 },
				stack_max       = 99,
			},
			entity_reg  = {
				initial_properties = {
					visual   = "mesh",
					mesh     = "lord_projectiles_arrow.obj",
					textures = { "lord_projectiles_flint_arrow_entity.png" },
				},
				max_speed        = 30,
				sound_hit_node   = { name = "lord_projectiles_arrow_hit_node",   gain = 3.0 },
				sound_hit_object = { name = "lord_projectiles_arrow_hit_object", gain = 0.1 },
				damage_groups    = { fleshy = 2 },
				rotation_formula = "arrow",
			},
		},
		["lord_projectiles:steel_arrow"] = {
			type        = "arrow",
			damage_tt   = 4,
			entity_name = "lord_projectiles:steel_arrow",
			definition  = {
				description     = S("Steel Arrow"),
				inventory_image = "lord_projectiles_steel_arrow.png",
				groups          = { projectile = 1, arrow = 1 },
				stack_max       = 99,
			},
			entity_reg  = {
				initial_properties = {
					visual   = "mesh",
					mesh     = "lord_projectiles_arrow.obj",
					textures = { "lord_projectiles_steel_arrow_entity.png" },
				},
				max_speed        = 40,
				sound_hit_node   = { name = "lord_projectiles_arrow_hit_node",   gain = 3.0 },
				sound_hit_object = { name = "lord_projectiles_arrow_hit_object", gain = 0.1 },
				damage_groups    = { fleshy = 4 },
				rotation_formula = "arrow",
			},
		},
		["lord_projectiles:bronze_arrow"] = {
			type        = "arrow",
			damage_tt   = 5,
			entity_name = "lord_projectiles:bronze_arrow",
			definition  = {
				description     = S("Bronze Arrow"),
				inventory_image = "lord_projectiles_bronze_arrow.png",
				groups          = { projectile = 1, arrow = 1 },
				stack_max       = 99,
			},
			entity_reg  = {
				initial_properties = {
					visual   = "mesh",
					mesh     = "lord_projectiles_arrow.obj",
					textures = { "lord_projectiles_bronze_arrow_entity.png" },
				},
				max_speed        = 40,
				sound_hit_node   = { name = "lord_projectiles_arrow_hit_node",   gain = 3.0 },
				sound_hit_object = { name = "lord_projectiles_arrow_hit_object", gain = 0.1 },
				damage_groups    = { fleshy = 5 },
				rotation_formula = "arrow",
			},
		},
		["lord_projectiles:galvorn_arrow"] = {
			type        = "arrow",
			damage_tt   = 7,
			entity_name = "lord_projectiles:galvorn_arrow",
			definition  = {
				description     = S("Galvorn Arrow"),
				inventory_image = "lord_projectiles_galvorn_arrow.png",
				groups          = { projectile = 1, arrow = 1 },
				stack_max       = 99,
			},
			entity_reg  = {
				initial_properties = {
					visual   = "mesh",
					mesh     = "lord_projectiles_arrow.obj",
					textures = { "lord_projectiles_galvorn_arrow_entity.png" },
				},
				max_speed        = 50,
				sound_hit_node   = { name = "lord_projectiles_arrow_hit_node",   gain = 3.0 },
				sound_hit_object = { name = "lord_projectiles_arrow_hit_object", gain = 0.1 },
				damage_groups    = { fleshy = 7 },
				rotation_formula = "arrow",
			},
		},
		["lord_projectiles:mithril_arrow"] = {
			type        = "arrow",
			damage_tt   = 8,
			entity_name = "lord_projectiles:mithril_arrow",
			definition  = {
				description     = S("Mithril Arrow"),
				inventory_image = "lord_projectiles_mithril_arrow.png",
				groups          = { projectile = 1, arrow = 1 },
				stack_max       = 99,
			},
			entity_reg  = {
				initial_properties = {
					visual   = "mesh",
					mesh     = "lord_projectiles_arrow.obj",
					textures = { "lord_projectiles_mithril_arrow_entity.png" },
				},
				max_speed        = 60,
				sound_hit_node   = { name = "lord_projectiles_arrow_hit_node",   gain = 3.0 },
				sound_hit_object = { name = "lord_projectiles_arrow_hit_object", gain = 0.1 },
				damage_groups    = { fleshy = 8 },
				rotation_formula = "arrow",
			},
		},

		["lord_projectiles:steel_bolt"] = {
			type        = "bolt",
			damage_tt   = 6,
			entity_name = "lord_projectiles:steel_bolt",
			definition  = {
				description     = S("Steel Bolt"),
				inventory_image = "lord_projectiles_steel_bolt.png",
				groups          = { projectile = 1, bolt = 1 },
				stack_max       = 99,
			},
			entity_reg  = {
				initial_properties = {
					visual   = "mesh",
					mesh     = "lord_projectiles_arrow.obj",
					textures = { "lord_projectiles_steel_bolt_entity.png" },
				},
				max_speed        = 60,
				sound_hit_node   = { name = "lord_projectiles_arrow_hit_node",   gain = 3.0 },
				sound_hit_object = { name = "lord_projectiles_arrow_hit_object", gain = 0.1 },
				damage_groups    = { fleshy = 6 },
				rotation_formula = "arrow",
			},
		},
		["lord_projectiles:bronze_bolt"] = {
			type        = "bolt",
			damage_tt   = 7,
			entity_name = "lord_projectiles:bronze_bolt",
			definition  = {
				description     = S("Bronze Bolt"),
				inventory_image = "lord_projectiles_bronze_bolt.png",
				groups          = { projectile = 1, bolt = 1 },
				stack_max       = 99,
			},
			entity_reg  = {
				initial_properties = {
					visual   = "mesh",
					mesh     = "lord_projectiles_arrow.obj",
					textures = { "lord_projectiles_bronze_bolt_entity.png" },
				},
				max_speed        = 60,
				sound_hit_node   = { name = "lord_projectiles_arrow_hit_node",   gain = 3.0 },
				sound_hit_object = { name = "lord_projectiles_arrow_hit_object", gain = 0.1 },
				damage_groups    = { fleshy = 7 },
				rotation_formula = "arrow",
			},
		},
		["lord_projectiles:galvorn_bolt"] = {
			type        = "bolt",
			damage_tt   = 9,
			entity_name = "lord_projectiles:galvorn_bolt",
			definition  = {
				description     = S("Galvorn Bolt"),
				inventory_image = "lord_projectiles_galvorn_bolt.png",
				groups          = { projectile = 1, bolt = 1 },
				stack_max       = 99,
			},
			entity_reg  = {
				initial_properties = {
					visual   = "mesh",
					mesh     = "lord_projectiles_arrow.obj",
					textures = { "lord_projectiles_galvorn_bolt_entity.png" },
				},
				max_speed        = 70,
				sound_hit_node   = { name = "lord_projectiles_arrow_hit_node",   gain = 3.0 },
				sound_hit_object = { name = "lord_projectiles_arrow_hit_object", gain = 0.1 },
				damage_groups    = { fleshy = 9 },
				rotation_formula = "arrow",
			},
		},
		["lord_projectiles:mithril_bolt"] = {
			type        = "bolt",
			damage_tt   = 10,
			entity_name = "lord_projectiles:mithril_bolt",
			definition  = {
				description     = S("Mithril Bolt"),
				inventory_image = "lord_projectiles_mithril_bolt.png",
				groups          = { projectile = 1, bolt = 1 },
				stack_max       = 99,
			},
			entity_reg  = {
				initial_properties = {
					visual   = "mesh",
					mesh     = "lord_projectiles_arrow.obj",
					textures = { "lord_projectiles_mithril_bolt_entity.png" },
				},
				max_speed        = 70,
				sound_hit_node   = { name = "lord_projectiles_arrow_hit_node",   gain = 3.0 },
				sound_hit_object = { name = "lord_projectiles_arrow_hit_object", gain = 0.1 },
				damage_groups    = { fleshy = 10 },
				rotation_formula = "arrow",
			},
		},
	},
}
