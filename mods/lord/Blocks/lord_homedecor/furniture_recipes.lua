core.register_craft({
	output = "lord_homedecor:bars 6",
	recipe = {
		{ "default:steel_ingot","default:steel_ingot","default:steel_ingot" },
		{ "lord_homedecor:pole_wrought_iron","lord_homedecor:pole_wrought_iron","lord_homedecor:pole_wrought_iron" },
	},
})

core.register_craft({
	output = "lord_homedecor:L_binding_bars 3",
	recipe = {
		{ "lord_homedecor:bars","" },
		{ "lord_homedecor:bars","lord_homedecor:bars" },
	},
})

core.register_craft({
	output = "lord_homedecor:chains 2",
	recipe = {
		{ "default:steel_ingot", "default:steel_ingot" },
		{ "lamps:chains_vertical_steel", "lamps:chains_vertical_steel" },
	},
})

core.register_craft({
	output = "lord_homedecor:torch_wall 4",
	recipe = {
		{ "default:coal_lump" },
		{ "default:steel_ingot" },
	},
})

core.register_craft({
	output = "lord_homedecor:torch_wall 2",
	recipe = {
		{ "default:charcoal_lump" },
		{ "default:steel_ingot" },
	},
})
