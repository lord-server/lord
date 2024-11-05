
lottpotion.register_recipe_type("brew", {
	description  = "Brewing",
	input_size   = 2,
	default_time = 60,
})
dofile(minetest.get_modpath("lottpotion").."/benches/barrel/alcohol_recipes.lua")


dofile(minetest.get_modpath("lottpotion").."/benches/barrel/nodes.lua")

minetest.register_craft({
	output = 'lottpotion:brewer',
	recipe = {
		{ 'group:wood', 'group:wood', 'group:wood' },
		{ 'group:wood', '', 'group:wood' },
		{ 'group:wood', 'default:steel_ingot', 'group:wood' },
	}
})
