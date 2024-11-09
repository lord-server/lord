local channel_created_string = "|#${channel_name}| Channel created"
local channel_updated_string = "|#${channel_name}| Channel updated"
local channel_invitation_string = "|#${channel_name}| Channel invite from (${from_player}), "
	.. "to join the channel, do /jc ${channel_name},${channel_password} after "
	.. "which you can send messages to the channel via #${channel_name}: message"
local channel_invited_string = "|#${channel_name}| Invite sent to ${to_player}"
local channel_deleted_string = "|#${channel_name}| Channel deleted"
local channel_left_string = "|#${channel_name}| Left channel"
local channel_already_deleted_string = "|#${channel_name}| Channel seems to have already "
	.. "been deleted, will unregister channel from your list of channels"

local leave_channel_sound = "beerchat_chirp"			-- Sound when you leave a channel
local channel_invite_sound = "beerchat_chirp"			-- Sound when sending/ receiving an invite to a channel

local create_channel = {
	params = "<Channel Name>,<Password (optional)>,<Color (optional, default is #ffffff)>",
	description = "Create or edit a channel named <Channel Name> with optional <Password> and "
		.. "hexadecimal <Color> starting with # (e.g. #00ff00 for green). Use comma's "
		.. "to separate the arguments, e.g. "
		.. "/cc my secret channel,#0000ff for a blue colored my secret channel without password",
	func = function(lname, param)
		local lowner = lname

		if not param or param == "" then
			return false, "ERROR: Invalid number of arguments. Please supply the channel name as a minimum."
		end

		local str = string.split(param:gsub("^#",""), ",")
		if #str > 3 then
			return false, "ERROR: Invalid number of arguments. 4 parameters passed, "
				.. "maximum of 3 allowed: <Channel Name>,<Password>,<Color>"
		end

		local lchannel_name = string.trim(str[1] or ""):gsub("%s", "-")
		if lchannel_name == "" then
			return false, "ERROR: You must supply a channel name"
		end

		if lchannel_name == beerchat.main_channel_name then
			return false, "ERROR: You cannot use channel name \"" .. beerchat.main_channel_name .. "\""
		end

		local msg = channel_created_string
		if beerchat.channels[lchannel_name] then
			local cowner = beerchat.channels[lchannel_name].owner
			if not cowner or cowner == "" or cowner ~= lowner then
				return false, "ERROR: Channel " .. lchannel_name
					.. " already exists, owned by player " .. beerchat.channels[lchannel_name].owner
			end
			msg = channel_updated_string
		end

		local arg2 = str[2]
		local lcolor = beerchat.default_channel_color
		local lpassword = ""

		if arg2 then
			if string.sub(arg2, 1, 1) ~= "#" then
				lpassword = arg2
			else
				lcolor = string.lower(str[2])
			end
		end

		if #str == 3 then
			lcolor = string.lower(str[3])
		end

		beerchat.channels[lchannel_name] = { owner = lowner, name = lchannel_name,
			password = lpassword, color = lcolor }
		beerchat.mod_storage:set_string("channels", minetest.write_json(beerchat.channels))

		beerchat.add_player_channel(lowner, lchannel_name, "owner")
		beerchat.sound_play(lowner, beerchat.channel_management_sound)
		minetest.chat_send_player(lowner, beerchat.format_message(msg, { channel_name = lchannel_name }))
		return true
	end
}

local delete_channel = {
	params = "<Channel Name>",
	description = "Delete channel named <Channel Name>. You must be the owner of the "
		.. "channel to be allowed to delete the channel",
	func = function(name, param)
		if not param or param == "" then
			return false, "ERROR: Invalid number of arguments. Please supply the "
				.. "channel name"
		elseif param == beerchat.main_channel_name then
			return false, "ERROR: Cannot delete the main channel!"
		elseif not beerchat.channels[param] then
			return false, "ERROR: Channel " .. param .. " does not exist"
		elseif name ~= beerchat.channels[param].owner and not minetest.check_player_privs(name, beerchat.admin_priv) then
			return false, "ERROR: You are not the owner of channel " .. param
		end

		local delete = { channel = param }
		if not beerchat.execute_callbacks('before_delete_channel', name, delete) then
			return true
		end

		local color = beerchat.channels[delete.channel].color
		beerchat.channels[delete.channel] = nil
		beerchat.mod_storage:set_string("channels", minetest.write_json(beerchat.channels))

		beerchat.remove_player_channel(name, delete.channel)

		beerchat.sound_play(name, beerchat.channel_management_sound)
		minetest.chat_send_player(name, beerchat.format_message(
			channel_deleted_string, { channel_name = delete.channel, color = color }
		))
		return true
	end
}

