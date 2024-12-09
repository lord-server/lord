local S = minetest.get_mod_translator()


minetest.override_item('vessels:steel_bottle', {
	description       = S('Steel Can'),
	drawtype          = 'mesh',
	mesh              = 'lord_vessels_steel_can.obj',
	tiles             = { 'lord_vessels_steel_can.png' },
	inventory_image   = '',
	wield_image       = 'lord_vessels_steel_can_wield.png',
	selection_box     = {
		type  = 'fixed',
		fixed = { -0.25, -0.5, -0.25, 0.25, 7/16, 0.25 }
	},
	paramtype         = 'light',
	paramtype2        = 'facedir',
	walkable          = true,
	groups            = { vessel = 1, cracky = 1, attached_node = 1 },
	is_ground_content = false,
})
