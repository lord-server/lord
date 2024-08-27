local S = minetest.get_translator("lottfarming")

minetest.register_craftitem("lottfarming:vegetable_oil", {
	description = S("Vegetable Oil"),
	inventory_image = "lottfarming_vegetable_oil.png",
})

minetest.register_craft( {
	output = "lottfarming:vegetable_oil",
	recipe = {
		{"farming:seed_wheat", "farming:seed_wheat",   "farming:seed_wheat"},
		{"farming:seed_wheat", "farming:seed_wheat",   "farming:seed_wheat"},
		{"farming:seed_wheat", "vessels:glass_bottle", "farming:seed_wheat"}
	}
})