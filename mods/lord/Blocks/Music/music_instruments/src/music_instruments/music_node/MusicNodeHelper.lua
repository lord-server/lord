local S = minetest.get_mod_translator()


--- HELPER ---

local MusicNodeHelper = {}

--- Обновляет метаданные ноды
--- @param pos Position Позиция ноды
--- @param instrument string Идентификатор инструмента
--- @param offset number Смещение в полутонах
--- @param name string Локализованное название инструмента
--- @param note string Название ноты
function MusicNodeHelper.update(pos, instrument, offset, name, note)
	local meta = minetest.get_meta(pos)
	meta:set_string('instrument', instrument)
	meta:set_int('semitones', offset)
	meta:set_string('infotext', name..'\n'..S('Note:')..' '..note)
end

--- Проигрывает звук
--- @param sound string Название звукового файла
--- @param pitch number Тон звука
function MusicNodeHelper.play_sound(pos, sound, pitch)
	minetest.sound_play(sound, {
		pos = pos,
		pitch = pitch or 1,
		gain = 1.0,
	})
end

return MusicNodeHelper
