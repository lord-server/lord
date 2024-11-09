-- default relay commands

-- !status
beerchat.register_relaycommand("status", function()
	return minetest.get_server_status(nil, false)
end)

-- !players
beerchat.register_relaycommand("players", function()
	-- loop all online names into a list
	local player_names = {}
	for _, player in ipairs(minetest.get_connected_players()) do
		table.insert(player_names, player:get_player_name())
	end

	-- abort if there are no players connected
	if 0 == #player_names then
		return 'No players connected.'
	end

	-- collapse list into coma separated string
	return 'Players: ' .. table.concat(player_names, ', ')
end)

-- !help
beerchat.register_relaycommand("help", function()
	local available = beerchat.get_available_relaycommands()
	return 'Available commands: ' .. table.concat(available, ', ')
end)
