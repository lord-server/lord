
lottpotion.register_recipe_type("potion", {
	description  = "Potion Brewing",
	input_size   = 2,
	default_time = 120,
})
dofile(minetest.get_modpath("lottpotion").."/benches/laboratory/ingredients.lua")
dofile(minetest.get_modpath("lottpotion").."/benches/laboratory/potions_recipes.lua")

dofile(minetest.get_modpath("lottpotion").."/benches/laboratory/nodes.lua")
minetest.register_craft({
	output = 'lottpotion:potion_brewer',
	recipe = {
		{ 'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot' },
		{ '', 'default:steel_ingot', '' },
		{ 'group:stone', 'group:stone', 'group:stone' },
	}
})
