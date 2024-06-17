local S = require("lord_wooden_stuff.config").translator

--- @param name string
--- @param description_prefix string
--- @param texture string
--- @param wood_name string
--- @param node_groups table
local function register_table(name, description_prefix, texture, wood_name, node_groups)
	local table_reg_name = "lord_wooden_stuff:table_" .. name
	minetest.register_node(table_reg_name, {
		description         = S(description_prefix .. " Table"),
		tiles               = { texture },
		drawtype            = "nodebox",
		sunlight_propagates = true,
		paramtype           = 'light',
		paramtype2          = "facedir",
		node_box            = {
			type  = "fixed",
			fixed = {
				{ -0.4, -0.5, -0.4, -0.3, 0.4, -0.3 },
				{ 0.3, -0.5, -0.4, 0.4, 0.4, -0.3 },
				{ -0.4, -0.5, 0.3, -0.3, 0.4, 0.4 },
				{ 0.3, -0.5, 0.3, 0.4, 0.4, 0.4 },
				{ -0.5, 0.4, -0.5, 0.5, 0.5, 0.5 },
				{ -0.4, -0.2, -0.3, -0.3, -0.1, 0.3 },
				{ 0.3, -0.2, -0.4, 0.4, -0.1, 0.3 },
				{ -0.3, -0.2, -0.4, 0.4, -0.1, -0.3 },
				{ -0.3, -0.2, 0.3, 0.3, -0.1, 0.4 },
			},
		},
		groups              = node_groups,
		sounds              = default.node_sound_wood_defaults(),
	})
	minetest.register_craft({
		output = table_reg_name,
		recipe = {
			{ wood_name,     wood_name,     wood_name     },
			{ 'group:stick', 'group:stick', 'group:stick' },
			{ 'group:stick', '',            'group:stick' },
		}
	})
end

return register_table
