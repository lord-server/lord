local Form = require("artisan_benches.anvil.Form")


local S = minetest.get_translator('lord_artisan_benches')

minetest.CraftMethod.ANVIL = 'anvil'
minetest.register_craft_method(minetest.CraftMethod.ANVIL)

Form:register()

minetest.register_node('lord_artisan_benches:anvil', {
	drawtype    = 'nodebox',
	description = S('Anvil'),
	tiles       = { 'benches_anvil.png' },
	groups      = { cracky = 2, falling_node = 1 },
	paramtype   = 'light',
	paramtype2  = 'facedir',
	node_box    = {
		type  = 'fixed',
		fixed = {
			{ -0.5, -0.5, -0.3, 0.5, -0.3, 0.3 },
			{ -0.4, -0.5, -0.4, 0.4, -0.3, 0.4 },
			{ -0.3, -0.5, -0.5, 0.3, -0.3, 0.5 },
			{ -0.4, -0.3, -0.4, -0.1, -0.2, -0.1 },
			{ -0.4, -0.3, 0.4, -0.1, -0.2, 0.1 },
			{ 0.4, -0.3, 0.4, 0.1, -0.2, 0.1 },
			{ 0.4, -0.3, -0.4, 0.1, -0.2, -0.1 },
			{ -0.3, -0.2, -0.3, 0.3, -0.1, 0.3 },
			{ -0.2, -0.1, -0.2, 0.2, 0.1, 0.2 },
			{ -0.3, 0.1, -0.25, 0.3, 0.5, 0.25 },
			{ -0.4, 0.1, -0.15, -0.3, 0.5, 0.15 },
			{ -0.4, 0.15, -0.2, -0.3, 0.45, 0.2 },
			{ -0.5, 0.15, -0.1, -0.4, 0.45, 0.1 },
			{ -0.5, 0.2, -0.15, -0.4, 0.4, 0.15 },
			{ -0.6, 0.25, -0.05, -0.5, 0.45, 0.05 },
			{ -0.6, 0.3, -0.1, -0.5, 0.4, 0.1 },
			{ -0.7, 0.35, -0.05, -0.6, 0.45, 0.05 },
			{ 0.3, 0.1, -0.2, 0.4, 0.5, 0.2 },
			{ 0.4, 0.2, -0.15, 0.5, 0.5, 0.15 },
			{ 0.5, 0.3, -0.1, 0.6, 0.5, 0.1 },
			{ 0.6, 0.4, -0.05, 0.7, 0.5, 0.05 },
		},
	},
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		Form:new(clicker, pos):open()
	end
})

minetest.register_craft({
	output = 'lord_artisan_benches:anvil',
	recipe = {
		{ 'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot' },
		{ '', 'default:steel_ingot', '' },
		{ 'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot' },
	}
})
