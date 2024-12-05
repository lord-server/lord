local Form     = require('barrel.nodes.Form')
local geometry = require('barrel.nodes.geometry')
local S        = minetest.get_mod_translator()


local node_box = {
	type  = 'fixed',
	fixed = geometry.make_pipe(
		{
			{ f = 0.9,  h1 = -0.2,  h2 =  0.2,  b = 0 },
			{ f = 0.75, h1 = -0.50, h2 = -0.35, b = 0 },
			{ f = 0.75, h1 =  0.35, h2 =  0.5,  b = 0 },
			{ f = 0.82, h1 = -0.35, h2 = -0.2,  b = 0 },
			{ f = 0.82, h1 =  0.2,  h2 =  0.35, b = 0 },
			{ f = 0.75, h1 =  0.37, h2 =  0.42, b = 1 },
			{ f = 0.75, h1 = -0.42, h2 = -0.37, b = 1 },
		},
		0
	),
}
local selection_box = {
	type  = 'fixed',
	fixed = { -0.3, -0.5, -0.3, 0.3, 0.35, 0.3 }
}
local common_node_definition = {
	drawtype      = 'nodebox',
	tiles         = { 'default_wood.png' },
	node_box      = node_box,
	selection_box = selection_box,
	paramtype     = 'light',
	sounds        = default.node_sound_stone_defaults(),
	groups        = { choppy = 2, },
}

fuel_device.register(
	S('Barrel'),
	minetest.CraftMethod.BARREL,
	{
		inactive = {
			node_name  = 'barrel:barrel',
			definition = table.merge(common_node_definition, {}),
		},
		active = {
			node_name  = 'barrel:barrel_active',
			definition = table.merge(common_node_definition, {
				drop   = 'barrel:barrel',
				groups = { not_in_creative_inventory = 1 },
			}),
		}
	},
	Form,
	{ src = 2 }
)
