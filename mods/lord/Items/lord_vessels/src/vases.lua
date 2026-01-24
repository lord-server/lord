local S = minetest.get_mod_translator()


local px = 1/16

minetest.register_craftitem('lord_vessels:vase_1_raw', {
	description     = S('Raw Ceramic Vase'),
	inventory_image = 'lord_vessels_vase_1_raw_inv.png',
})

minetest.register_node('lord_vessels:vase_1', {
	description       = S('Ceramic Vase'),
	inventory_image   = 'lord_vessels_vase_1_inv.png',
	drawtype          = 'mesh',
	mesh              = 'lord_vessels_vase_1.obj',
	tiles             = { 'lord_vessels_vase_1.png' },
	selection_box     = {
		type  = 'fixed',
		fixed = { -5*px, -8*px, -5*px, 5*px, 6*px, 5*px }
	},
	paramtype2        = 'facedir',
	walkable          = true,
	groups            = { vessel = 1, oddly_breakable_by_hand = 3, cracky = 3, attached_node = 1, },
	is_ground_content = false,
})


minetest.register_craftitem('lord_vessels:vase_2_raw', {
	description     = S('Raw Ceramic Vase with Handles'),
	inventory_image = 'lord_vessels_vase_2_raw_inv.png',
})

minetest.register_node('lord_vessels:vase_2', {
	description       = S('Ceramic Vase with Handles'),
	inventory_image   = 'lord_vessels_vase_2_inv.png',
	drawtype          = 'mesh',
	mesh              = 'lord_vessels_vase_2.obj',
	tiles             = { 'lord_vessels_vase_2.png' },
	selection_box     = {
		type  = 'fixed',
		fixed = { -4*px, -8*px, -4*px, 4*px, 8*px, 4*px }
	},
	paramtype         = 'light',
	paramtype2        = 'facedir',
	walkable          = true,
	groups            = { vessel = 1, oddly_breakable_by_hand = 3, cracky = 3, attached_node = 1, },
	is_ground_content = false,
})

minetest.register_craft({
	output = 'lord_vessels:vase_1_raw',
	recipe = {
		{ ''                              , 'lord_homedecor:terracotta_base', ''                               },
		{ 'lord_homedecor:terracotta_base', ''                              , 'lord_homedecor:terracotta_base' },
		{ 'lord_homedecor:terracotta_base', 'lord_homedecor:terracotta_base', 'lord_homedecor:terracotta_base' },
	},
})
minetest.register_craft({
	type     = minetest.CraftType.COOKING,
	output   = 'lord_vessels:vase_1',
	recipe   = 'lord_vessels:vase_1_raw',
	cooktime = 60,
})

minetest.register_craft({
	output = 'lord_vessels:vase_2_raw',
	recipe = {
		{ ''                              , ''                        , ''                               },
		{ 'lord_homedecor:terracotta_base', 'lord_vessels:vase_1_raw' , 'lord_homedecor:terracotta_base' },
		{ ''                              , ''                        , ''                               },
	},
})
minetest.register_craft({
	type     = minetest.CraftType.COOKING,
	output   = 'lord_vessels:vase_2',
	recipe   = 'lord_vessels:vase_2_raw',
	cooktime = 60,
})
