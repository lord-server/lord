local c = require('commands.character._colorize')

core.register_chatcommand('character.gender', {
	params = '<player_name> [clear|<gender>]',
	description = 'Show, set or clear player gender',
	privs = { server = true },
	func = function(_, param)
		local parts = string.split(param, ' ')

		if #parts < 1 then
			return false, c.error('Usage: /character.gender <player_name> [clear|gender_name]')
		end

		local player_name = parts[1] --[[@as string]]
		local player = core.get_player_by_name(player_name)

		if not player then
			return false, c.error('Player `%s` is not online', player_name)
		end

		local character = character.of(player)
		if not character then
			return false, c.error('Can`t get character.of `%s`', player_name)
		end

		local action = parts[2]
		if not action then
			local gender = character:get_gender()

			return true, c.player_line(player_name) .. '\n  ' .. c.property('gender', gender)
		elseif action == 'clear' then
			character:set_gender(nil)

			return true, c.alert('Cleared gender for player `%s`', player_name)
		else
			character:set_gender(action)

			return true, c.success('Set gender `%s` for player `%s`', action, player_name)
		end
	end
})
