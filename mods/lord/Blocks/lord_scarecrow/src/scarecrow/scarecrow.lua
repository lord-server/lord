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

	-- Функция зажигания фонаря при ударе факелом
	local ignite = function(pos, node, puncher, pointed_thing)
		if not puncher then
			return
		end
		local player_name = puncher:get_player_name()

		if player_name and minetest.is_protected(pos, player_name) then
			return
		end
		-- Проверка факела в руке
		local wielded_item = puncher:get_wielded_item()
		local item_name = wielded_item:get_name()

		if item_name == 'default:torch' then
			-- Проверка незажженного фонаря
			if node.name == 'lord_scarecrow:scarecrow' then
				minetest.swap_node(pos, { name = 'lord_scarecrow:scarecrow_halloween', param2 = node.param2 })
			end
		end
	end

	-- Функция для гашения фонаря
	local extinguish = function(pos, node, clicker, pointed_thing)
		if not clicker then
			return
		end
		local player_name = clicker:get_player_name()

		if player_name and minetest.is_protected(pos, player_name) then
			return
		end
		-- Проверка пустой руки
		local wielded_item = clicker:get_wielded_item()
		local item_name = wielded_item:get_name()

		if item_name == '' then
			-- Если фонарь зажжен - гасим его
			if node.name == 'lord_scarecrow:scarecrow_halloween' then
				minetest.swap_node(pos, { name = 'lord_scarecrow:scarecrow', param2 = node.param2 })
			end
		end
	end


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

		on_punch            = function(pos, node, puncher, pointed_thing)
			ignite(pos, node, puncher, pointed_thing)
		end,
	})

	minetest.register_node('lord_scarecrow:scarecrow_halloween', {
		description         = scarecrow_halloween_color_description,
		paramtype           = 'light',
		paramtype2          = 'facedir',
		sunlight_propagates = true,
		light_source        = 12,
		drawtype            = 'mesh',
		mesh                = 'lord_scarecrow_scarecrow.obj',
		tiles               = { 'lord_scarecrow_scarecrow.png^lord_scarecrow_ignite.png' },
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
		drop                = 'lord_scarecrow:scarecrow',

		on_rightclick       = function(pos, node, clicker, pointed_thing)
			extinguish(pos, node, clicker, pointed_thing)
		end,
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
