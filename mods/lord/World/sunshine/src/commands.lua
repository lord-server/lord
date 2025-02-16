local S = minetest.get_mod_translator()

-- Регистрация команды для изменения volumetric_strength
minetest.register_chatcommand("set_lgt_str", {
    params = "<value>",
    description = S("Set the volumetric light strength (0.0 to 1.0)"),
    func = function(name, param)
        -- Проверка на наличие служебных символов
        if not param:match("^%d*%.?%d*$") then
            return false, S("Invalid input. Please enter a valid number between 0.0 and 1.0.")
        end

        local value = tonumber(param)

        -- Проверка на NaN и диапазон
        if value and value >= 0 and value <= 1 then
            volumetric_strength = value
            minetest.chat_send_player(name, "Volumetric light strength set to " .. value)
            return true
        else
            return false, S("Invalid input. Please enter a valid number between 0.0 and 1.0.")
        end
    end,
})

local environment = minetest.settings:get("environment")
if not environment or environment == "production" then
    return
end

-- Команда для получения текущего значения volumetric_strength
minetest.register_chatcommand("get_lgt_str", {
    description = S("Get the current volumetric light strength"),
    func = function(name)
        return true, S("Current volumetric light strength: ") .. volumetric_strength
    end,
})

-- Регистрация команды для перезапуска погоды
minetest.register_chatcommand("refresh_weather", {
    description = S("Refresh the weather settings"),
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if player then
            local weather_data = weather.get(player)
            player:set_lighting(weather_data.lighting)
            return true, S("Weather settings refreshed.")
        else
            return false, S("Player not found.")
        end
    end,
})