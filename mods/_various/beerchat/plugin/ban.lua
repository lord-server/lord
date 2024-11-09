--luacheck: no_unused_args

--
-- Data storage and helpers to persist channel bans through server restarts
--

local channels = setmetatable(minetest.deserialize(beerchat.mod_storage:get("ban.channels")) or {}, {
	__index = function(p,k)
		return setmetatable({}, {
			__newindex = function(t, n, v)
				if not rawget(p,k) then rawset(p,k,{}) end
				p[k][n] = v
			end
		})
	end
})

local function write_storage()
	local data = minetest.serialize(channels)
	beerchat.mod_storage:set_string("ban.channels", data)
end

--
-- Register basic API for channel bans
--

beerchat.ban = {
	priv = minetest.settings:get("beerchat.ban.priv") or "ban"
}

beerchat.ban.is_player_banned = function(channel, player_name)
	return not not channels[channel][player_name]
end

beerchat.ban.ban_player = function(channel, player_name)
	-- Can store timestamp or table for temporary ban or extended ban configuration
	channels[channel][player_name] = true
end

beerchat.ban.unban_player = function(channel, player_name)
	channels[channel][player_name] = nil
end

--
-- Register beerchat event handlers for channel bans
--

beerchat.register_callback('before_send_on_channel', function(name, msg)
	if beerchat.ban.is_player_banned(msg.channel, name) then
		return false, "Sorry but you are banned on #"..msg.channel..", you are not allowed to send messages there."
	end
end)

--
-- Register chat commands for channel bans
--

local function channel_ban(name, param)
	if not param or param == "" then
		return false, "ERROR: Invalid number of arguments. Please supply the player name(s)."
	end

	local channel = beerchat.get_player_channel(name)
	if not channel then
		beerchat.fix_player_channel(name, true)
		return true
	end

	local player_names = string.gmatch(param, "[^%s,]+")
	for player_name in player_names do
		if not beerchat.ban.is_player_banned(channel, player_name) then
			if not minetest.player_exists(player_name) then
				-- Inform that player does not exist in database but add record anyway to allow banning external users
				minetest.chat_send_player(name, "WARNING: " .. player_name .. " is external user or does not exist.")
			end
			beerchat.ban.ban_player(channel, player_name)
		else
			minetest.chat_send_player(name, "Channel ban: " .. player_name .. " is already banned on #"..channel)
		end
	end
	write_storage()
	return true
end

minetest.register_chatcommand("channel_ban", {
	params = "<Player Name> [<Player Name> ...]",
	description = ("Ban players <Player Name> on current channel. Requires %s privilege."):format(beerchat.ban.priv),
	privs = { [beerchat.ban.priv] = true },
	func = channel_ban
})

local function channel_unban(name, param)
	local channel = beerchat.get_player_channel(name)
	if not channel then
		beerchat.fix_player_channel(name, true)
		return true
	end

	if not param or param == "" then
		-- List banned names
		local names = {}
		for player_name,_ in pairs(channels[channel]) do
			table.insert(names, player_name)
		end
		if #names > 0 then
			minetest.chat_send_player(name, "Players banned on #"..channel..": " .. table.concat(names, ", "))
		else
			minetest.chat_send_player(name, "Nobody is banned on #"..channel)
		end
	else
		-- Unban players
		local player_names = string.gmatch(param, "[^%s,]+")
		for player_name in player_names do
			if beerchat.ban.is_player_banned(channel, player_name) then
				beerchat.ban.unban_player(channel, player_name)
			else
				minetest.chat_send_player(name, "WARNING: " .. player_name .. " is not banned on #"..channel)
			end
		end
	end
	write_storage()
	return true
end

minetest.register_chatcommand("channel_unban", {
	params = "[<Player Name> [<Player Name> ...]]",
	description = ("Unban players <Player Name> on current channel. Requires %s privilege."):format(beerchat.ban.priv),
	privs = { [beerchat.ban.priv] = true },
	func = channel_unban
})
