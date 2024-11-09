--luacheck: no_unused_args

-- Jail channel is where you put annoying missbehaving users with /force2channel
beerchat.jail = {
	channel_name = minetest.settings:get("beerchat.jail.channel_name") or "grounded",
	format_string = minetest.settings:get("beerchat.jail.format_string") or beerchat.main_channel_message_string,
	priv = minetest.settings:get("beerchat.jail.priv") or "ban",
}
local owner = minetest.settings:get("beerchat.jail.owner") or beerchat.channels[beerchat.main_channel_name].owner
local color = minetest.settings:get("beerchat.jail.color") or beerchat.channels[beerchat.main_channel_name].color

beerchat.channels[beerchat.jail.channel_name] = { owner = owner, color = color }

beerchat.jail.list = {}

beerchat.is_player_jailed = function(name)
	return not not beerchat.jail.list[name]
end

beerchat.jail.chat_jail = function(name, param)
	if not param or param == "" then
		return false, "ERROR: Invalid number of arguments. Please supply the player name(s)."
	end

	local channel = beerchat.jail.channel_name
	if not beerchat.channels[channel] then
		return false, "ERROR: Channel " .. channel
			.. " does not exist. Someone deleted it... fix by adding before_delete_chan event :)"
	end

	local player_names = string.gmatch(param, "[^%s,]+")
	for player_name in player_names do
		local player = minetest.get_player_by_name(player_name)
		if player then
			if not beerchat.is_player_jailed(player_name) then
				local from_channel = beerchat.get_player_channel(player_name) or beerchat.main_channel_name
				-- force join and set default channel
				beerchat.set_player_channel(player_name, channel)
				-- handle chat jail lock through on_forced_join callback
				beerchat.execute_callbacks('on_forced_join', name, player_name, channel, from_channel)
			else
				minetest.chat_send_player(name, "WARNING: " .. player_name .. " is already jailed, skipping.")
			end
		else
			minetest.chat_send_player(name, "WARNING: " .. player_name .. " does not exist or is not online.")
		end
	end
	return true
end
minetest.register_chatcommand("chat_jail", {
	params = "<Player Name> [<Player Name> ...]",
	description = ("Move players <Player Name> to jail channel. Requires %s privilege."):format(beerchat.jail.priv),
	privs = { [beerchat.jail.priv] = true },
	func = beerchat.jail.chat_jail
})

beerchat.jail.chat_unjail = function(name, param)
	if not param or param == "" then
		-- List chat jailed online players
		local names = {}
		for player_name,_ in pairs(beerchat.jail.list) do
			table.insert(names, player_name)
		end
		if #names > 0 then
			minetest.chat_send_player(name, "Jailed players currently online: " .. table.concat(names, ", "))
		else
			minetest.chat_send_player(name, "No jailed players currently online.")
		end
		return true
	end
	local player_names = string.gmatch(param, "[^%s,]+")
	for player_name in player_names do
		local player = minetest.get_player_by_name(player_name)
		if player then
			if beerchat.is_player_jailed(player_name) then
				-- Release player from chat jail
				local from_channel = beerchat.get_player_channel(player_name) or beerchat.main_channel_name
				local to_channel = player:get_meta():get("beerchat:jailed") or beerchat.main_channel_name
				if to_channel == beerchat.jail.channel_name or to_channel == "1" then
					-- Always remove player from jail channel when unjailing, also do not use 1 as valid channel...
					to_channel = beerchat.main_channel_name
				end
				beerchat.set_player_channel(player_name, to_channel)
				beerchat.execute_callbacks('on_forced_join', name, player_name, to_channel, from_channel)
			else
				minetest.chat_send_player(name, "WARNING: " .. player_name .. " is not jailed, skipping.")
			end
		else
			minetest.chat_send_player(name, "WARNING: " .. player_name .. " does not exist or is not online.")
		end
	end
	return true
end
minetest.register_chatcommand("chat_unjail", {
	params = "[<Player Name> [<Player Name> ...]]",
	description = ("Release players <Player Name> from jail. Requires %s privilege."):format(beerchat.jail.priv),
	privs = { [beerchat.jail.priv] = true },
	func = beerchat.jail.chat_unjail
})