local my_channels = {
	params = "<Channel Name optional>",
	description = "List the channels you have joined or are the owner of, "
		.. "or show channel information when passing channel name as argument",
	func = function(name, param)
		if not param or param == "" then
			beerchat.sound_play(name, beerchat.channel_management_sound)
			minetest.chat_send_player(name, dump2(beerchat.playersChannels[name])
				.. '\nYour default channel is: '
				.. (beerchat.currentPlayerChannel[name] or '<none>'))
		else
			if beerchat.playersChannels[name][param] then
				beerchat.sound_play(name, beerchat.channel_management_sound)
				minetest.chat_send_player(name, dump2(beerchat.channels[param]))
			else
				minetest.chat_send_player(name, "ERROR: Channel not in your channel list")
				return false
			end
		end
		return true
	end
}

local join_channel = {
	params = "<Channel Name>,<Password (only mandatory if channel was created using "
		.. "a password)>",
	description = "Join channel named <Channel Name>. After joining you will see messages "
		.. "sent to that channel (in addition to the other channels you have joined)",
	func = function(name, param)
		if not param or param == "" then
			return false, "ERROR: Invalid number of arguments. Please supply the channel "
				.. "name as a minimum."
		end

		local str = string.split(param:gsub("^#",""), ",")
		local channel_name = str[1] or "<empty>"

		if not beerchat.channels[channel_name] then
			return false, "ERROR: Channel " .. channel_name .. " does not exist."
		end

		if beerchat.playersChannels[name] and beerchat.playersChannels[name][channel_name] then
			return false, "ERROR: You already joined "..channel_name..", no need to rejoin"
		end

		if beerchat.channels[channel_name].password and beerchat.channels[channel_name].password ~= "" then
			if #str == 1 then
				return false, "ERROR: This channel requires that you supply a password. "
					.. "Supply it in the following format: /jc my channel,password01"
			end
			if str[2] ~= beerchat.channels[channel_name].password then
				return false, "ERROR: Invalid password."
			end
		end

		return beerchat.join_channel(name, channel_name)
	end
}

local leave_channel = {
	params = "<Channel Name>",
	description = "Leave channel named <Channel Name>. When you leave the channel you "
		.. "can no longer send / receive messages from that channel. "
		.. "NOTE: You can also leave the main channel",
	func = function(name, channel)
		if not channel or channel == "" then
			return false, "ERROR: Invalid number of arguments. Please supply the channel name."
		end

		if not beerchat.playersChannels[name][channel] then
			return false, "ERROR: You are not member of " .. channel .. ", no need to leave."
		end

		if not beerchat.execute_callbacks('before_leave', name, channel) then
			return false
		end

		beerchat.remove_player_channel(name, channel)

		beerchat.sound_play(name, leave_channel_sound)
		if not beerchat.channels[channel] then
			minetest.chat_send_player(name,
				beerchat.format_message(channel_already_deleted_string,
					{ channel_name = channel })
			)
		else
			minetest.chat_send_player(name,
				beerchat.format_message(channel_left_string,
					{ channel_name = channel })
			)
		end
		return true
	end
}

local invite_channel = {
	params = "<Channel Name>,<Player Name>",
	description = "Invite player named <Player Name> to channel named <Channel Name>. "
		.. "You must be the owner of the channel in order to invite others.",
	func = function(name, param)
		if not param or param == "" then
			return false, "ERROR: Invalid number of arguments. Please supply the channel "
				.. "name and the player name."
		end

		local channel_name, player_name = string.match(param, "#?(.*),(.*)")

		if not channel_name or channel_name == "" then
			return false, "ERROR: Channel name is empty."
		end

		if not player_name or player_name == "" then
			return false, "ERROR: Player name not supplied or empty."
		end

		if not beerchat.channels[channel_name] then
			return false, "ERROR: Channel " .. channel_name .. " does not exist."
		end

		if name ~= beerchat.channels[channel_name].owner then
			return false, "ERROR: You are not the owner of channel " .. param .. "."
		end

		if not minetest.get_player_by_name(player_name) then
			return false, "ERROR: " .. player_name .. " does not exist or is not online."
		else
			if not beerchat.execute_callbacks('before_invite', name, player_name, channel_name) then
				return false
			end
			if not beerchat.has_player_muted_player(player_name, name) then
				beerchat.sound_play(player_name, channel_invite_sound)
				-- Sending the message
				minetest.chat_send_player(
					player_name,
					beerchat.format_message(channel_invitation_string,
						{ channel_name = channel_name, from_player = name })
				)
			end
			beerchat.sound_play(name, channel_invite_sound)
			minetest.chat_send_player(
				name,
				beerchat.format_message(channel_invited_string,
					{ channel_name = channel_name, to_player = player_name })
			)
		end
		return true
	end
}

minetest.register_chatcommand("cc", create_channel)
minetest.register_chatcommand("create_channel", create_channel)
minetest.register_chatcommand("dc", delete_channel)
minetest.register_chatcommand("delete_channel", delete_channel)

minetest.register_chatcommand("mc", my_channels)
minetest.register_chatcommand("my_channels", my_channels)

minetest.register_chatcommand("jc", join_channel)
minetest.register_chatcommand("join_channel", join_channel)
minetest.register_chatcommand("lc", leave_channel)
minetest.register_chatcommand("leave_channel", leave_channel)
minetest.register_chatcommand("ic", invite_channel)
minetest.register_chatcommand("invite_channel", invite_channel)
