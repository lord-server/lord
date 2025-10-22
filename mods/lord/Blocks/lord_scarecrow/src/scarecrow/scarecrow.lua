local S = minetest.get_mod_translator()


local function register_scarecrow()

	local scarecrow_halloween_color_description = minetest.colorize(
		'#B380FF',
		S('Jack Pumpkinhead') .. '\n' ..
		S('Halloween сollection')
	)
	local selection_box = {
		{ -0.0625, 0.8125, -0.0625, 0.0625, 0.875,  0.0625 },
		{ -0.25,   0.875,  -0.25,   0.25,   1.375,  0.25   },
		{ -0.1875, 1.375,  -0.1875, 0.1875, 1.5,    0.1875 },
		{ -0.8125, 0.6875, -0.0625, 0.8125, 0.8125, 0.0625 },
		{ -0.0625, -0.5,   -0.0625, 0.0625, 0.6875, 0.0625 },
	}

	minetest.register_node('lord_scarecrow:scarecrow', {
		description         = S('Scarecrow'),
		paramtype           = 'light',
		paramtype2          = 'facedir',
		sunlight_propagates = true,
		drawtype            = 'mesh',
		mesh                = 'lord_scarecrow_scarecrow.obj',
		tiles               = { 'lord_scarecrow_scarecrow.png' },
		use_texture_alpha   = 'clip',
		is_ground_content   = false,
		walkable            = true,
		selection_box       = {
			type  = 'fixed',
			fixed = selection_box,
		},
		collision_box       = {
			type  = 'fixed',
			fixed = selection_box,
		},
		groups              = {
			choppy                  = 1,
			oddly_breakable_by_hand = 1,
			flammable               = 2,
		},

		sounds              = default.node_sound_wood_defaults(),
	})

	minetest.register_node('lord_scarecrow:scarecrow_halloween', {
		description         = scarecrow_halloween_color_description,
		paramtype           = 'light',
		paramtype2          = 'facedir',
		sunlight_propagates = true,
		light_source        = 12,
		drawtype            = 'mesh',
		mesh                = 'lord_scarecrow_scarecrow.obj',
		tiles               = { 'lord_scarecrow_scarecrow.png^lord_scarecrow_lightning_face.png' },
		use_texture_alpha   = 'clip',
		is_ground_content   = false,
		walkable            = true,
		selection_box       = {
			type  = 'fixed',
			fixed = selection_box,
		},
		collision_box       = {
			type  = 'fixed',
			fixed = selection_box,
		},
		groups              = {
			choppy                  = 1,
			oddly_breakable_by_hand = 1,
			flammable               = 2,
		},

		sounds              = default.node_sound_wood_defaults(),
	})

	minetest.register_craft({
		output = 'lord_scarecrow:scarecrow',
		recipe = {
			{ '',            'farming:straw',                                 '' },
			{ 'group:stick', 'lottfarming:pumpkin_3', 'group:stick' },
			{ '',            'lottmobs:dirty_shirt',                          '' },
		},
	})
end


return {
	register = register_scarecrow,
}
