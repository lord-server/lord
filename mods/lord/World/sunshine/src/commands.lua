local S = minetest.get_mod_translator()
local api = require('api')

--- Validates the light value from user input.
-- @param value The value to validate.
-- @return boolean True if the value is valid, false otherwise.
local function validate_light_value(value)
    return value and value >= 0 and value <= 1
end

--- Validates the bloom parameters.
-- @param i The intensity of the bloom effect.
-- @param s The strength factor of the bloom effect.
-- @param r The radius of the bloom effect.
-- @return boolean True if all parameters are valid, false otherwise.
local function validate_bloom_params(i, s, r)
    return (i >= 0.0 and i <= 1.0) and (s >= 0.1 and s <= 10.0) and (r >= 0.1 and r <= 8.0)
end

local function get_player(name)
    local player = minetest.get_player_by_name(name)
    if not player then
        return nil, S('Player not found.')
    end

    return player
end

--- Sets the volumetric light strength for a player.
-- @param name The name of the player.
-- @param value The strength value of the volumetric light.
-- @return boolean True if the light was set successfully, false and an error message otherwise.
local function set_light(name, value)
    local player, err = get_player(name)
    if not player then
        return false, err
    end

    api.light.set_for(player, value)
    local user_lighting_table = player:get_lighting()
    if user_lighting_table.volumetric_light and user_lighting_table.volumetric_light.strength == value then
        minetest.chat_send_player(name, S('Volumetric light strength set to ') .. value)
    else
        return false, S('Failed to set volumetric light strength')
    end

    return true
end

minetest.register_chatcommand('sunshine.set_light', {
    params = '<value>',
    description = S('Set the volumetric light strength (0.0 to 1.0)'),
    func = function(name, param)
        local value = tonumber(param)
        if not validate_light_value(value) then
            return false, S('Invalid input. Please enter a valid number between 0.0 and 1.0.')
        end

        return set_light(name, value)
    end,
})

minetest.register_chatcommand('sunshine.set_bloom', {
    params = '<intensity> <strength_factor> <radius>',
    description =   S('Input 3 numbers separated by a space.') .. '\n' ..
                    S('Intensity from 0.0 to 1.0') .. '\n' ..
                    S('Strength factor from 0.1 to 10.0') .. '\n' ..
                    S('Radius from 0.1 to 8.0'),
    func = function(name, param)
        local num1, num2, num3 = param:match('^(%d+%.?%d*) (%d+%.?%d*) (%d+%.?%d*)$')
        if not (num1 and num2 and num3) then
            return false, S('Error: input 3 numbers separated by a space.')
        end

        local i, s, r = tonumber(num1), tonumber(num2), tonumber(num3)
        if not validate_bloom_params(i, s, r) then
            return false, S('Error: parameters out of range.')
        end

        local player, err = get_player(name)
        if not player then
            return false, err
        end

        api.bloom.set_for(player, i, s, r)

        return true
    end
})

minetest.register_chatcommand('sunshine.reset', {
    func = function(name)
        local player, err = get_player(name)
        if not player then
            return false, err
        end

        api.reset.set_for(player)

        return true
    end
})
