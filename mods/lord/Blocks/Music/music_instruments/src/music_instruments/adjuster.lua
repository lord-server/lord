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

--- Проверяет, является ли нода по заданной позиции нашей нодой.
--- @param pos Position
--- @return boolean -- true, если нода имеет имя music_box:pitch_node, иначе false.
local function is_valid_music_box(pos)
	return minetest.get_node(pos).name == 'music_instruments:calimba'
end

--- Изменяет смещение тональности ноды и обновляет её состояние.
--- @param pos Position
--- @param delta number Изменение смещения (например, 1 или -1).
local function adjust_semitones(pos, delta)
	local meta = minetest.get_meta(pos)
	local offset = meta:get_int("semitones") + delta
	if offset > 12 then offset = 12 end
	if offset < -12 then offset = -12 end
	update_node(pos, offset)
end

minetest.register_tool('music_instruments:pitch_adjuster', {
	description = "Pitch Adjuster (ЛКМ – повысить тон, ПКМ – понизить тон)",
	inventory_image = "default_tool_steelaxe.png",

	--- @param itemstack ItemStack
	--- @param user Player
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type == "node" and is_valid_music_box(pointed_thing.under) then
			adjust_semitones(pointed_thing.under, 1)
		end

		return itemstack
	end,

	--- @param itemstack ItemStack
	--- @param user Player
	on_place = function(itemstack, user, pointed_thing)
		if pointed_thing.type == "node" and is_valid_music_box(pointed_thing.under) then
			adjust_semitones(pointed_thing.under, -1)
		end

		return itemstack
	end,
})
