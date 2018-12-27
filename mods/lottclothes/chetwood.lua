local SL = lord.require_intllib()

-- basic outfit from the chetwood forest.
-- made from green and brown felt & tin ingot.

-- cap (head)
minetest.register_tool("lottclothes:cap_chetwood", {
	description = SL("Chetwood Cap"),
	inventory_image = "lottclothes_inv_cap_chetwood.png",
	groups = {armor_head=0, armor_heal=0, clothes=1},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:cap_chetwood",
	recipe = {
		{"lottclothes:felt_green", "lottclothes:felt_green", "lottclothes:felt_green"},
		{"lottores:tin_ingot", "", "lottores:tin_ingot"},
		{"", "",""}
	}
})

-- jacket (torso)
minetest.register_tool("lottclothes:jacket_chetwood", {
	description = SL("Chetwood Jacket"),
	inventory_image = "lottclothes_inv_jacket_chetwood.png",
	groups = {armor_torso=0, armor_heal=0, clothes=1},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:jacket_chetwood",
	recipe = {
		{"lottclothes:felt_green", "", "lottclothes:felt_green"},
		{"lottores:tin_ingot", "lottclothes:felt_green", "lottores:tin_ingot"},
		{"lottores:tin_ingot", "lottclothes:felt_green", "lottores:tin_ingot"}
	}
})

-- pants (legs)
minetest.register_tool("lottclothes:pants_chetwood", {
	description = SL("Chetwood Pants"),
	inventory_image = "lottclothes_inv_pants_chetwood.png",
	groups = {armor_legs=0, armor_heal=0, clothes=1},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:pants_chetwood",
	recipe = {
		{"lottclothes:felt_green", "lottclothes:felt_green", "lottclothes:felt_green"},
		{"lottores:tin_ingot", "" , "lottores:tin_ingot"},
		{"lottores:tin_ingot", "" , "lottores:tin_ingot"}
	}
})

-- boots (feet)
minetest.register_tool("lottclothes:boots_chetwood", {
	description = SL("Chetwood Boots"),
	inventory_image = "lottclothes_inv_boots_chetwood.png",
	groups = {armor_feet=0, armor_heal=0, clothes=1},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:boots_chetwood",
	recipe = {
		{"lottclothes:felt_brown", "", "lottclothes:felt_brown"},
		{"lottores:tin_ingot", "", "lottores:tin_ingot"}
	}
})
