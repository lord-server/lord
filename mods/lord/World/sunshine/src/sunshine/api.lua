--[[
	Определена функция new_light.get(player),
	которая должна возвращать таблицу
	с параметрами погоды для данного игрока.

	По умолчанию эта функция возвращает пустую таблицу.
]]

--[[
	Определена функция do_update(),
	которая обновляет погоду для игроков.

	В начале идёт проверка на пустое имя игрока player
	Далее проверка на пустые значения параметров погоды игрока new_light.get(player)
	Если проверки успешны, то обновляет освещение для этого игрока.
]]

lighting = {}

-- для всех подключенных игроков
function lighting.set_all()
	for _, player in ipairs(minetest.get_connected_players()) do
		assert(player ~= nil, "player must not be nil")
		local params = default_light_get(player)
		assert(params ~= nil, "new_light.get() must not return nil")
		if params.lighting then
			player:set_lighting(params.lighting)
		end
	end
end

-- для конкретного игрока
function lighting.set_me(player)
	assert(player ~= nil, "player must not be nil")
	local params = new_light_get(player)
	assert(params ~= nil, "new_light.get() must not return nil")
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
	lighting.set_all()
end)
