local Manager = require('holding_points.Manager')

local S        = minetest.get_mod_translator()
local colorize = minetest.colorize

--- @type ChatCommandDefinition
local definition = {
	privs       = { server = true },
	description = S('Starts the Battle with name <battle_name>'),
	params      = '<battle_name>',
	func        = function(name, param)
		if param == '' then
			return false, S('No battle name specified')
		end

		local started, error = Manager.start_battle(param)
		if not started then
			return false, error
		end

		return
			true,
			S('Battle `@1` started', started.title) .. '\n' ..
				colorize('#ff0', S('Attention:')) .. ' ' ..
				S('You must stop the Battle manually with command `/battle.stop`')
	end
}


return {
	--- @type string
	NAME       = 'battle.start',
	--- @type ChatCommandDefinition
	definition = definition,
}


