local Event = require('lord_events.Event')

local S = minetest.get_mod_translator()
local v = vector.new


--- @type ChatCommandDefinition
local definition = {
	privs = { eventing = true },
	description =
		S('Save current position as teleporting point for `/event` command.') .. '\n' ..
		S('If "none" is passed as a parameter, the position and the `/event` command are removed.')
	,
	params = '[none]',
	func = function(name, param)
		if param == 'none' then
			Event.unregister()

			return true, S('Event position unset.')
		else
			local player   = minetest.get_player_by_name(name)
			local position = v(player:get_pos()) + v(0, 0.5, 0)

			Event.register(position)

			return true, S('Event position is set to @1', position:to_string())
		end
	end
}


return {
	--- @type string
	NAME       = 'event.set_pos',
	--- @type ChatCommandDefinition
	definition = definition,
}
