--- @param name string
--- @param description_prefix string
--- @param texture string
--- @param node_groups table
--- @param stick_reg_name string
local function register_stanchion(name, description_prefix, texture, node_groups, stick_reg_name)
	local stanchion_reg_name = "lord_wooden_stuff:stanchion_" .. name
	minetest.register_node(stanchion_reg_name, {
		description         = S(description_prefix .. " Stanchion"),
		tiles               = { texture },
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
		groups              = node_groups
	})
	minetest.register_craft({
		output = stanchion_reg_name,
		recipe = {
			{ stick_reg_name, '', stick_reg_name },
			{ '',             '', ''             },
			{ stick_reg_name, '', stick_reg_name },
		}
	})
end

return register_stanchion
