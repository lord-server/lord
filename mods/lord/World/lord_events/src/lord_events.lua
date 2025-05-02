local Event =   require('lord_events.Event')
local command = require('lord_events.command')

--- Команда перемещения на Событие (`/event`) создается при наличии позиции `Event.CONF_VAR` в ModStorage.
--- Позиция(текущая) задается в игре командой `/event.set_pos` при наличии привилегии `eventing`.
--- Значение сохраняется в ModStorage и доступно после перезапуска сервера.
--- Команда `/event.set_pos` сохраняет позицию и создаёт команду `/event` через `lord_spawns.halls.register()`
--- Команда `/event.set_pos none` удаляет позицию и команду `/event`


return {
	--- @param mod minetest.Mod
	init = function(mod)
		local S = mod.translator

		minetest.register_privilege('eventing', {
			description = S('Can save position for /event command'),
			give_to_singleplayer = false,
		})

		Event.restore_from_storage_config()

		minetest.register_chatcommand(command.event.set_pos.NAME, command.event.set_pos.definition)
	end,
}
