local S = minetest.get_mod_translator()

local cauldron = require('cauldron.usage')


minetest.override_item('vessels:drinking_glass', {
	on_use          = function(itemstack, user, pointed_thing)
		local pos = pointed_thing.above
		if pos == nil then return itemstack end
		pos.y = pos.y - 1

		return cauldron.fill_from(pos, itemstack, user, 'lord_vessels:drinking_glass_water')
	end
})

minetest.register_node('lord_vessels:drinking_glass_water', {
	description       = S('Drinking Glass (Water)'),
	inventory_image   = 'lottpotion_glass_water.png',
	wield_image       = 'lottpotion_glass_water.png',
	drawtype          = 'plantlike',
	paramtype         = 'light',
	tiles             = { 'lottpotion_glass_water.png' },
	selection_box     = {
		type  = 'fixed',
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.4, 0.25 }
	},
	groups            = { vessel = 1, dig_immediate = 3, attached_node = 1 },
	is_ground_content = false,
	walkable          = false,
	sounds            = default.node_sound_glass_defaults(),
})
