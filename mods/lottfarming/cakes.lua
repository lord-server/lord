local SL = lord.require_intllib()

minetest.register_craftitem("lottfarming:berry_cake", {
	description = SL("Berry Cake"),
	inventory_image = "lottfarming_berry_cake.png",
	on_use = minetest.item_eat(3),
})

minetest.register_craftitem("lottfarming:honey_cake", {
	description = SL("Honey Cake"),
	inventory_image = "lottfarming_honey_cake.png",
	on_use = minetest.item_eat(3),
})

minetest.register_craft({
	output = "lottfarming:honey_cake",
	recipe = {
		{"lottfarming:sugar"},
		{"bees:bottle_honey"},
		{"lottfarming:biscuit"},
	},
	replacements = {{"bees:bottle_honey", "vessels:glass_bottle"}},
})

minetest.register_craft({
	output = "lottfarming:berry_cake",
	recipe = {
		{"lottfarming:sugar"},
		{"lottfarming:berries"},
		{"lottfarming:biscuit"},
	}
})
