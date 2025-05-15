local music_node = require('music_instruments.music_node')
local config = require('music_instruments.music_node.config')


for instrument_id, def in pairs(config.instruments) do
	minetest.register_node('music_instruments:' .. instrument_id, {
		description = def.description,
		drawtype = def.drawtype,
		mesh = def.mesh,
		tiles = def.tiles,
		--paramtype = 'light',
		--paramtype2 = 'facedir',
		groups = { choppy = 2 },

		on_construct = function(pos)
			music_node.update_node(pos, instrument_id, 0)
		end,

		on_punch = function(pos)
			local meta = minetest.get_meta(pos)
				music_node.play_sound(
					pos,
					meta:get_string('instrument'),
					meta:get_int('semitones')
				)
			return nil
		end,

		on_rightclick = function(pos)
			local meta = minetest.get_meta(pos)
				music_node.play_sound(
					pos,
					meta:get_string('instrument'),
					meta:get_int('semitones')
				)
			return nil
		end,
	})
end
