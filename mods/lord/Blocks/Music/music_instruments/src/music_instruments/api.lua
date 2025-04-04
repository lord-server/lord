local note_names = require('music_instruments.config').note_names

--- @param offset number Смещение в полутоновом выражении.
--- @return {note: string, pitch: number} -- Данные о ноте: название и значение pitch.
local function get_tone(offset)
	-- При отсутствии значения возвращаем ноту для 0
	return note_names[offset] or note_names[0]
end

--- Проигрывает звук для заданной позиции и смещения тона.
--- Дубль
--- @param pos Position
--- @param offset number Смещение в полутоновом выражении.
local function play_tone(pos, offset)
	local t = get_tone(offset)
	minetest.sound_play("c5_note", {
		pos = pos,
		gain = 1.0,
		pitch = t.pitch,
	})
end

--- Обновляет метаданные ноды и проигрывает звук.
--- Дубль
--- @param pos Position
--- @param offset number Смещение в полутоновом выражении.
local function update_node(pos, offset)
	local meta = minetest.get_meta(pos)
	meta:set_int("semitones", offset)
	local t = get_tone(offset)
	meta:set_string("infotext", "Semitones: " .. offset .. ", Note: " .. t.note)
	play_tone(pos, offset)
end

-- Регистрируем ноду, которая по удару проигрывает ноту
minetest.register_node('music_instruments:calimba', {
	description = "Music Box (играет ноту C5)",
	tiles = {"default_wood.png"},
	groups = {choppy = 2},

	--- @param pos Position
	on_construct = function(pos)
		update_node(pos, 0)
	end,

	--- @param pos Position
	on_punch = function(pos)
		local meta = minetest.get_meta(pos)
		local offset = meta:get_int("semitones")
		play_tone(pos, offset)
	end,
})

return {

}
