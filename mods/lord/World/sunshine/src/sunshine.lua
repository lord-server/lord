local S = minetest.get_mod_translator()

require('sunshine.api')

--[[

	Использую константу, т.к.
	мод на облака `clouds.lua`
	пока не включён.

	При активации мода облаков,
	нужно тянуть `density` от туда.
]]

local density = 0.4			-- Default and classic density value is 0.4
local mg_name				-- Имя мап генератора
volumetric_strength = 0.2	-- Cила объёмного света по умолчанию

--[[

	Проверка настроек:
	Код проверяет, включена ли функция погоды в настройках игры.
	Если она выключена, код прерывается.
]]

if minetest.settings:get_bool("enable_weather") == false then


	return
end

-- Регистрация новой привилегии "sunshine"
minetest.register_privilege("sunshine", {
    description = S("Allows the player to set the volumetric light strength."),

	--[[
		Установите true, если хотите,
		чтобы эта привилегия была
		автоматически дана одиночному игроку
	]]

	give_to_singleplayer = false,
})

--[[

	Определение карты:
	Код определяет тип карты, используемой в игре.
	Если карта имеет тип "v6" или "singlenode",
	код устанавливает определенные параметры освещения по умолчанию
	и прерывается.
]]

mg_name = minetest.get_mapgen_setting("mg_name")

if mg_name == "v6" or mg_name == "singlenode" then
    -- Устанавливаем стандартную интенсивность теней для mgv6 и singlenode
    minetest.register_on_joinplayer(function(player)
        player:set_lighting({
            shadows = { intensity = 0.33 },
            bloom = { intensity = 0.05 },
            volumetric_light = { strength = 0.2 },
        })
    end)

    return
end

function weather.get(player)

	return {
		lighting = {
			shadows = { intensity = 0.7 * (1 - density) },
			bloom = { intensity = 0.05 },
			volumetric_light = { strength = volumetric_strength },
		}
	}
end

