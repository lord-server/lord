local MusicNodeHelper = require('music_instruments.music_node.MusicNodeHelper')
local config = require('music_instruments.music_node.config')


local function register_instruments()
	for instrument, def in pairs(config.instruments) do
		minetest.register_node('music_instruments:' .. instrument, {
			description = def.description,
			drawtype = def.drawtype,
			mesh = def.mesh,
			tiles = def.tiles,
			paramtype2 = 'facedir',
			groups = { choppy = 2 },

			on_construct = function(pos)
				-- Устанавливает начальные значения из конфига
				local initial_offset = 0 -- отсутствие смещения полутона при установке ноды
				local initial_note = def.notes[initial_offset].note --начальная нота, без смещений полутона
				MusicNodeHelper.update(pos, instrument, initial_offset, def.name, initial_note)
			end,

			on_punch = function(pos)
				local meta = minetest.get_meta(pos)
				local semitones = meta:get_int('semitones')

				if def and def.notes[semitones] then
					MusicNodeHelper.play_sound(pos, def.sound, def.notes[semitones].pitch)
				end
			end,

			on_rightclick = function(pos)
				local meta = minetest.get_meta(pos)
				local semitones = meta:get_int('semitones')

				if def and def.notes[semitones] then
					MusicNodeHelper.play_sound(pos, def.sound, def.notes[semitones].pitch)
				end
			end,
		})
	end
end


return {
	register = register_instruments
}
