local c = require('commands.character._colorize')

core.register_chatcommand('character.skin', {
	params = '<player_name> [clear|<skin_number>]',
	description = 'Set or clear player skin number',
	privs = { server = true },
	func = function(_, param)
		local parts = string.split(param, ' ')

		if #parts < 1 then
			return false, c.error('Usage: /character.skin <player_name> [clear|skin_number]')
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
			local skin_no = character:get_skin_no()

			return true, c.player_line(player_name) .. '\n  ' .. c.property('skin', skin_no)
		elseif action == 'clear' then
			character:set_skin_no(nil)

			return true, c.alert('Cleared skin for player `%s`', player_name)
		else
			local skin_no = tonumber(action)
			if not skin_no then
				return false, c.error('Skin number must be numeric')
			end
			character:set_skin_no(skin_no)

			return true, c.success('Set skin `%s` for player `%s`', skin_no, player_name)
		end
	end
})
