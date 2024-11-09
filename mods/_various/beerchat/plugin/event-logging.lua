
beerchat.register_callback('on_forced_join', function(name, target, channel, from_channel)
	-- does not make sense to log or inform everyone about moves that wont affect anything
	if channel == from_channel then
		minetest.chat_send_player(name, "Channel of " .. target .. " was already #" .. channel .. ".")
		return
	end
	-- inform user
	minetest.chat_send_player(target, name .. " has set your default channel to #" .. channel .. ".")
	-- feedback to mover
	minetest.chat_send_player(name, "Set default channel of " .. target .. " to #" .. channel .. ".")
	-- inform moderators, if moderator channel is set
	local move_msg = name .. " has set default channel of " .. target
		.. " from #" .. from_channel .. " to #" .. channel .. "."
	if beerchat.moderator_channel_name then
		local sender = beerchat.channels[beerchat.main_channel_name].owner
		beerchat.send_on_channel({name=sender, channel=beerchat.moderator_channel_name, message=move_msg})
	end
	-- inform admin
	minetest.log("action", "CHAT " .. move_msg)
end)

beerchat.register_callback('before_send_on_channel', function(_, msg)
	minetest.log("action", "[beerchat] CHAT #" .. msg.channel .. " <" .. msg.name .. "> " .. msg.message)
end)
