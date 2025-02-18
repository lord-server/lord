S = minetest.get_mod_translator()


minetest.register_chatcommand("set_light_value", {
    params = "<value>",
    description = S("Set the volumetric light strength (0.0 to 1.0)"),
    func = function(name, param)

        local value = tonumber(param)
        if not value or value < 0 or value > 1 then
            return false, S("Invalid input. Please enter a valid number between 0.0 and 1.0.")
        end

        local player = minetest.get_player_by_name(name)
        if player then
            user_light_set(player, value)
        end

        minetest.chat_send_player(name, "Volumetric light strength set to " .. value)

        return true
    end,
})
