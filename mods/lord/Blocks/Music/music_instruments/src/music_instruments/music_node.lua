local config = require('music_instruments.music_node.config')


local Music_node = {}

--- Обновляет метаданные ноды
--- @param pos Position Позиция ноды
--- @param instrument_id string Название инструмента из config.instruments
--- @param offset number Смещение в полутонах (-12..12)
function Music_node.update_node(pos, instrument_id, offset)
	local meta = minetest.get_meta(pos)
	local instrument = config.instruments[instrument_id]
	local note = instrument.notes[offset] or instrument.notes[0]

	meta:set_string('instrument', instrument_id)
	meta:set_int('semitones', offset)
	meta:set_string('infotext', instrument.name..'\nNote: '..note.note)
end

--- Проигрывает звук инструмента
--- @param pos Position Позиция ноды
--- @param instrument_id string Название инструмента из config.instruments
--- @param offset number Текущее смещение
function Music_node.play_sound(pos, instrument_id, offset)
	local instrument = config.instruments[instrument_id]
	local note = instrument.notes[offset] or instrument.notes[0]
	minetest.sound_play(instrument.sound, {
		pos = pos,
		pitch = note.pitch,
		gain = 1.0,
	})
end


return Music_node
