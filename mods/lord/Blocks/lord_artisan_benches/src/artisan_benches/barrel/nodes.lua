local geometry         = require('artisan_benches.barrel.nodes.geometry')
local S                = minetest.get_mod_translator()


local machine_name = 'Barrel'

--- @class barrel.node.Form: fuel_device.node.Form
local Form = {
	get_spec = function(type, percent, item_percent)
		assert(type:is_one_of({ 'active', 'inactive' }))
		percent = percent or 0
		--item_percent = item_percent or 0

		local bubbles_image = type == 'inactive'
			and 'image[4,2;1,1;benches_barrel_form_bubble.png]'
			or  'image[4,2;1,1;benches_barrel_form_bubble.png^[lowpart:' .. (percent) .. ':benches_form_bubble.png]'


		return 'size[8,9]' ..
			'label[0,0;' .. S(machine_name) .. ']' ..
			bubbles_image ..
			'image[3,2;1,1;benches_form_arrow.png]' ..
			'image[5,2;1,1;benches_form_arrow.png]' ..
			'label[2.9,3.2;' .. S('Fuel:') .. ']' ..
			'list[current_name;fuel;4,3;1,1;]' ..
			'label[1,1.5;' .. S('Ingredients:') .. ']' ..
			'list[current_name;src;1,2;2,1;]' ..
			'label[6,1.5;' .. S('Result:') .. ']' ..
			'list[current_name;dst;6,2;1,2;]' ..
			'list[current_player;main;0,5;8,4;]' ..
			'listring[current_name;fuel]' ..
			'listring[current_player;main]' ..
			'listring[current_name;src]' ..
			'listring[current_player;main]' ..
			'listring[current_name;dst]' ..
			'listring[current_player;main]'
	end
}

fuel_device.register(
	S(machine_name),
	minetest.CraftMethod.BARREL,
	{
		inactive = {
			node_name  = ':lottpotion:brewer',
			definition = {
				drawtype                      = 'nodebox',
				tiles                         = { 'default_wood.png' },
				node_box                      = {
					type  = 'fixed',
					fixed = geometry.make_pipe(
						{
							{ f = 0.9,  h1 = -0.2,  h2 = 0.2,   b = 0 },
							{ f = 0.75, h1 = -0.50, h2 = -0.35, b = 0 },
							{ f = 0.75, h1 = 0.35,  h2 = 0.5,   b = 0 },
							{ f = 0.82, h1 = -0.35, h2 = -0.2,  b = 0 },
							{ f = 0.82, h1 = 0.2,   h2 = 0.35,  b = 0 },
							{ f = 0.75, h1 = 0.37,  h2 = 0.42,  b = 1 },
							{ f = 0.75, h1 = -0.42, h2 = -0.37, b = 1 },
						},
						0
					),
				},
				paramtype                     = 'light',
				groups                        = { choppy = 2, },
				sounds                        = default.node_sound_stone_defaults(),
				selection_box                 = {
					type  = 'fixed',
					fixed = { -0.3, -0.5, -0.3, 0.3, 0.35, 0.3 }
				},
			},
		},
		active = {
			node_name  = ':lottpotion:brewer_active',
			definition = {
				drawtype                      = 'nodebox',
				tiles                         = { 'default_wood.png' },
				node_box                      = {
					type  = 'fixed',
					fixed = geometry.make_pipe(
						{
							{ f = 0.9,  h1 = -0.2,  h2 = 0.2,   b = 0 },
							{ f = 0.75, h1 = -0.50, h2 = -0.35, b = 0 },
							{ f = 0.75, h1 = 0.35,  h2 = 0.5,   b = 0 },
							{ f = 0.82, h1 = -0.35, h2 = -0.2,  b = 0 },
							{ f = 0.82, h1 = 0.2,   h2 = 0.35,  b = 0 },
							{ f = 0.75, h1 = 0.37,  h2 = 0.42,  b = 1 },
							{ f = 0.75, h1 = -0.42, h2 = -0.37, b = 1 }
						},
						0
					),
				},
				paramtype                     = 'light',
				selection_box                 = {
					type  = 'fixed',
					fixed = { -0.3, -0.5, -0.3, 0.3, 0.35, 0.3 }
				},
				drop                          = 'lottpotion:brewer',
				groups                        = { cracky = 2, not_in_creative_inventory = 1 },
				sounds                        = default.node_sound_stone_defaults(),
			},
		}
	},
	Form,
	{ src = 2 }
)
