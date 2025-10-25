local S = minetest.get_mod_translator()
local jack_o_lantern_color_description = minetest.colorize('#B380FF',
	S('Jack-o-lantern') .. '\n' ..
	S('Halloween сollection')

)

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
		if node.name == 'halloween:jack_o_lantern_unlit' then
			minetest.swap_node(pos, { name = 'halloween:jack_o_lantern', param2 = node.param2 })
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
		if node.name == 'halloween:jack_o_lantern' then
			minetest.swap_node(pos, { name = 'halloween:jack_o_lantern_unlit', param2 = node.param2 })
		end
	end
end

local function jack_o_lantern()
	minetest.register_node('halloween:jack_o_lantern', {
		description         = jack_o_lantern_color_description,
		light_source        = 12,
		tiles               = {
			'lottfarming_pumpkin_top.png',
			'lottfarming_pumpkin_back.png',
			'lottfarming_pumpkin_side.png',
			'lottfarming_pumpkin_side.png',
			'lottfarming_pumpkin_side.png',
			'lottfarming_pumpkin_side.png^jack_o_lantern_ignite.png',
		},
		groups              = { choppy = 2, oddly_breakable_by_hand = 1, flammable = 2 },
		paramtype           = 'light',
		paramtype2          = 'facedir',
		sounds              = default.node_sound_wood_defaults(),

		on_rightclick       = function(pos, node, clicker, pointed_thing)
			extinguish(pos, node, clicker, pointed_thing)
		end,
	})

	minetest.register_node('halloween:jack_o_lantern_unlit', {
		description         = jack_o_lantern_color_description,
		tiles               = {
			'lottfarming_pumpkin_top.png',
			'lottfarming_pumpkin_back.png',
			'lottfarming_pumpkin_side.png',
			'lottfarming_pumpkin_side.png',
			'lottfarming_pumpkin_side.png',
			'lottfarming_pumpkin_side.png^jack_o_lantern_unlit.png',
		},
		groups              = { choppy = 2, oddly_breakable_by_hand = 1, flammable = 2 },
		paramtype           = 'light',
		paramtype2          = 'facedir',
		sounds              = default.node_sound_wood_defaults(),
		drop                = 'halloween:jack_o_lantern',

		on_punch            = function(pos, node, puncher, pointed_thing)
			ignite(pos, node, puncher, pointed_thing)
		end,
	})

	minetest.register_craft({
		output = 'halloween:jack_o_lantern',
		recipe = {
			{ 'default:torch', 'default:torch',         'default:torch' },
			{ 'default:torch', 'lottfarming:pumpkin_3', 'default:torch' },
			{ 'default:torch', 'default:torch',         'default:torch' },
		},
	})
end


return {
	register = jack_o_lantern,
}
