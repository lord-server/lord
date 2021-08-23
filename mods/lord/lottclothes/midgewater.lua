local SL = lord.require_intllib()

-- the simplest outfit available.
-- made from green felt & wood (just cut down the nearest tree).

local level=1

-- cap (head)
minetest.register_tool("lottclothes:cap_midgewater", {
	description = SL("Midgewater Cap"),
	inventory_image = "lottclothes_inv_cap_midgewater.png",
	groups = {armor_head=0, armor_heal=0, clothes=1, clothes_head=1},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:cap_midgewater",
	recipe = {
		{"lottclothes:felt_green", "lottclothes:felt_green", "lottclothes:felt_green"},
		{"lottclothes:felt_green", "", "lottclothes:felt_green"},
		{"", "",""}
	}
})

minetest.register_craft({
	output = 'lottclothes:feltthread 5',
	recipe = {
		{'lottclothes:cap_midgewater'},
	}
})

-- jacket (torso)
minetest.register_tool("lottclothes:jacket_midgewater", {
	description = SL("Midgewater Jacket"),
	inventory_image = "lottclothes_inv_jacket_midgewater.png",
	groups = {armor_torso=0, armor_heal=0, clothes=1, clothes_torso=1},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:jacket_midgewater",
	recipe = {
		{"lottclothes:felt_green", "", "lottclothes:felt_green"},
		{"lottclothes:felt_green", "lottclothes:felt_green", "lottclothes:felt_green"},
		{"lottclothes:felt_green", "lottclothes:felt_green", "lottclothes:felt_green"}
	}
})

minetest.register_craft({
	output = 'lottclothes:feltthread 8',
	recipe = {
		{'lottclothes:jacket_midgewater'},
	}
})

-- pants (legs)
minetest.register_tool("lottclothes:pants_midgewater", {
	description = SL("Midgewater Pants"),
	inventory_image = "lottclothes_inv_pants_midgewater.png",
	groups = {armor_legs=0, armor_heal=0, clothes=1, clothes_legs=1},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:pants_midgewater",
	recipe = {
		{"lottclothes:felt_green", "lottclothes:felt_green", "lottclothes:felt_green"},
		{"lottclothes:felt_green", "" , "lottclothes:felt_green"},
		{"lottclothes:felt_green", "" , "lottclothes:felt_green"}
	}
})

minetest.register_craft({
	output = 'lottclothes:feltthread 7',
	recipe = {
		{'lottclothes:pants_midgewater'},
	}
})

-- boots (feet)
minetest.register_tool("lottclothes:boots_midgewater", {
	description = SL("Midgewater Boots"),
	inventory_image = "lottclothes_inv_boots_midgewater.png",
	groups = {armor_feet=0, armor_heal=0, clothes=1, clothes_feet=1},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:boots_midgewater",
	recipe = {
		{"lottclothes:flax_brown", "", "lottclothes:flax_brown"},
		{"group:wood", "", "group:wood"}
	}
})

minetest.register_craft({
	output = 'lottclothes:flaxthread 2',
	recipe = {
		{'lottclothes:boots_midgewater'},
	}
})
