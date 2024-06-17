--- @param name string
--- @param description_prefix string
--- @param texture string
--- @param wood_name string
--- @param node_groups table
local function register_chair(name, description_prefix, texture, wood_name, node_groups)
	local chair_reg_name = "lord_wooden_stuff:chair_" .. name
	minetest.register_node(chair_reg_name, {
		description         = S(description_prefix .. " Chair"),
		tiles               = { texture },
		drawtype            = "nodebox",
		sunlight_propagates = true,
		paramtype           = 'light',
		paramtype2          = "facedir",
		node_box            = {
			type  = "fixed",
			fixed = {
				{ -0.3, -0.5, 0.2, -0.2, 0.5, 0.3 },
				{ 0.2, -0.5, 0.2, 0.3, 0.5, 0.3 },
				{ -0.3, -0.5, -0.3, -0.2, -0.1, -0.2 },
				{ 0.2, -0.5, -0.3, 0.3, -0.1, -0.2 },
				{ -0.3, -0.1, -0.3, 0.3, 0, 0.2 },
				{ -0.2, 0.1, 0.25, 0.2, 0.4, 0.26 }
			},
		},
		selection_box       = {
			type  = "fixed",
			fixed = { -0.3, -0.5, -0.3, 0.3, 0.5, 0.3 },
		},
		groups              = node_groups,
		sounds              = default.node_sound_wood_defaults(),
	})
	minetest.register_craft({
		output = chair_reg_name,
		recipe = {
			{ 'group:stick', ''            },
			{ wood_name,     wood_name     },
			{ 'group:stick', 'group:stick' },
		}
	})
	minetest.register_craft({
		output = chair_reg_name,
		recipe = {
			{ '',            'group:stick' },
			{ wood_name,     wood_name     },
			{ 'group:stick', 'group:stick' },
		}
	})
end

return register_chair
