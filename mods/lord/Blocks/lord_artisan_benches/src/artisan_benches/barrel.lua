minetest.CraftMethod.BARREL = 'barrel'
minetest.register_craft_method(minetest.CraftMethod.BARREL)

require('artisan_benches.barrel.nodes')

minetest.register_craft({
	output = ':lottpotion:brewer',
	recipe = {
		{ 'group:wood', 'group:wood', 'group:wood' },
		{ 'group:wood', '', 'group:wood' },
		{ 'group:wood', 'default:steel_ingot', 'group:wood' },
	}
})
