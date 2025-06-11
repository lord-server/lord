local Manager = require('holding_points.Manager')

local S = minetest.get_mod_translator()

--- @type ChatCommandDefinition
local definition = {
	privs       = { server = true },
	description = S('Stops the Battle with name <battle_name>'),
	params      = '<battle_name>',
	func        = function(name, param)
		if param == '' then
			return false, S('No battle name specified')
		end

		local stopped, error = Manager.stop_battle(param)
		if not stopped then
			return false, error
		end

		return true, S('Battle `@1` stopped', stopped.title)
	end
}


return {
	--- @type string
	NAME       = 'battle.stop',
	--- @type ChatCommandDefinition
	definition = definition,
}


