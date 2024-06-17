local S = require("lord_wooden_stuff.config").translator

--- @param wood string
--- @param def LordWoodenStuffDefinition
--- @param groups table
--- @param stick string
local function register_stanchion(wood, def, groups, stick)
	local name = "lord_wooden_stuff:stanchion_" .. wood
	minetest.register_node(name, {
		description         = S(def.desc .. " Stanchion"),
		tiles               = { def.texture },
		drawtype            = "nodebox",
		sunlight_propagates = true,
		paramtype           = 'light',
		paramtype2          = "facedir",
		node_box            = {
			type  = "fixed",
			fixed = {
				{ -0.5,	-0.5,	-0.5,	-0.4,	0.5,	-0.4 },
				{  0.4,	-0.5,	-0.5,	 0.5,	0.5,	-0.4 },
				{ -0.5,	-0.5,	 0.4,	-0.4,	0.5,	 0.5 },
				{  0.4,	-0.5,	 0.4,	 0.5,	0.5,	 0.5 },
			},
		},
		groups              = groups
	})
	minetest.register_craft({
		output = name,
		recipe = {
			{ stick, '', stick },
			{ '',    '', ''    },
			{ stick, '', stick },
		}
	})
end

return register_stanchion
