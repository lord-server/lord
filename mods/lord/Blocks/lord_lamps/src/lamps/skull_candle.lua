local S = minetest.get_mod_translator()


local function register_skull_candle()

	local skull_candle_description = S('Skull Candle')
	local selection_box = {
		{ -0.1875, -0.5, 0.1875, 0.1875, 0.0, -0.1875 },
	}

	minetest.register_node('lord_lamps:skull_candle', {
		description       = skull_candle_description,
		drawtype          = 'mesh',
		paramtype         = 'light',
		paramtype2        = 'facedir',
		mesh              = 'lord_lamps_skull_candle.obj',
		tiles             = {
			'skull_front.png',
			'skull.png',
			'homedecor_candle_sides.png',
			{
				name = 'homedecor_candle_flame.png',
				animation = {
					type = 'vertical_frames',
					aspect_w = 16,
					aspect_h = 16,
					length = 3.0,
				},
			},
		},
		use_texture_alpha = 'clip',
		walkable          = true,
		light_source      = default.LIGHT_MAX - 6,
		selection_box       = {
			type  = 'fixed',
			fixed = selection_box,
		},
		collision_box       = {
			type  = 'fixed',
			fixed = selection_box,
		},
		groups            = { oddly_breakable_by_hand = 3 },
	})

	minetest.register_craft({
		output = 'lord_lamps:skull_candle',
		recipe = {
			{ '' },
			{ 'lord_homedecor:candle_thin' },
			{ 'remains:ancient_miner' },
		},
	})
end


return {
	register = register_skull_candle,
}