beerchat.register_callback('after_joinplayer', function(player)
	local name = player:get_player_name()
	local meta = player:get_meta()
	local jailed = meta:get("beerchat:jailed")

	-- Remove old 0 value indicating that playes has been jailed before but is not currently jailed
	if jailed == "0" then
		meta:set_string("beerchat:jailed", "")
		jailed = nil
	end

	if jailed then
		beerchat.jail.list[name] = true
		beerchat.set_player_channel(name, beerchat.jail.channel_name)
	end
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	beerchat.jail.list[name] = nil
end)

beerchat.register_callback('before_invite', function(name, recipient, channel)
	if beerchat.is_player_jailed(name) then
		return false, name .. " is in chat-jail, no inviting."
	end
end)

beerchat.register_callback('before_mute', function(name, target)
	if beerchat.is_player_jailed(name) then
		return false, "You are in chat-jail, no muting for you."
	end
end)

beerchat.register_callback('before_join', function(name, channel)
	if beerchat.is_player_jailed(name) then
		return false, "You are in chat-jail, no joining channels for you."
	end
end)

beerchat.register_callback('before_leave', function(name, channel)
	if beerchat.is_player_jailed(name) then
		return false, "You are in chat-jail, no leaving for you."
	end
end)

beerchat.register_callback("before_send_on_channel", function(name, msg)
	if msg.channel ~= beerchat.jail.channel_name and beerchat.is_player_jailed(name) then
		-- redirect #channel messages sent by jailed players toward jail channel and reconstruct full command.
		msg.message = "#"..msg.channel.." "..msg.message
		msg.channel = beerchat.jail.channel_name
	end
end)

beerchat.register_callback('before_send', function(target, message, data)
	if data and beerchat.is_player_jailed(data.name) then
		if data.channel == beerchat.jail.channel_name then
			-- mute pings but allow chatting on jail channel, format without colored plaeyr names
			minetest.chat_send_player(target, beerchat.format_string(beerchat.jail.format_string, {
				channel_name = minetest.colorize(color, beerchat.jail.channel_name),
				channel_owner = owner,
				from_player = data.name,
				message = message,
				time = os.date("%X")
			}))
		end
		return false
	end
end)

beerchat.register_callback('before_switch_chan', function(name)
	if beerchat.is_player_jailed(name) then
		return false, "You are in chat-jail, no changing channels for you."
	end
end)

beerchat.register_callback('before_send_pm', function(name, message, target)
	if beerchat.is_player_jailed(name) then
		return false, "You are in chat-jail, no PMs for you."
	end
end)

beerchat.register_callback('before_whisper', function(name, message, channel, range)
	if beerchat.is_player_jailed(name) then
		return false, "You are in chat-jail, you may not whisper."
	end
end)

beerchat.register_callback('before_check_muted', function(name, muted)
	if beerchat.is_player_jailed(name) then
		return false
	end
end)

beerchat.register_callback('on_forced_join', function(name, target, channel, from_channel)
	-- going to/from jail?
	if channel == beerchat.jail.channel_name then
		if beerchat.is_player_jailed(target) then
			minetest.chat_send_player(name, "WARNING: " .. target .. " is already jailed, not jailing again.")
			return
		end
		local player = minetest.get_player_by_name(target)
		if player then
			local meta = player:get_meta()
			-- save previous channel, lock player to jail channel and set jail channel as default
			meta:set_string("beerchat:jailed", from_channel or beerchat.main_channel_name)
			beerchat.jail.list[target] = true
		else
			minetest.chat_send_player(name, "ERROR: " .. target .. " does not exist or is not online.")
		end
	elseif beerchat.is_player_jailed(target) then
		local player = minetest.get_player_by_name(target)
		if player then
			local meta = player:get_meta()
			-- restore previous channel, remove jail channel from player channels and release player from chat jail
			beerchat.remove_player_channel(target, beerchat.jail.channel_name)
			meta:set_string("beerchat:jailed", "")
			beerchat.jail.list[target] = nil
			-- inform user
			minetest.chat_send_player(target, "You have been released from chat jail.")
			-- feedback to mover
			minetest.chat_send_player(name, "Released " .. target .. " from chat jail.")
		end
	end
end)
