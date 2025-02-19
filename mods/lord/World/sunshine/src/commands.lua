local S = minetest.get_mod_translator()
local set_user_light = require('api')


minetest.register_chatcommand('sunshine.set_light_value', {
    params = '<value>',
    description = S('Set the volumetric light strength (0.0 to 1.0)'),
    func = function(name, param)

        local value = tonumber(param)
        if not value or value < 0 or value > 1 then
            return false, S('Invalid input. Please enter a valid number between 0.0 and 1.0.')
        end

        local player = minetest.get_player_by_name(name)
        if player then
			local success = set_user_light(player, value)
			if not success then
				return false, S('Not succes')
			else
				minetest.chat_send_player(name, 'Volumetric light strength set to ' .. value)
			end
        else
			return false, S('Player not found.')
		end

        return true
    end,
})
