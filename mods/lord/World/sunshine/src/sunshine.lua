local api = require('sunshine.api') -- Always load the API
local commands = require('commands') -- Load commands

--[[

	Использую константу, т.к.
	мод на облака `clouds.lua`
	пока не включён.
	
	При активации мода облаков,
	нужно тянуть `density` от туда.
]]

local density = nil			
local mg_name = nil			-- Имя мап генератора
volumetric_strength = nil	-- Cила объёмного света

--[[

	Проверка настроек:
	Код проверяет, включена ли функция погоды в настройках игры.
	Если она выключена, код прерывается.
]]

if minetest.settings:get_bool("enable_weather") == false then
	return
end

--[[

	Определение карты:
	Код определяет тип карты, используемой в игре.
	Если карта имеет тип "v6" или "singlenode",
	код устанавливает определенные параметры освещения по умолчанию
	и прерывается.
]]

mg_name = minetest.get_mapgen_setting("mg_name")
if mg_name == "v6" or mg_name == "singlenode" then
	-- set a default shadow intensity for mgv6 and singlenode
	minetest.register_on_joinplayer(function(player)
		player:set_lighting({
			shadows = { intensity = 0.33 },
			bloom = { intensity = 0.05 },
			volumetric_light = { strength = 0.2 },
		})
	end)

	return
end


density = 0.4				-- Значение по умолчанию = 0.4
volumetric_strength = 0.2	-- Базовое значение силы объёмного света


function weather.get(player)


	return {
		lighting = {
			shadows = { intensity = 0.7 * (1 - density) },
			bloom = { intensity = 0.05 },
			volumetric_light = { strength = volumetric_strength },
		}
	}
end
