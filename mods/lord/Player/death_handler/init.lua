-- HACK:
local dead_players = {}

-- Copy the callbacks
local dieplayer_callbacks = table.copy(core.registered_on_dieplayers)
-- Erase original callback table
for i, _ in pairs(core.registered_on_dieplayers) do
	core.registered_on_dieplayers[i] = nil
end

core.register_on_respawnplayer(function(player)
	local name = player:get_player_name()
	dead_players[name] = nil
end)

core.register_on_dieplayer(function(player)
	local name = player:get_player_name()
	if dead_players[name] then
		return
	else
		dead_players[name] = true
		for _, fn in pairs(dieplayer_callbacks) do
			fn(player)
		end
	end
end)
