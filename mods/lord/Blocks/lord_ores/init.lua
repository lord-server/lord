

minetest.mod(function(mod)
	require('rock_ores')


	local S = minetest.get_translator('lord_ores')

	minetest.register_node("lord_ores:magma", {
		description                = S("Magma"),
		groups                     = { rock = 1, cracky = 2, },
		paramtype                  = "light",
		light_source               = 4,
		sounds                     = default.node_sound_stone_defaults(),
		tiles                      = {
			{
				name      = "lord_ores_magma.png",
				animation = {
					type     = "vertical_frames",
					aspect_w = 32,
					aspect_h = 32,
					length   = 1.5
				}
			}
		},
		walkable                   = false,
		liquidtype                 = "none",
		liquid_alternative_source  = "lord_ores:magma",
		liquid_alternative_flowing = "lord_ores:magma",
		liquid_range               = 0,
		move_resistance            = 15,
		damage_per_second          = 4,
		damage_groups              = { fire = true, },
	})
end)
