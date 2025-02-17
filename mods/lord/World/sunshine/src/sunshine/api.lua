local CYCLE = 8 -- Time period of cyclic clouds update in seconds

weather = {}

--[[
	Определена функция weather.get(player),
	которая должна возвращать таблицу
	с параметрами погоды для данного игрока.

	По умолчанию эта функция возвращает пустую таблицу.
]]


function weather.get(player)


	return {}
end

--[[
	Определена локальная функция do_update(),
	которая обновляет погоду для каждого подключенного игрока.

	В начале идёт проверка на пустое имя игрока player
	Далее проверка на пустые значения параметров погоды игрока weather.get(player)
	Если проверки успешны, то обновляет освещение для этого игрока.
]]

local function do_update()
	for _, player in ipairs(minetest.get_connected_players()) do
		assert(player ~= nil, "player must not be nil")
		local params = weather.get(player)
		assert(params ~= nil, "weather.get() must not return nil")
		if params.lighting then
			player:set_lighting(params.lighting)
		end
	end
end

--[[
	Определена локальная функция cyclic_update(),
	которая вызывает do_update() и
	затем планирует следующий вызов cyclic_update()
	через CYCLE секунд.

	Функция cyclic_update()
	вызывается сразу же после запуска мода,
	а затем каждые CYCLE секунд.
]]

local function cyclic_update()
	do_update()
	minetest.after(CYCLE, cyclic_update)
end
minetest.after(0, cyclic_update)

--[[
	Определен обработчик события minetest.register_on_joinplayer(),
	который вызывает do_update() каждый раз,
	когда новый игрок подключается к игре.
	Это позволяет мгновенно обновить освещение
	для нового игрока и каждого подключенного
]]

minetest.register_on_joinplayer(function(player)
	do_update()
end)
