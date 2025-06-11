local MusicNodeHelper = require('music_instruments.music_node.MusicNodeHelper')
local config = require('music_instruments.music_node.config')
local fork = config.turnig_fork


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
		description = fork.title,
		_tt_help = fork.description and minetest.colorize('#aaa',  '\n' .. fork.description),
		inventory_image = fork.inventory_image,
		wield_image = fork.wield_image,
		groups = fork.groups,

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

	minetest.register_craft({
		output = 'music_instruments:tuning_fork',
		recipe = {
			{'', '',                      ''},
			{'', 'lottores:silver_ingot', ''},
			{'', 'lottores:silver_ingot', ''},
		}
	})
end


return {
	register = register_tuning_fork
}
