local S = minetest.get_mod_translator()

minetest.register_craftitem('lottfarming:pumpkin_seed', {
	description     = S('Pumpkin seed'),
	inventory_image = 'lottfarming_pumpkin_seed.png',
	on_place        = function(itemstack, placer, pointed_thing)
		local target_position = pointed_thing.under
		local target_node  = minetest.get_node(target_position)
		if minetest.registered_nodes[target_node.name].on_rightclick then

			return minetest.registered_nodes[target_node.name].on_rightclick(
				target_position,
				target_node,
				placer,
				itemstack,
				pointed_thing
			)
		end

		return place_seed(itemstack, placer, pointed_thing, 'lottfarming:pumpkin_1')
	end,
})

minetest.register_node('lottfarming:pumpkin_1', {
	paramtype           = 'light',
	sunlight_propagates = true,
	drawtype            = 'nodebox',
	tiles               = {
		'lottfarming_pumpkin_top.png',
		'lottfarming_pumpkin_back.png',
		'lottfarming_pumpkin_side.png',
		'lottfarming_pumpkin_side.png',
		'lottfarming_pumpkin_side.png',
		'lottfarming_pumpkin_side.png',
	},
	drop        = '',
	node_box            = {
		type  = 'fixed',
		fixed = {
			{ -0.2, -0.5, -0.2, 0.2, -0.1, 0.2 }
		},
	},
	selection_box       = {
		type  = 'fixed',
		fixed = {
			{ -0.2, -0.5, -0.2, 0.2, -0.1, 0.2 }
		},
	},
	groups              = {
		choppy                    = 2,
		oddly_breakable_by_hand   = 2,
		flammable                 = 2,
		not_in_creative_inventory = 1,
		plant                     = 1,
	},
	sounds              = default.node_sound_wood_defaults(),
})

minetest.register_node('lottfarming:pumpkin_2', {
	paramtype           = 'light',
	sunlight_propagates = true,
	drawtype            = 'nodebox',
	tiles               = {
		'lottfarming_pumpkin_top.png',
		'lottfarming_pumpkin_back.png',
		'lottfarming_pumpkin_side.png',
		'lottfarming_pumpkin_side.png',
		'lottfarming_pumpkin_side.png',
		'lottfarming_pumpkin_side.png',
	},
	drop        = '',
	node_box            = {
		type  = 'fixed',
		fixed = {
			{ -0.35, -0.5, -0.35, 0.35, 0.2, 0.35 }
		},
	},
	selection_box       = {
		type  = 'fixed',
		fixed = {
			{ -0.35, -0.5, -0.35, 0.35, 0.2, 0.35 }
		},
	},
	groups              = {
		choppy                    = 2,
		oddly_breakable_by_hand   = 2,
		flammable                 = 2,
		not_in_creative_inventory = 1,
		plant                     = 1,
	},
	sounds              = default.node_sound_wood_defaults(),
})

minetest.register_node('lottfarming:pumpkin_3', {
	description = S('Pumpkin'),
	paramtype2  = 'facedir',
	tiles       = {
		'lottfarming_pumpkin_top.png',
		'lottfarming_pumpkin_back.png',
		'lottfarming_pumpkin_side.png',
		'lottfarming_pumpkin_side.png',
		'lottfarming_pumpkin_side.png',
		'lottfarming_pumpkin_side.png',
	},
	drop        = 'lottfarming:pumpkin_3',
	groups      = { choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, plant = 1 },
	sounds      = default.node_sound_wood_defaults(),
})

farming:add_plant('lottfarming:pumpkin_3', { 'lottfarming:pumpkin_1', 'lottfarming:pumpkin_2' }, 50, 20)
