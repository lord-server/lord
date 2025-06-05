local MusicNodeHelper = require('music_instruments.music_node.MusicNodeHelper')
local config = require('music_instruments.music_node.config')


local S = minetest.get_mod_translator()

--- Изменяет тон ноды
--- @param pos Position
--- @param delta number Шаг изменения (1 или -1)
local function adjust_semitones(pos, delta)
	local meta = minetest.get_meta(pos)
	local instrument_id = meta:get_string('instrument')
	local current = meta:get_int('semitones')

	-- Получает данные инструмента из конфига
	local def = config.instruments[instrument_id]
	if not def then return end

	-- Индивидуальные min/max нот для инструмента
	local new_offset = math.clamp(current + delta, def.min_offset or 0, def.max_offset or 0)

	if not def.notes[new_offset] then return end

	-- Обновляет метаданные и воспроизводит звук
	MusicNodeHelper.update(pos, instrument_id, new_offset, def.name, def.notes[new_offset].note)
	MusicNodeHelper.play_sound(pos, def.sound, def.notes[new_offset].pitch)
end

local function register_tuning_fork()
	minetest.register_tool('music_instruments:tuning_fork', {
		description =   S('The tuning fork is a musical instrument') .. '\n' ..
						S('that gives hope to aspiring musicians') .. '\n' ..
						S('that their false notes can be corrected') .. '\n' ..
						S('with a small metal object,') .. '\n' ..
						S('rather than long hours of practice') .. '\n' ..
						S('and dedicated labour.'),
		inventory_image = 'music_instruments_tuning_fork.png',
		wield_image = 'music_instruments_tuning_fork.png^[transformFX',

		--- @param itemstack ItemStack
		--- @param user Player
		on_use = function(itemstack, user, pointed_thing)
			if pointed_thing.type == 'node' then

				local node_name = minetest.get_node(pointed_thing.under).name
				if node_name:find('music_instruments:') then
					adjust_semitones(pointed_thing.under, 1)
				end
			end

			return itemstack
		end,

		--- @param itemstack ItemStack
		--- @param user Player
		on_place = function(itemstack, user, pointed_thing)
			if pointed_thing.type == 'node' then

				local node_name = minetest.get_node(pointed_thing.under).name
				if node_name:find('music_instruments:') then
					adjust_semitones(pointed_thing.under, -1)
				end
			end

			return itemstack
		end
	})
end


return {
	register = register_tuning_fork
}
