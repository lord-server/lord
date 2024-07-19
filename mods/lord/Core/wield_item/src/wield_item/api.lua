local Event = require("wield_item.Event")


local player_last_wield_index = {}

minetest.register_on_joinplayer(function(player)
	local player_name = player:get_player_name()
	if not player_name then return end

	player_last_wield_index[player_name] = 0
end)

minetest.register_on_leaveplayer(function(player)
	local player_name = player:get_player_name()
	if not player_name then return end

	player_last_wield_index[player_name] = nil
end)


minetest.foreach_player_every(0, function(player)
	local player_name      = player:get_player_name()
	local wield_index      = player:get_wield_index()
	local last_wield_index = player_last_wield_index[player_name]

	if not player_name or not wield_index or not last_wield_index then
		return
	end

	if wield_index ~= last_wield_index then
		Event.trigger(Event.Type.on_index_change, player, wield_index, last_wield_index)
	end

	player_last_wield_index[player_name] = wield_index
end)


return {
	--- @type fun(callback:wield_item.callbacks.OnIndexChange)
	on_index_change = Event.on(Event.Type.on_index_change),
}
