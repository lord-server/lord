minetest.clear_craft({output = "hopper:hopper"})

minetest.register_craft({
	output = "hopper:hopper",
	recipe = {
		{"lottores:lead_ingot", "carts:gear",  "lottores:lead_ingot"},
		{"lottores:lead_ingot", "default:chest", "lottores:lead_ingot"},
		{"", "lottores:lead_ingot", ""}
	}
})

minetest.register_craft({
	output = "hopper:hopper",
	recipe = {{"hopper:hopper_side"}}
})

minetest.clear_craft({output = "hopper:hopper_void"})

minetest.register_craft({
	output = "hopper:hopper_void",
	recipe = {
		{"lottores:lead_ingot", "carts:steam_mechanism",  "lottores:lead_ingot"},
		{"lottores:lead_ingot", "default:chest", "lottores:lead_ingot"},
		{"", "lottores:mithril_block", ""}
	}
})
