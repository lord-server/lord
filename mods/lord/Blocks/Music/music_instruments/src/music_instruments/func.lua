local config = require('music_instruments.config')


local Func = {}

--- Обновляет метаданные ноды
--- @param pos Position Позиция ноды
--- @param instrument_id string Название инструмента из config.instruments
--- @param offset number Смещение в полутонах (-12..12)
function Func.update_node(pos, instrument_id, offset)
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
function Func.play_sound(pos, instrument_id, offset)
	local instrument = config.instruments[instrument_id]
	local note = instrument.notes[offset] or instrument.notes[0]
	minetest.sound_play(instrument.sound, {
		pos = pos,
		pitch = note.pitch,
		gain = 1.0,
})
end

--- Проигрывает долгий звук инструмента
--- @param pos Position Позиция ноды
--- @param instrument_id string Название инструмента из config.instruments
--- @param offset number Текущее смещение
function Func.play_sound_long(pos, instrument_id, offset)
	local instrument = config.instruments[instrument_id]
	local note = instrument.notes[offset] or instrument.notes[0]
	minetest.sound_play(instrument.sound_long, {
		pos = pos,
		pitch = note.pitch,
		gain = 1.0,
	})
end


return Func
