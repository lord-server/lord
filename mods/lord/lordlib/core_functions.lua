-- core functions
-- Прямиком из lord2

-- Для перевода микросекунд в секунды
local MICROSECONDS = 1000000

-- Нажатие
lord.registered_on_press = {}

lord.register_on_press = function(func)
	table.insert(lord.registered_on_press, func)
end

-- Отпуск
lord.registered_on_release = {}

lord.register_on_release = function(func)
	table.insert(lord.registered_on_release, func)
end

-- Удержание
lord.registered_on_hold = {}

lord.register_on_hold = function(func)
	table.insert(lord.registered_on_hold, func)
end

-- Смена индекса предмета в руке
lord.registered_on_wield_index_change = {}

lord.register_on_wield_index_change = function(func)
	table.insert(lord.registered_on_wield_index_change, func)
end

-- Сброс времени удержания для кнопки
lord.reset_hold_time = function(player, control_name)
	if not player then return end

	if not control_name then return end

	local player_name = player:get_player_name()

	if not player_name then return end

	lord.players[player_name].controls[control_name][2] = minetest.get_us_time()/MICROSECONDS
end

lord.players = {}

minetest.register_on_joinplayer(function(player)
	local player_name = player:get_player_name()

	if not player_name then return end

	lord.players[player_name] = {
		controls = {
			jump = {false, 0},
			right = {false, 0},
			left = {false, 0},
			LMB = {false, 0},
			RMB = {false, 0},
			sneak = {false, 0},
			aux1 = {false, 0},
			down = {false, 0},
			up = {false, 0},
			zoom = {false, 0},
			dig = {false, 0},
			place = {false, 0},
		},

		wield_index = 0
	}
end)

minetest.register_on_leaveplayer(function(player)
	local player_name = player:get_player_name()

	if not player_name then return end

	lord.players[player_name] = nil
end)

-- Вызов каллбэков нажатия клавиши
function call_press(player, player_last_controls, control_name)
	-- Время, когда была нажата кнопка
	local press_time = minetest.get_us_time()/MICROSECONDS

	for _, func in pairs(lord.registered_on_press) do
		func(player, control_name)
	end
	player_last_controls[control_name] = {true, press_time}
end

-- Вызов каллбэков удержания клавиши
function call_hold(player, player_last_controls, control_name, dtime)
	-- Время, когда была нажата кнопка вычитается из текущего, чтобы получить длительность нажатия
	local hold_time = minetest.get_us_time()/MICROSECONDS-player_last_controls[control_name][2]

	for _, func in pairs(lord.registered_on_hold) do
		func(player, control_name, hold_time, dtime)
	end
end

-- Вызов каллбэков смены индекса предмета в руке
function call_release(player, player_last_controls, control_name)
	-- Время, сколько была нажата кнопка
	local release_time = minetest.get_us_time()/MICROSECONDS-player_last_controls[control_name][2]

	for _, func in pairs(lord.registered_on_release) do
		func(player, control_name, release_time)
	end
	player_last_controls[control_name] = {false, 0}
end

minetest.register_globalstep(function(dtime)
	for _, player in pairs(minetest.get_connected_players()) do
		local player_name = player:get_player_name()
		if player_name ~= nil then
			local player_controls = player:get_player_control()
			local player_last_controls = lord.players[player_name].controls
			local player_wield_index = player:get_wield_index()
			local player_last_wield_index = lord.players[player_name].wield_index

			for control_name, control_value in pairs(player_controls) do
				if not player_last_controls then
					break
				end

				-- Нажатие
				if (control_value == true) and (player_last_controls[control_name][1] == false) then
					call_press(player, player_last_controls, control_name)

				-- Удержание
				elseif (control_value == true) and (player_last_controls[control_name][1] == true) then
					call_hold(player, player_last_controls, control_name, dtime)

				-- Отпуск
				elseif (control_value == false) and (player_last_controls[control_name][1] == true) then
					call_release(player, player_last_controls, control_name)
				end
			end

			-- Вызов каллбэков смены индекса предмета в руке
			if player_wield_index ~= player_last_wield_index then
				for _, func in pairs(lord.registered_on_wield_index_change) do
					func(player, player_wield_index, player_last_wield_index)
				end
				player_last_wield_index = player_wield_index
			end
			lord.players[player_name].controls = player_last_controls
			lord.players[player_name].wield_index = player_last_wield_index
		end
	end
end)
