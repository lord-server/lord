local S = minetest.get_mod_translator()

local cauldron = require('cauldron.usage')


minetest.override_item('vessels:glass_bottle', {
	selection_box = {
		type  = 'fixed',
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.4, 0.25 }
	},
	on_use        = function(itemstack, user, pointed_thing)
		local pos = pointed_thing.above
		if pos == nil then return itemstack end
		pos.y = pos.y - 1

		return cauldron.fill_from(pos, itemstack, user, 'lord_vessels:glass_bottle_water')
	end
})

local glass_bottle_water_texture = 'vessels_glass_bottle.png^lottpotion_water.png'
minetest.register_node('lord_vessels:glass_bottle_water', {
	description     = S('Glass Bottle (Water)'),
	drawtype        = 'plantlike',
	tiles           = { glass_bottle_water_texture },
	inventory_image = glass_bottle_water_texture,
	wield_image     = glass_bottle_water_texture,
	paramtype       = 'light',
	walkable        = false,
	selection_box   = {
		type  = 'fixed',
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.4, 0.25 }
	},
	groups          = { vessel = 1, dig_immediate = 3, attached_node = 1 },
	sounds          = default.node_sound_glass_defaults(),
})

local glass_bottle_salt_texture = 'lord_vessels_salt_bottle.png'
minetest.register_node('lord_vessels:glass_bottle_salt', {
	description     = S('Glass Bottle (Salt)'),
	drawtype        = 'plantlike',
	tiles           = { glass_bottle_salt_texture },
	inventory_image = glass_bottle_salt_texture,
	wield_image     = glass_bottle_salt_texture,
	paramtype       = 'light',
	walkable        = false,
	selection_box   = {
		type  = 'fixed',
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.4, 0.25 }
	},
	groups          = { vessel = 1, dig_immediate = 3, attached_node = 1 },
	sounds          = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	type = 'cooking',
	cooktime = 5,
	output = 'lord_vessels:glass_bottle_salt',
	recipe = 'lord_vessels:glass_bottle_water'
})

minetest.register_craft({
	type = 'shapeless',
	output = 'lottores:salt 5',
	recipe = {'lord_vessels:glass_bottle_salt'},
	replacements = {{'', 'vessels:glass_bottle'}},
})

minetest.register_craft({
	output = 'lord_vessels:glass_bottle_salt',
	recipe = {
		{'lottores:salt', 'lottores:salt', 'lottores:salt'},
		{'lottores:salt', 'vessels:glass_bottle', 'lottores:salt'},
		{'', '', ''},
	}
})
