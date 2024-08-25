minetest.register_craft({
	output = "default:sign_wall 3",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
		{"", "group:stick", ""},
	}
})

-- locked sign

minetest.register_craft({
	output = "locked_sign:sign_wall_locked",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "group:wood", "default:steel_ingot"},
		{"", "group:stick", ""},
	}
})

--Alternate recipe.

minetest.register_craft({
	output = "locked_sign:sign_wall_locked",
	recipe = {
		{ "default:sign_wall" },
		{ "default:steel_ingot" },
	},
})

-- craft recipes for the metal signs

minetest.register_craft({
	output = "signs:sign_wall_green 4",
	recipe = {
		{ "dye:dark_green", "dye:white", "dye:dark_green" },
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" }
	},
})

minetest.register_craft({
	output = "signs:sign_wall_yellow 4",
	recipe = {
		{ "dye:yellow", "dye:black", "dye:yellow" },
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" }
	},
})

minetest.register_craft({
	output = "signs:sign_wall_red 4",
	recipe = {
		{ "dye:red", "dye:white", "dye:red" },
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" }
	},
})

minetest.register_craft({
	output = "signs:sign_wall_white_red 4",
	recipe = {
		{ "dye:white", "dye:red", "dye:white" },
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" }
	},
})

minetest.register_craft({
	output = "signs:sign_wall_white_black 4",
	recipe = {
		{ "dye:white", "dye:black", "dye:white" },
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" }
	},
})

minetest.register_craft({
	output = "signs:sign_wall_orange 4",
	recipe = {
		{ "dye:orange", "dye:black", "dye:orange" },
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" }
	},
})

minetest.register_craft({
	output = "signs:sign_wall_blue 4",
	recipe = {
		{ "dye:blue", "dye:white", "dye:blue" },
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" }
	},
})

minetest.register_craft({
	output = "signs:sign_wall_brown 4",
	recipe = {
		{ "dye:brown", "dye:white", "dye:brown" },
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" }
	},
})
