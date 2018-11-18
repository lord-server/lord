minetest.register_craft({
	output = "lord_homedecor:bars 6",
	recipe = {
		{ "default:steel_ingot","default:steel_ingot","default:steel_ingot" },
		{ "lord_homedecor:pole_wrought_iron","lord_homedecor:pole_wrought_iron","lord_homedecor:pole_wrought_iron" },
	},
})

minetest.register_craft({
	output = "lord_homedecor:L_binding_bars 3",
	recipe = {
		{ "lord_homedecor:bars","" },
		{ "lord_homedecor:bars","lord_homedecor:bars" },
	},
})

minetest.register_craft({
	output = "lord_homedecor:torch_wall 10",
	recipe = {
		{ "default:coal_lump" },
		{ "default:steel_ingot" },
	},
})
