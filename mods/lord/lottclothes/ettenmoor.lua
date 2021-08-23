local SL = lord.require_intllib()

-- outfit from the ettenmoor region. wizard style (as possible).
-- made from grey and brown felt & gold ingot.
-- it's difficult to make because dye:brown, dye:grey and lottores:gold.
-- hasn't got boots.

local level=4

-- hood (head)
minetest.register_tool("lottclothes:hood_ettenmoor", {
	description = SL("Ettenmoor Hood"),
	inventory_image = "lottclothes_inv_hood_ettenmoor.png",
	groups = {armor_head=0, armor_heal=0, clothes=1, clothes_head=1},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:hood_ettenmoor",
	recipe = {
		{"lottclothes:felt_grey", "lottclothes:felt_grey", "lottclothes:felt_grey"},
		{"lottclothes:felt_grey", "", "lottclothes:felt_grey"},
		{"", "",""}
	}
})

minetest.register_craft({
	output = 'lottclothes:feltthread 5',
	recipe = {
		{'lottclothes:hood_ettenmoor'},
	}
})

-- robe (torso (yeah limitations suck))
minetest.register_tool("lottclothes:robe_ettenmoor", {
	description = SL("Ettenmoor Robe"),
	inventory_image = "lottclothes_inv_robe_ettenmoor.png",
	groups = {armor_torso=0, armor_heal=0, clothes=1, clothes_torso=1},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:robe_ettenmoor",
	recipe = {
		{"lottclothes:felt_grey", "", "lottclothes:felt_grey"},
		{"lottclothes:felt_grey", "lottclothes:felt_grey", "lottclothes:felt_grey"},
		{"lottclothes:felt_brown", "default:gold_ingot", "lottclothes:felt_brown"}
	}
})

minetest.register_craft({
	output = 'lottclothes:feltthread 7',
	recipe = {
		{'lottclothes:robe_ettenmoor'},
	}
})

-- trousers (legs)
minetest.register_tool("lottclothes:trousers_ettenmoor", {
	description = SL("Ettenmoor Trousers"),
	inventory_image = "lottclothes_inv_trousers_ettenmoor.png",
	groups = {armor_legs=0, armor_heal=0, clothes=1, clothes_legs=1},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:trousers_ettenmoor",
	recipe = {
		{"lottclothes:felt_grey", "lottclothes:felt_grey", "lottclothes:felt_grey"},
		{"lottclothes:felt_grey", "" , "lottclothes:felt_grey"},
		{"lottclothes:felt_grey", "" , "lottclothes:felt_grey"}
	}
})

minetest.register_craft({
	output = 'lottclothes:feltthread 7',
	recipe = {
		{'lottclothes:trousers_ettenmoor'},
	}
})
