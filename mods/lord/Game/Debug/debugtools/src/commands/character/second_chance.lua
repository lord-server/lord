local c = require('commands.character._colorize')

core.register_chatcommand('character.second_chance', {
	params = '<player_name> [true|false]',
	description = 'Show or set player second chance',
	privs = { server = true },
	func = function(_, param)
		local parts = string.split(param, ' ')

		if #parts < 1 then
			return false, c.error('Usage: /character.second_chance <player_name> [clear|true|false]')
		end

		local player_name = parts[1] --[[@as string]]
		local player = minetest.get_player_by_name(player_name)

		if not player then
			return false, c.error('Player `%s` is not online', player_name)
		end

		--- @type character.Character
		local character = character.of(player)
		if not character then
			return false, c.error('Can`t get character.of `%s`', player_name)
		end

		local action = parts[2]
		if not action then
			local has_second_chance = character:has_second_chance()

			return true, c.player_line(player_name) .. '\n  ' .. c.property('second chance', has_second_chance)
		else
			local value = action == 'true'
			character:set_has_second_chance(value)

			return true, c.format('green', 'Set second chance `%s` for player `%s`', value, player_name)
		end
	end
})
