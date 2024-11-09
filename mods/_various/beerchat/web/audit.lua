-- auth fail
minetest.register_on_auth_fail(function(name, ip)
	beerchat.on_channel_message("audit", "SYSTEM", "Player '" .. name ..
		"' from ip " .. ip .. " tried to connect with wrong password")
end)

-- anticheat
minetest.register_on_cheat(function(player, cheat)
	local playername = player:get_player_name()
	local type = cheat.type
	beerchat.on_channel_message("audit", "SYSTEM", "Player '" .. playername ..
		"' triggered anticheat: '" .. (type or "<unknown>") ..
		"' at position: " .. minetest.pos_to_string(vector.floor(player:get_pos())))
end)
