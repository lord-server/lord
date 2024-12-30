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
				rotation_formula = "pointed",
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
				rotation_formula = "pointed",
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
				rotation_formula = "pointed",
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
				rotation_formula = "pointed",
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
				rotation_formula = "pointed",
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
				rotation_formula = "pointed",
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
				rotation_formula = "pointed",
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
				rotation_formula = "pointed",
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
				rotation_formula = "pointed",
			},
		},

		["lord_projectiles:fire_ball"] = {
			type        = "fire_magic",
			damage_tt   = 15,
			entity_name = "lord_projectiles:fire_ball",
			definition  = {
				description     = S("Fire Ball"),
				inventory_image = "mobs_fireball.png",
				wield_scale     = vector.new(1, 1, 0.5),
				groups          = { projectile = 1, fire_ball = 1, not_in_creative_inventory = 1 },
				stack_max       = 99,
			},
			entity_reg  = {
				initial_properties = {
					visual    = "item",
					wield_item = "lord_projectiles:fire_ball",
					visual_size = vector.new(1, 1, 1),
				},
				max_speed        = 35,
				sound_hit_node   = { name = "lord_projectiles_explosion", gain = 3.0 },
				sound_hit_object = { name = "lord_projectiles_explosion", gain = 3.0 },
				damage_groups    = { fire = 15, },
				rotation_formula = "rolling",
				on_hit_node      = function(projectile, node_pos, move_result)
					local radius = 1
					local rad_vec = vector.new(radius, radius, radius)
					local min_pos = vector.subtract(node_pos, rad_vec)
					local max_pos = vector.add(node_pos, rad_vec)
					projectiles.flame_area(min_pos, max_pos)
					minetest.add_particlespawner({
						pos = {
							min = min_pos,
							max = max_pos,
						},
						time = 0.1,
						amount = 500,
						size = { min = 4, max = 6 },
						texture = {
							name = "lord_projectiles_explosion_particle.png",
							alpha_tween = { 1, 0 },
							scale = 1,
						},
						vel = {
							min = vector.new(-5, -6, -5),
							max = vector.new(5, 8, 5),
						},
						acc = {
							min = vector.new(-0, -9.81, -0),
							max = vector.new(0, -9.81, 0),
						},
						exptime = { min = 0.1, max = 2 },
					})
				end,
				on_hit_object = function(projectile, target, move_result)
					local pos = target:get_pos()
					local radius = 1
					local rad_vec = vector.new(radius, radius, radius)
					local min_pos = vector.subtract(pos, rad_vec)
					local max_pos = vector.add(pos, rad_vec)
					minetest.add_particlespawner({
						pos = {
							min = min_pos,
							max = max_pos,
						},
						time = 0.1,
						amount = 500,
						size = { min = 4, max = 6 },
						texture = {
							name = "lord_projectiles_explosion_particle.png",
							alpha_tween = { 1, 0 },
							scale = 1,
						},
						vel = {
							min = vector.new(-5, -6, -5),
							max = vector.new(5, 8, 5),
						},
						acc = {
							min = vector.new(-0, -9.81, -0),
							max = vector.new(0, -9.81, 0),
						},
						exptime = { min = 0.1, max = 2 },
					})
				end,
				after_hit_node = function(projectile)
					projectile.object:remove()
				end,
				after_hit_entity = function(projectile)
					projectile.object:remove()
				end
			},
		},

		["lord_projectiles:dark_ball"] = {
			type        = "soul_magic",
			damage_tt   = 15,
			entity_name = "lord_projectiles:dark_ball",
			definition  = {
				description     = S("Dark Ball"),
				inventory_image = "lottmobs_darkball.png",
				wield_scale     = vector.new(1, 1, 0.5),
				groups          = { projectile = 1, dark_ball = 1, not_in_creative_inventory = 1 },
				stack_max       = 99,
			},
			entity_reg  = {
				initial_properties = {
					visual    = "item",
					wield_item = "lord_projectiles:dark_ball",
					visual_size = vector.new(1, 1, 1),
				},
				max_speed        = 20,
				sound_hit_node   = { name = "lord_projectiles_explosion", gain = 3.0 },
				sound_hit_object = { name = "lord_projectiles_explosion", gain = 3.0 },
				damage_groups    = { soul = 15, },
				rotation_formula = "rolling",
				on_hit_node      = function(projectile, node_pos, move_result)
					local radius = 1
					local rad_vec = vector.new(radius, radius, radius)
					local min_pos = vector.subtract(node_pos, rad_vec)
					local max_pos = vector.add(node_pos, rad_vec)
					projectiles.flame_area(min_pos, max_pos)
					minetest.add_particlespawner({
						pos = {
							min = min_pos,
							max = max_pos,
						},
						time = 0.1,
						amount = 500,
						size = { min = 4, max = 6 },
						texture = {
							name = "lord_projectiles_explosion_particle.png",
							alpha_tween = { 1, 0 },
							scale = 1,
						},
						vel = {
							min = vector.new(-5, -6, -5),
							max = vector.new(5, 8, 5),
						},
						acc = {
							min = vector.new(-0, -9.81, -0),
							max = vector.new(0, -9.81, 0),
						},
						exptime = { min = 0.1, max = 2 },
					})
				end,
				on_hit_object = function(projectile, target, move_result)
					local pos = target:get_pos()
					local radius = 1
					local rad_vec = vector.new(radius, radius, radius)
					local min_pos = vector.subtract(pos, rad_vec)
					local max_pos = vector.add(pos, rad_vec)
					minetest.add_particlespawner({
						pos = {
							min = min_pos,
							max = max_pos,
						},
						time = 0.1,
						amount = 500,
						size = { min = 4, max = 6 },
						texture = {
							name = "lord_projectiles_explosion_particle.png",
							alpha_tween = { 1, 0 },
							scale = 1,
						},
						vel = {
							min = vector.new(-5, -6, -5),
							max = vector.new(5, 8, 5),
						},
						acc = {
							min = vector.new(-0, -9.81, -0),
							max = vector.new(0, -9.81, 0),
						},
						exptime = { min = 0.1, max = 2 },
					})
				end,
				after_hit_node = function(projectile)
					projectile.object:remove()
				end,
				after_hit_entity = function(projectile)
					projectile.object:remove()
				end
			},
		},
	},
}
