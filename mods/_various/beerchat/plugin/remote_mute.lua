local remote_muted = {}

minetest.register_chatcommand("remote_mute", {
	params = "<Player Name> [<Player Name> ...]",
	description = ("Mute remote users. Requires %s privilege."):format(beerchat.jail.priv),
	privs = { [beerchat.jail.priv] = true },
	func = function(_, param)
		if not param or param == "" then
			return false, "ERROR: Invalid number of arguments. Please supply the player name(s)."
		end
		local names = string.gmatch(param, "[^%s,]+")
		for remote_name in names do
			remote_muted[remote_name] = true
		end
		return true
	end
})

minetest.register_chatcommand("remote_unmute", {
	params = "[<Player Name> <Player Name> ...]",
	description = ("Unmute remote users or list muted remote users. Requires %s privilege."):format(beerchat.jail.priv),
	privs = { [beerchat.jail.priv] = true },
	func = function(name, param)
		if not param or param == "" then
			local names = {}
			for remote_name,_ in pairs(remote_muted) do
				table.insert(names, remote_name)
			end
			if #names > 0 then
				minetest.chat_send_player(name, "Muted remote users: " .. table.concat(names, ", "))
			else
				minetest.chat_send_player(name, "No muted remote users.")
			end
		else
			local names = string.gmatch(param, "[^%s,]+")
			for remote_name in names do
				remote_muted[remote_name] = nil
			end
		end
		return true
	end
})

beerchat.register_callback('on_http_receive', function(msg_data)
	if remote_muted[msg_data.username] then
		return false
	end
end)
