local func = require('music_instruments.func')
local config = require('music_instruments.config')


for instrument_id, def in pairs(config.instruments) do
	minetest.register_node('music_instruments:'..instrument_id, {
		description = def.description,
		tiles = def.tiles,
		groups = {choppy = 2},

		on_construct = function(pos)
		func.update_node(pos, instrument_id, 0)
		end,

		on_punch = function(pos)
		local meta = minetest.get_meta(pos)
		func.play_sound(
			pos,
			meta:get_string('instrument'),
			meta:get_int('semitones')
		)
		end,

		on_rightclick = function(pos)
		local meta = minetest.get_meta(pos)
		func.play_sound_long(
			pos,
			meta:get_string('instrument'),
			meta:get_int('semitones')
		)
		end,
	})
end
