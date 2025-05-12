local Instruments = require('Instruments')
local modname = "music_nodes"
require('instruments.calimba')


--- Обновляет метаданные ноды и проигрывает звук, соответствующий смещению
--- @param instrument table — экземпляр инструмента
--- @param pos Position — позиция ноды
--- @param offset number — смещение (semitones) из таблицы calimba.notes
--- @return nil
local function update_node(instrument, pos, offset)
	local meta = minetest.get_meta(pos)
	meta:set_int("semitones", offset)
	meta:set_string("instrument", instrument.name)
	local t = instrument.notes[offset] or instrument.notes[0]
	meta:set_string("infotext", ("Instrument: %s\nSemitones: %d, Note: %s"):format(instrument.description, offset, t.note))
	minetest.sound_play(instrument.sound, { pos = pos, gain = 1.0, pitch = t.pitch })
end

-- Регистрация нод для всех инструментов
for name, instrument in pairs(Instruments.get_all()) do
    minetest.register_node(modname..":"..name, {
		description = instrument.description,
		tiles = instrument.tiles,
		groups = { choppy = 2},

		--- @param pos Position — позиция ноды
		on_construct = function(pos)
			-- Сразу устанавливаем связанный инструмент
			local meta = minetest.get_meta(pos)
			meta:set_string("instrument", instrument.name)
			update_node(instrument, pos, 0)
		end,

		--- @param pos Position — позиция ноды
		on_punch = function(pos)
			local meta = minetest.get_meta(pos)
			local offset = meta:get_int("semitones")
			local t = instrument.notes[offset] or instrument.notes[0]
			minetest.sound_play(instrument.sound, {
				pos = pos,
				gain = 1.0,
				pitch = t.pitch
			})
		end,
	})
end
