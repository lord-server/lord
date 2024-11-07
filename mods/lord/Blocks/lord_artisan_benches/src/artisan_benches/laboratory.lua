require('artisan_benches.legacy.lottpotion_recipe_system')

-- moved AS IS from lottpotion.

-- TODO: migrate to our crafts system (#1770)
lottpotion_recipe.register_type('potion', {
	description  = 'Potion Brewing',
	input_size   = 2,
	default_time = 120,
})

require('artisan_benches.laboratory.nodes')

minetest.register_craft({
	output = 'lottpotion:potion_brewer',
	recipe = {
		{ 'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot' },
		{ '', 'default:steel_ingot', '' },
		{ 'group:stone', 'group:stone', 'group:stone' },
	}
})
