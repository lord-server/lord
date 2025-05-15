local music_node = require('music_instruments.music_node')
local config = require('music_instruments.music_node.config')


--- Изменяет тон ноды
--- @param pos Position
--- @param delta number Шаг изменения (1 или -1)
local function adjust_semitones(pos, delta)
	local meta = minetest.get_meta(pos)
	local instrument_id = meta:get_string('instrument')
	local current = meta:get_int('semitones')
	local new_offset = math.clamp(current + delta, config.min_offset, config.max_offset)

	music_node.update_node(pos, instrument_id, new_offset)
	music_node.play_sound(pos, instrument_id, new_offset)
end

minetest.register_tool('music_instruments:pitch_adjuster', {
	description = 'Регулятор тона',
	inventory_image = 'default_tool_steelaxe.png',

	--- @param itemstack ItemStack
	--- @param user Player
	---- @param pointed_thing PointedThing
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type == 'node' then
			local node_name = minetest.get_node(pointed_thing.under).name
			if string.find(node_name, 'music_instruments') then
				adjust_semitones(pointed_thing.under, 1)
			end
		end
	end,

    --- @param itemstack ItemStack
    --- @param user Player
    ---- @param pointed_thing PointedThing
	on_place = function(itemstack, user, pointed_thing)
		if pointed_thing.type == 'node' then
			local node_name = minetest.get_node(pointed_thing.under).name
			if string.find(node_name, 'music_instruments') then
				adjust_semitones(pointed_thing.under, -1)
			end
		end

		return itemstack
	end
})
