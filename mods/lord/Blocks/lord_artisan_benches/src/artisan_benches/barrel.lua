require('artisan_benches.legacy.lottpotion_recipe_system')

-- moved AS IS from lottpotion.

-- TODO: migrate to our crafts system (#1770)
lottpotion_recipe.register_type("brew", {
	description  = "Brewing",
	input_size   = 2,
	default_time = 60,
})

require('artisan_benches.barrel.nodes')

minetest.register_craft({
	output = ':lottpotion:brewer',
	recipe = {
		{ 'group:wood', 'group:wood', 'group:wood' },
		{ 'group:wood', '', 'group:wood' },
		{ 'group:wood', 'default:steel_ingot', 'group:wood' },
	}
})
