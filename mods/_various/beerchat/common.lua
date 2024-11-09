
-- Add/join player to channel
beerchat.add_player_channel = function(name, channel, mode)
	if not beerchat.playersChannels[name][channel] then
		local meta = minetest.get_player_by_name(name):get_meta()
		beerchat.playersChannels[name][channel] = mode or "joined"
		meta:set_string("beerchat:channels", minetest.write_json(beerchat.playersChannels[name]))
	end
end

-- Remove/part player from channel
beerchat.remove_player_channel = function(name, channel)
	if beerchat.playersChannels[name][channel] then
		local meta = minetest.get_player_by_name(name):get_meta()
		beerchat.playersChannels[name][channel] = nil
		meta:set_string("beerchat:channels", minetest.write_json(beerchat.playersChannels[name]))
	end
end

-- Set active channel of player, join player to channel if not already joined
beerchat.set_player_channel = function(name, channel)
	if beerchat.currentPlayerChannel[name] ~= channel then
		beerchat.add_player_channel(name, channel)
		local meta = minetest.get_player_by_name(name):get_meta()
		beerchat.currentPlayerChannel[name] = channel
		meta:set_string("beerchat:current_channel", channel)
	end
end

beerchat.get_player_channel = function(name)
	if type(name) == "string" then
		local channel = beerchat.currentPlayerChannel[name]
		if channel and beerchat.channels[channel] then
			return channel
		end
	end
end

beerchat.fix_player_channel = function(name, notify)
	if notify or notify == nil then
		minetest.chat_send_player(
			name,
			"Channel "..beerchat.currentPlayerChannel[name].." does not exist, switching back to "..
				beerchat.main_channel_name..". Please resend your message"
		)
	end
	beerchat.set_player_channel(name, beerchat.main_channel_name)
end

beerchat.join_channel = function(name, channel, set_default)
	if not beerchat.execute_callbacks('before_join', name, channel) then
		return false
	end
	(set_default and beerchat.set_player_channel or beerchat.add_player_channel)(name, channel)
	beerchat.sound_play(name, "beerchat_chirp")
	local msg = beerchat.format_message("|#${channel_name}| Joined channel", { channel_name = channel })
	minetest.chat_send_player(name, msg)
	return true
end

beerchat.allow_private_message = function(name, target)
	return beerchat.execute_callbacks("before_send_pm", name, "", target)
end

beerchat.has_player_muted_player = function(name, other_name)
	return not beerchat.allow_private_message(other_name, name)
end

beerchat.is_player_subscribed_to_channel = function(name, channel)
	return (nil ~= beerchat.playersChannels[name])
		and (nil ~= beerchat.playersChannels[name][channel])
end

beerchat.sound_play = beerchat.enable_sounds and function (target, sound)
	minetest.sound_play(sound, { to_player = target, gain = beerchat.sounds_default_gain }, true)
end or function() end

beerchat.send_message = function(name, message, data)
	if beerchat.execute_callbacks('before_send', name, message or data.message, data) then
		if type(data) == "table" then
			minetest.chat_send_player(name, data.message or message)
		else
			minetest.chat_send_player(name, message)
		end
	end
	--[[ TODO: read player settings for channel sounds, also move this from core to some sound effect extension.
		ALSO: this does not belong here but in low priority `on_send_on_channel` event handler.
	if channel ~= beerchat.main_channel_name then
		beerchat.sound_play(name, beerchat.channel_message_sound)
	end --]]
end
