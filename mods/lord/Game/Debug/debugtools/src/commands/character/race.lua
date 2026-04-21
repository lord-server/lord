local c = require('commands.character._colorize')

core.register_chatcommand('character.race', {
	params = '<player_name> [clear|<race>]',
	description = 'Set or clear player race',
	privs = { server = true },
	func = function(_, param)
		local parts = string.split(param, ' ')

		if #parts < 1 then
			return false, c.error('Usage: /character.race <player_name> [clear|race_name]')
		end

		local player_name = parts[1] --[[@as string]]
		local player = minetest.get_player_by_name(player_name)

		if not player then
			return false, c.error('Player `%s` is not online', player_name)
		end

		local character = character.of(player)
		if not character then
			return false, c.error('Can`t get character.of `%s`', player_name)
		end

		local action = parts[2]
		if not action then
			return true, c.player_line(player_name) .. '\n  ' .. c.property('Race', character:get_race())
		elseif action == 'clear' then
			character:set_race(nil)

			return true, c.alert('Cleared race for player `%s`', player_name)
		else
			character:set_race(action)

			return true, c.success('Set race `%s` for player `%s`', action, player_name)
		end
	end
})
