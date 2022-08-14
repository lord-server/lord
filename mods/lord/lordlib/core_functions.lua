-- core functions
-- Прямиком из lord2

-- Callbacks
core_callback = {}

-- Нажатие
core_callback.registered_on_press = {}

core_callback.register_on_press = function(func)
	core_callback.registered_on_press[#core_callback.registered_on_press+1] = func
end

-- Отпуск
core_callback.registered_on_release = {}

core_callback.register_on_release = function(func)
	core_callback.registered_on_release[#core_callback.registered_on_release+1] = func
end

-- Удержание
core_callback.registered_on_hold = {}

core_callback.register_on_hold = function(func)
	core_callback.registered_on_hold[#core_callback.registered_on_hold+1]=func
end

-- Смена индекса предмета в руке
core_callback.registered_on_wield_index_change = {}

core_callback.register_on_wield_index_change = function(func)
	core_callback.registered_on_wield_index_change[#core_callback.registered_on_wield_index_change+1]=func
end

core_callback.reset_hold_time = function(player, control_name)
	local player_name = player:get_player_name()
	core_callback.players[player_name].controls[control_name][2] = minetest.get_us_time()/1000000
end

core_callback.players = {}

minetest.register_on_joinplayer(function(player)
	core_callback.players[player:get_player_name()] = {
		controls = {
			jump = {false},
			right = {false},
			left = {false},
			LMB = {false},
			RMB = {false},
			sneak = {false},
			aux1 = {false},
			down = {false},
			up = {false},
			zoom = {false},
			dig = {false},
			place = {false},
		},

		wield_index = 0
	}
end)

minetest.register_on_leaveplayer(function(player)
	core_callback.players[player:get_player_name()] = nil
end)

minetest.register_globalstep(function(dtime)
	for _, player in pairs(minetest.get_connected_players()) do
		local player_name = player:get_player_name()
		local player_controls = player:get_player_control()
		local player_last_controls = core_callback.players[player_name].controls
		local player_wield_index = player:get_wield_index()
		local player_last_wield_index = core_callback.players[player_name].wield_index

		for control_name, control_value in pairs(player_controls) do
			if not player_last_controls then
				break
			end

			-- Нажатие
			if (control_value == true) and (player_last_controls[control_name][1] == false) then
				for _, func in pairs(core_callback.registered_on_press) do
					func(player, control_name)
				end
				player_last_controls[control_name] = {true, minetest.get_us_time()/1000000}

			-- Удержание
			elseif (control_value == true) and (player_last_controls[control_name][1] == true) then
				for _, func in pairs(core_callback.registered_on_hold) do
					func(player, control_name, minetest.get_us_time()/1000000-player_last_controls[control_name][2], dtime)
				end

			-- Отпуск
			elseif (control_value == false) and (player_last_controls[control_name][1] == true) then
				for _, func in pairs(core_callback.registered_on_release) do
					func(player, control_name, minetest.get_us_time()/1000000-player_last_controls[control_name][2])
				end
				player_last_controls[control_name] = {false}
			end
		end

		if player_wield_index ~= player_last_wield_index then
			for _, func in pairs(core_callback.registered_on_wield_index_change) do
				func(player, player_wield_index, player_last_wield_index)
			end
			player_last_wield_index = player_wield_index
		end
		core_callback.players[player_name].controls = player_last_controls
		core_callback.players[player_name].wield_index = player_last_wield_index
	end
end)
