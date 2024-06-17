local S = require("lord_wooden_stuff.config").translator

--- @param name string
--- @param def LordWoodenStuffDefinition
--- @param groups table
local function register_table(name, def, groups)
	local name = "lord_wooden_stuff:table_" .. name
	minetest.register_node(name, {
		description         = S(def.desc .. " Table"),
		tiles               = { def.texture },
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
		groups              = groups,
		sounds              = default.node_sound_wood_defaults(),
	})
	minetest.register_craft({
		output = name,
		recipe = {
			{ def.wood_name, def.wood_name,  def.wood_name },
			{ 'group:stick', 'group:stick', 'group:stick'  },
			{ 'group:stick', '',            'group:stick'  },
		}
	})
end


return register_table
