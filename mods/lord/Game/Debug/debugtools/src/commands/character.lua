require('commands.character.race')
require('commands.character.gender')
require('commands.character.skin')
require('commands.character.second_chance')

local c = require('commands.character._colorize')


core.register_chatcommand('character', {
	params = '<player_name> [reset]',
	description = 'Debug character - show race, gender, skin, second chance and privileges. Or clear character data.',
	privs = { server = true },
	func = function(_, param)
		local parts = string.split(param, ' ')

		if #parts < 1 then
			return false, c.error('Usage: /character <player_name> [reset]')
		end

		local player_name = parts[1] --[[@as string]]
		local player = minetest.get_player_by_name(player_name)

		if not player then
			return false, c.error('Player %s is not online', player_name)
		end

		--- @type character.Character
		local character = character.of(player)
		if not character then
			return false, c.error('Can`t get character.of %s', player_name)
		end

		local action = parts[2]
		if not action then
			local race              = character:get_race()
			local gender            = character:get_gender()
			local skin_no           = character:get_skin_no()
			local has_second_chance = character:has_second_chance()
			if core.settings:get_bool('debug', false) then
				pd(character, race, gender, skin_no, has_second_chance)
			end

			local info = {}
			info[#info + 1] = c.player_line(player_name)
			info[#info + 1] = '  ' .. c.property('Race', race)
			info[#info + 1] = '  ' .. c.property('Gender', gender)
			info[#info + 1] = '  ' .. c.property('Skin', skin_no)
			info[#info + 1] = '  ' .. c.property('Second chance', has_second_chance)
			local privs = table.keys(core.get_player_privs(player_name))
			info[#info + 1] = '  ' .. c.property('Privileges', table.concat(privs, ', '), 'lightgray')

			return true, table.concat(info, '\n')
		elseif action == 'reset' then
			character:set_race(nil)
			character:set_gender(nil)
			character:set_skin_no(nil)
			character:set_has_second_chance(true)

			return true, c.alert('Cleared character for player %s', player_name)
		else
			return false, c.error('Unknown action `%s`. Use `reset` to clear character data.', action)
		end
	end
})
