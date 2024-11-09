--
-- Adds chat command /force2channel <Channel Name>, <Player Name>
-- Command requires ban privilege.
--

beerchat.force_player_to_channel = function(name, param)
	if not param or param == "" then
		return false, "ERROR: Invalid number of arguments. Please supply the "
			.. "channel name and the player name(s)."
	end

	local channel_name, player_names = string.match(param, "^([^,]+),%s?(.*)$")

	if not channel_name or channel_name == "" then
		return false, "ERROR: Channel name is empty."
	end

	if not player_names or player_names == "" then
		return false, "ERROR: Player name(s) not supplied or empty."
	end

	if not beerchat.channels[channel_name] then
		return false, "ERROR: Channel " .. channel_name .. " does not exist."
	end

	local errors = {}
	for player_name in string.gmatch(player_names, '[^%s,]+') do
		if not minetest.get_player_by_name(player_name) then
			table.insert(errors, 'ERROR: "' .. player_name .. '" does not exist or is not online.')
		else
			local from_channel = beerchat.get_player_channel(player_name) or beerchat.main_channel_name
			-- force join and set default channel
			beerchat.set_player_channel(player_name, channel_name)
			-- execute callbacks after action
			beerchat.execute_callbacks('on_forced_join', name, player_name, channel_name, from_channel)
		end
	end
	if 0 == #errors then return true end
	return false, table.concat(errors, '\n')
end

local ban_priv = beerchat.jail and beerchat.jail.priv or 'ban'
minetest.register_chatcommand("force2channel", {
	params = "<Channel Name>,<Player Name>[,<Player2 Name>,...]",
	description = ("Force player named <Player Name> to channel named <Channel Name>. "
		.. "Requires %s privilege."):format(ban_priv),
	privs = { [ban_priv] = true },
	func = beerchat.force_player_to_channel
})

