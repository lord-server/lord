local S = minetest.get_mod_translator()


--- Функция зажигания фонаря при ударе факелом
--- @param pos           Position
--- @param node          NodeTable
--- @param puncher       (Player|ObjectRef)?
--- @param pointed_thing pointed_thing
local function ignite(pos, node, puncher, pointed_thing)
	if not puncher or not puncher:is_player() then
		return
	end
	--- @cast puncher Player -- мы выше проверили, что это игрок
	local player_name = puncher:get_player_name()

	if player_name and minetest.is_protected(pos, player_name) then
		return
	end
	-- Проверка факела в руке
	if puncher:get_wielded_item():get_name() == 'default:torch' then
		-- Проверка незажженного фонаря
		if node.name == 'halloween:jack_o_lantern_unlit' then
			minetest.swap_node(pos, { name = 'halloween:jack_o_lantern', param2 = node.param2 })
		end
	end
end

--- Функция для гашения фонаря
--- @param pos           Position
--- @param node          NodeTable
--- @param clicker       Player
local function extinguish(pos, node, clicker)
	if not clicker then
		return
	end
	local player_name = clicker:get_player_name()

	if player_name and minetest.is_protected(pos, player_name) then
		return
	end
	-- Проверка пустой руки
	if clicker:get_wielded_item():get_name() == '' then
		-- Если фонарь зажжен - гасим его
		if node.name == 'halloween:jack_o_lantern' then
			minetest.swap_node(pos, { name = 'halloween:jack_o_lantern_unlit', param2 = node.param2 })
		end
	end
end

local function register_jack_o_lantern_nodes()
	local jack_o_lantern_color_description = S('Jack-o-lantern') .. '\n' .. S('Halloween сollection')

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

		on_rightclick       = function(pos, node, clicker, itemstack, pointed_thing)
			extinguish(pos, node, clicker)

			return itemstack
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
	register = register_jack_o_lantern_nodes,
}
