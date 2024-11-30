minetest.CraftMethod.POTION = 'potion'
minetest.register_craft_method(minetest.CraftMethod.POTION)

require('artisan_benches.laboratory.nodes')

minetest.register_craft({
	output = 'lottpotion:potion_brewer',
	recipe = {
		{ 'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot' },
		{ '', 'default:steel_ingot', '' },
		{ 'group:stone', 'group:stone', 'group:stone' },
	}
})
