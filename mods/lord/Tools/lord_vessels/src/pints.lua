local S = minetest.get_mod_translator()


minetest.register_node('lord_vessels:pint_wood', {
	description = S('Pint'),
	drawtype    = 'mesh',
	mesh        = 'lord_vessels_pint.obj',
	tiles       = { 'lord_vessels_pint_wood.png' },
	selection_box   = {
		type  = 'fixed',
		fixed = { -0.2, -0.5, -0.2, 0.2, 0.0, 0.2 }
	},
	paramtype   = 'light',
	paramtype2  = 'facedir',
	walkable    = false,
})

minetest.register_craft({
	output = 'lord_vessels:pint_wood',
	recipe = {
		{ 'default:wood', '',             'default:wood' },
		{ 'default:wood', '',             'default:wood' },
		{ 'default:wood', 'default:wood', 'default:wood' },
	}
})
