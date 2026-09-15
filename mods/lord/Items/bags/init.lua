
core.mod(function(mod)
	local S = mod.translator

	core.register_tool("bags:small", {
		description     = S("Small Bag"),
		inventory_image = "bags_small.png",
		groups          = { bagslots = 8 },
	})
	core.register_tool("bags:medium", {
		description     = S("Medium Bag"),
		inventory_image = "bags_medium.png",
		groups          = { bagslots = 16 },
	})
	core.register_tool("bags:large", {
		description     = S("Large Bag"),
		inventory_image = "bags_large.png",
		groups          = { bagslots = 24, forbidden = 1 },
	})

	core.register_craft({
		output = 'bags:small',
		recipe = {
			{ '', 'group:stick', '' },
			{ 'group:wool', 'default:steel_ingot', 'group:wool' },
			{ 'group:wool', 'group:wool', 'group:wool' },
		}
	})

	core.register_craft({
		output = 'bags:medium',
		recipe = {
			{ 'default:steel_ingot', 'farming:string', 'default:steel_ingot' },
			{ 'bags:small', 'farming:string', 'bags:small' },
		}
	})

	core.register_craft({
		output = 'bags:large',
		recipe = {
			{ 'default:steel_ingot', 'bags:medium', 'default:steel_ingot' },
			{ 'farming:string', 'bags:small', 'farming:string' },
		}
	})

	core.register_craft({
		output = 'bags:large',
		recipe = {
			{ 'default:steel_ingot', 'bags:small', 'default:steel_ingot' },
			{ 'farming:string', 'bags:medium', 'farming:string' },
		}
	})
end)
