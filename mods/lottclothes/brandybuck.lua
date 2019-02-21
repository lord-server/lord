local SL = lord.require_intllib()

-- basic outfit from the the brandybuck family.
-- made from blue flax and copper ingot.
-- hasn't got headwear.

-- shirt (torso)
minetest.register_tool("lottclothes:shirt_brandybuck", {
	description = SL("Brandybuck Shirt"),
	inventory_image = "lottclothes_inv_shirt_brandybuck.png",
	groups = {armor_torso=0, armor_heal=0, clothes=1},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:shirt_brandybuck",
	recipe = {
		{"lottclothes:flax_blue", "", "lottclothes:flax_blue"},
		{"lottclothes:flax_yellow", "lottclothes:flax_blue", "lottclothes:flax_yellow"},
		{"lottclothes:flax_yellow", "lottclothes:flax_blue", "lottclothes:flax_yellow"}
	}
})

-- trousers (legs)
minetest.register_tool("lottclothes:trousers_brandybuck", {
	description = SL("Brandybuck Trousers"),
	inventory_image = "lottclothes_inv_trousers_brandybuck.png",
	groups = {armor_legs=0, armor_heal=0, clothes=1},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:trousers_brandybuck",
	recipe = {
		{"lottclothes:flax_brown", "lottclothes:flax_brown", "lottclothes:flax_brown"},
		{"lottclothes:flax_brown", "" , "lottclothes:flax_brown"},
		{"lottclothes:flax_brown", "" , "lottclothes:flax_brown"}
	}
})

-- shoes (feet)
minetest.register_tool("lottclothes:shoes_brandybuck", {
	description = SL("Brandybuck Shoes"),
	inventory_image = "lottclothes_inv_shoes_brandybuck.png",
	groups = {armor_feet=0, armor_heal=0, clothes=1},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:shoes_brandybuck",
	recipe = {
		{"lottclothes:flax_blue", "", "lottclothes:flax_blue"},
		{"default:copper_ingot", "", "default:copper_ingot"}
	}
})
