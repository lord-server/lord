local func = require('music_instruments.func')
local config = require('music_instruments.config')


--- Изменяет тон ноды
--- @param pos Position
--- @param delta number Шаг изменения (1 или -1)
local function adjust_semitones(pos, delta)
	local meta = minetest.get_meta(pos)
	local instrument_id = meta:get_string('instrument')
	local current = meta:get_int('semitones')
	local new_offset = math.clamp(current + delta, config.min_offset, config.max_offset)

	func.update_node(pos, instrument_id, new_offset)
	func.play_sound(pos, instrument_id, new_offset)
end

minetest.register_tool('music_instruments:pitch_adjuster', {
	description = 'Регулятор тона',
	inventory_image = 'default_tool_steelaxe.png',

	on_use = function(_, _, pointed_thing)
	if pointed_thing.type == 'node' then
		adjust_semitones(pointed_thing.under, 1)
		end
	end,

	on_place = function(_, _, pointed_thing)
	if pointed_thing.type == 'node' then
		adjust_semitones(pointed_thing.under, -1)
		end
	end
})
