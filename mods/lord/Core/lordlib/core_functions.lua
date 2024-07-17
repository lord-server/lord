
-- Смена индекса предмета в руке
lord.registered_on_wield_index_change = {}

---
--- Регистрирует обратный вызов на смену индекса предмета в руке
---
--- @param func fun(player, player_wield_index, player_last_wield_index)
--- Принимает функцию колбека со след параметрами:
---  * `player` - игрок
---  * `player_wield_index` - текущий индекс предмета в руке
---  * `player_last_wield_index` - прошлый индекс предмета в руке
lord.register_on_wield_index_change = function(func)
	table.insert(lord.registered_on_wield_index_change, func)
end

lord.players = {}

minetest.register_on_joinplayer(function(player)
	local player_name = player:get_player_name()
	if not player_name then
		return
	end
	if lord.players[player_name] == nil then
		lord.players[player_name] = {}
	end
	lord.players[player_name].wield_index = 0
end)

minetest.register_on_leaveplayer(function(player)
	local player_name = player:get_player_name()

	if not player_name then
		return
	end

	lord.players[player_name].wield_index = nil
end)


minetest.foreach_player_every(0, function(player, delta_time)
	local player_name  = player:get_player_name()
	local player_last_ = lord.players[player_name]

	if player_name ~= nil and player_last_ ~= nil then
		local player_last_wield_index = player_last_.wield_index
		local player_wield_index      = player:get_wield_index()

		-- Вызов каллбэков смены индекса предмета в руке
		if player_wield_index ~= player_last_wield_index then
			for _, func in pairs(lord.registered_on_wield_index_change) do
				func(player, player_wield_index, player_last_wield_index)
			end
			player_last_wield_index = player_wield_index
		end
		lord.players[player_name].wield_index = player_last_wield_index
	end
end)
