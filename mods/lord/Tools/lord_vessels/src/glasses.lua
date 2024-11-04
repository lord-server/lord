local S = minetest.get_mod_translator()

local cauldron = require('cauldron.usage')
local px = 1/16

minetest.override_item('vessels:drinking_glass', {
	on_use           = function(itemstack, user, pointed_thing)
		local pos = pointed_thing.above
		if pos == nil then return itemstack end
		pos.y = pos.y - 1

		return cauldron.fill_from(pos, itemstack, user, 'lord_vessels:drinking_glass_water')
	end,
	use_texture_alpha = 'blend',
	visual_scale      = 0.8,
	selection_box     = {
		type  = 'fixed',
		fixed = { -2.2*px, -8*px, -2.2*px, 2.2*px, 0, 2.2*px } -- 2.2 cause of visual_scale=0.8
	},
})

minetest.register_node('lord_vessels:drinking_glass_water', {
	description       = S('Drinking Glass (Water)'),
	inventory_image   = 'lord_vessels_glass_water.png^vessels_drinking_glass_inv.png',
	wield_image       = 'lord_vessels_glass_water.png^vessels_drinking_glass_inv.png',
	drawtype          = 'plantlike',
	paramtype         = 'light',
	tiles             = { 'lord_vessels_glass_water.png^(vessels_drinking_glass.png^[opacity:200)^[opacity:200' },
	use_texture_alpha = 'blend',
	visual_scale      = 0.8,
	selection_box     = {
		type  = 'fixed',
		fixed = { -3*px, -8*px, -3*px, 3*px, 0, 3*px }
	},
	groups            = { vessel = 1, dig_immediate = 3, attached_node = 1 },
	is_ground_content = false,
	walkable          = false,
	sounds            = default.node_sound_glass_defaults(),
})
