
minetest.register_craft({
	output = "lord_homedecor:table", "lord_homedecor:chair 2",
	recipe = {
		{ "group:wood","group:wood", "group:wood" },
		{ "group:stick", "", "group:stick" },
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "lord_homedecor:table_mahogany",
	recipe = {
		"lord_homedecor:table",
		"dye:brown",
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "lord_homedecor:table_mahogany",
	recipe = {
		"lord_homedecor:table",
		"unifieddyes:dark_orange",
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "lord_homedecor:table_white",
	recipe = {
		"lord_homedecor:table",
		"dye:white",
	},
})

minetest.register_craft({
	type = "fuel",
	recipe = "lord_homedecor:table",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "lord_homedecor:table_mahogany",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "lord_homedecor:table_white",
	burntime = 30,
})

minetest.register_craft({
	output = "lord_homedecor:chair 2",
	recipe = {
		{ "group:stick",""},
		{ "group:wood","group:wood" },
		{ "group:stick","group:stick" },
	},
})

minetest.register_craft({
	type = "fuel",
	recipe = "lord_homedecor:chair",
	burntime = 15,
})

local chaircolors = { "black", "red", "pink", "violet", "blue", "dark_green" }

for _, color in ipairs(chaircolors) do

	minetest.register_craft({
		type = "shapeless",
		output = "lord_homedecor:chair_"..color,
		recipe = {
			"lord_homedecor:chair",
			"wool:white",
			"dye:"..color
		},
	})

	minetest.register_craft({
		type = "shapeless",
		output = "lord_homedecor:chair_"..color,
		recipe = {
			"lord_homedecor:chair",
			"wool:"..color
		},
	})

	minetest.register_craft({
		type = "fuel",
		recipe = "lord_homedecor:chair_"..color,
		burntime = 15,
	})
end

minetest.register_craft({
	type = "fuel",
	recipe = "lord_homedecor:armchair",
	burntime = 30,
})

minetest.register_craft({
	output = "lord_homedecor:table_lamp_white_off",
	recipe = {
		{"default:paper","default:torch" ,"default:paper"},
		{"","group:stick",""},
		{"","stairs:slab_wood",""},
	},
})

minetest.register_craft({
	output = "lord_homedecor:table_lamp_white_off",
	recipe = {
		{"default:paper","default:torch" ,"default:paper"},
		{"","group:stick",""},
		{"","moreblocks:slab_wood",""},
	},
})

minetest.register_craft({
	output = "lord_homedecor:standing_lamp_white_off",
	recipe = {
		{"lord_homedecor:table_lamp_white_off"},
		{"group:stick"},
		{"group:stick"},
	},
})

minetest.register_craft({
	type = "fuel",
	recipe = "lord_homedecor:table_lamp_white_off",
	burntime = 10,
})

local lamp_colors = { "blue", "green", "pink", "red", "violet" }

for _, color in ipairs(lamp_colors) do

	minetest.register_craft({
		output = "lord_homedecor:table_lamp_"..color.."_off",
		recipe = {
			{"wool:"..color,"default:torch" ,"wool:"..color},
			{"","group:stick",""},
			{"","stairs:slab_wood",""},
		},
	})

	minetest.register_craft({
		output = "lord_homedecor:table_lamp_"..color.."_off",
		recipe = {
			{"wool:"..color,"default:torch" ,"wool:"..color},
			{"","group:stick",""},
			{"","moreblocks:slab_wood",""},
		},
	})

	minetest.register_craft({
		type = "shapeless",
		output = "lord_homedecor:table_lamp_"..color.."_off",
		recipe = {
			"dye:"..color,
			"lord_homedecor:table_lamp_off",
		},
	})

	minetest.register_craft({
		type = "fuel",
		recipe = "lord_homedecor:table_lamp_"..color.."_off",
		burntime = 10,
	})

	minetest.register_craft({
		output = "lord_homedecor:standing_lamp_"..color.."_off",
		recipe = {
			{"lord_homedecor:table_lamp_"..color.."_off"},
			{"group:stick"},
			{"group:stick"},
		},
	})

	minetest.register_craft({
		type = "shapeless",
		output = "lord_homedecor:standing_lamp_"..color.."_off",
		recipe = {
			"lord_homedecor:standing_lamp_off",
			"dye:"..color
		},
	})

end

minetest.register_craft({
	output = "lord_homedecor:toilet",
	recipe = {
		{"","","bucket:bucket_water"},
		{ "group:marble","group:marble", "group:marble" },
		{ "", "bucket:bucket_empty", "" },
	},
})

minetest.register_craft({
	output = "lord_homedecor:sink",
	recipe = {
		{ "group:marble","bucket:bucket_empty", "group:marble" },
	},
})

minetest.register_craft({
	output = "lord_homedecor:taps",
	recipe = {
		{ "default:steel_ingot","bucket:bucket_water", "default:steel_ingot" },
	},
})

minetest.register_craft({
	output = "lord_homedecor:taps_brass",
	recipe = {
		{ "technic:brass_ingot","bucket:bucket_water", "technic:brass_ingot" },
	},
})

minetest.register_craft({
	output = "lord_homedecor:shower_tray",
	recipe = {
		{ "group:marble","bucket:bucket_water", "group:marble" },
	},
})

minetest.register_craft({
	output = "lord_homedecor:shower_head",
	recipe = {
		{"default:steel_ingot", "bucket:bucket_water"},
	},
})

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
