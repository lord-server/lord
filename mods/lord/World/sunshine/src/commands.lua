local S = minetest.get_mod_translator()
local api = require('api')


minetest.register_chatcommand('sunshine.set_light', {
    params = '<value>',
    description = S('Set the volumetric light strength (0.0 to 1.0)'),
    func = function(name, param)

        local value = tonumber(param)
        if not value or value < 0 or value > 1 then
            return false, S('Invalid input. Please enter a valid number between 0.0 and 1.0.')
        end

        local player = minetest.get_player_by_name(name)
        if player then
			api.light.set_for(player, value)
            local user_lighting_table = player:get_lighting()
            if user_lighting_table.volumetric_light and user_lighting_table.volumetric_light.strength == value then
                minetest.chat_send_player(name, S('Volumetric light strength set to ') .. value)
            else
                minetest.chat_send_player(name, S('Failed to set volumetric light strength'))

                end
        else
			return false, S('Player not found.')
		end

        return true
    end,
})

minetest.register_chatcommand('sunshine.set_bloom', {
    params = '<num1> <num2> <num3>',
    description = 'Ввод трех числовых переменных для эффекта bloom',
    func = function(name, param)
        local num1, num2, num3 = param:match('^(%d+%.?%d*) (%d+%.?%d*) (%d+%.?%d*)$')
        if num1 and num2 and num3 then
            local i, s, r = tonumber(num1), tonumber(num2), tonumber(num3)

            -- Проверка значений переменных
            if i < 0.0 or i > 1.0 then
                return false, 'Ошибка: i должно быть в диапазоне от 0.0 до 1.0.'
            end
            if s < 0.1 or s > 10.0 then
                return false, 'Ошибка: s должно быть в диапазоне от 0.1 до 10.0.'
            end
            if r < 0.1 or r > 8.0 then
                return false, 'Ошибка: r должно быть в диапазоне от 0.1 до 8.0.'
            end

            local player = minetest.get_player_by_name(name)
            if player then
                api.bloom.set_for(player, i, s, r)  -- Вызов функции с параметрами

                return true, 'Вы ввели: ' .. i .. ', ' .. s .. ', ' .. r  -- Используйте i, s, r для вывода
            else
                return false, 'Ошибка: игрок не найден.'
            end
        else
            return false, 'Ошибка: введите три числа.'
        end
    end
})

minetest.register_chatcommand('sunshine.reset', {
    params = '<value>',
    description = S('Set the volumetric light strength (0.0 to 1.0)'),
    func = function(name, param)

        local player = minetest.get_player_by_name(name)
        if player then
			api.reset.set_for(player)
        else
			return false, S('Player not found.')
		end

        return true
    end,
})