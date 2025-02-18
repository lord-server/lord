--[[
	Определена функция weather.get(player),
	которая должна возвращать таблицу
	с параметрами погоды для данного игрока.

	По умолчанию эта функция возвращает пустую таблицу.
]]

weather = {}

function weather.get(player)

	return {}
end

--[[
	Определена функция do_update(),
	которая обновляет погоду для игроков.

	В начале идёт проверка на пустое имя игрока player
	Далее проверка на пустые значения параметров погоды игрока weather.get(player)
	Если проверки успешны, то обновляет освещение для этого игрока.
]]

lighting = lighting or {}

-- для всех подключенных игроков
function lighting.do_update_all()
	for _, player in ipairs(minetest.get_connected_players()) do
		assert(player ~= nil, "player must not be nil")
		local params = weather.get(player)
		assert(params ~= nil, "weather.get() must not return nil")
		if params.lighting then
			player:set_lighting(params.lighting)
		end
	end
end

-- для конкретного игрока
function lighting.do_update_me(player)
	assert(player ~= nil, "player must not be nil")
	local params = weather.get(player)
	assert(params ~= nil, "weather.get() must not return nil")
	if params.lighting then
		player:set_lighting(params.lighting)
	end
end

--[[
	Определен обработчик события minetest.register_on_joinplayer(),
	который вызывает do_update_all() каждый раз,
	когда новый игрок подключается к игре.
	Это позволяет мгновенно обновить освещение
	для нового игрока и каждого подключенного
]]

minetest.register_on_joinplayer(function(player)
	lighting.do_update_all()
end)
