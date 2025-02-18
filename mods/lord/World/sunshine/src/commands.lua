local S = minetest.get_mod_translator()

require('sunshine.api')

-- Регистрация команды для изменения volumetric_strength
minetest.register_chatcommand("set_lgt", {
    params = "<value>",
    description = S("Set the volumetric light strength (0.0 to 1.0)"),
    func = function(name, param)

        -- проверка привелегий
        if not minetest.check_player_privs(name, {sunshine=true}) then
            return false, S("You do not have permission to use this command.")
        end

        -- конвертация значения ввода в число и проверка на диапазон
        local value = tonumber(param)
        if not value or value < 0 or value > 1 then
            return false, S("Invalid input. Please enter a valid number between 0.0 and 1.0.")
        end
        -- установка значения света
        volumetric_strength = value
        minetest.chat_send_player(name, "Volumetric light strength set to " .. value)

        -- обновление значения света для текущего игрока
        local player = minetest.get_player_by_name(name)
        if player then
            lighting.do_update_me(player)
            minetest.chat_send_player(name, "Your lighting has been updated")
        end

        return true
    end,
})

local environment = minetest.settings:get("environment")
if not environment or environment == "production" then

    return
end

-- Команда для получения текущего значения volumetric_strength
minetest.register_chatcommand("get_lgt", {
    description = S("Get the current volumetric light strength"),
    func = function(name)

        return true, S("Current volumetric light strength: ") .. volumetric_strength
    end,
})
