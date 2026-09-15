local S = core.get_mod_translator()

-- basic outfit from the the brandybuck family.
-- made from blue flax and copper ingot.
-- hasn't got headwear.


-- shirt (torso)
core.register_tool("lottclothes:shirt_brandybuck", {
	description = S("Brandybuck Shirt"),
	inventory_image = "lottclothes_inv_shirt_brandybuck.png",
	groups = {armor_torso=0, clothes=1, clothes_torso=1},
	wear = 0
})

core.register_craft({
	output = "lottclothes:shirt_brandybuck",
	recipe = {
		{"lottclothes:flax_blue", "", "lottclothes:flax_blue"},
		{"lottclothes:flax_yellow", "lottclothes:flax_blue", "lottclothes:flax_yellow"},
		{"lottclothes:flax_yellow", "lottclothes:flax_blue", "lottclothes:flax_yellow"}
	}
})

core.register_craft({
	output = 'lottclothes:flaxthread 8',
	recipe = {
		{'lottclothes:shirt_brandybuck'},
	}
})

-- trousers (legs)
core.register_tool("lottclothes:trousers_brandybuck", {
	description = S("Brandybuck Trousers"),
	inventory_image = "lottclothes_inv_trousers_brandybuck.png",
	groups = {armor_legs=0, clothes=1, clothes_legs=1},
	wear = 0
})


core.register_craft({
	output = "lottclothes:trousers_brandybuck",
	recipe = {
		{"lottclothes:flax_brown", "lottclothes:flax_brown", "lottclothes:flax_brown"},
		{"lottclothes:flax_brown", "" , "lottclothes:flax_brown"},
		{"lottclothes:flax_brown", "" , "lottclothes:flax_brown"}
	}
})

core.register_craft({
	output = 'lottclothes:flaxthread 7',
	recipe = {
		{'lottclothes:trousers_brandybuck'},
	}
})

-- shoes (feet)
core.register_tool("lottclothes:shoes_brandybuck", {
	description = S("Brandybuck Shoes"),
	inventory_image = "lottclothes_inv_shoes_brandybuck.png",
	groups = {armor_feet=0, clothes=1, clothes_feet=1},
	wear = 0
})

core.register_craft({
	output = "lottclothes:shoes_brandybuck",
	recipe = {
		{"lottclothes:flax_blue", "", "lottclothes:flax_blue"},
		{"default:copper_ingot", "", "default:copper_ingot"}
	}
})

core.register_craft({
	output = 'lottclothes:flaxthread 2',
	recipe = {
		{'lottclothes:shoes_brandybuck'},
	}
})
