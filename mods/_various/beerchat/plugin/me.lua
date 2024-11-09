
local me_message_string = "|#${channel_name}| * ${from_player} ${message}"

minetest.register_chatcommand("me", {
	params = "<Message>",
	description = "Send message in the \"* player message\" format, e.g. /me eats pizza becomes |#"..
		beerchat.main_channel_name.."| * Player01 eats pizza",
	func = function(name, param)
		local msg = beerchat.default_on_receive(name, param)
		if not msg then
			return true
		end
		local channel = beerchat.get_player_channel(name)
		if not channel then
			beerchat.fix_player_channel(name, true)
		elseif msg.message == "" then
			minetest.chat_send_player(name, "Please enter the message you would like to send.")
		elseif not beerchat.playersChannels[name][channel] then
			minetest.chat_send_player(name, "You need to join channel " .. channel
				.. " in order to be able to send messages to it")
		else
			msg.channel = channel
			if not beerchat.execute_callbacks('before_send_on_channel', name, msg, channel) then
				return true
			end
			beerchat.on_me_message(channel, name, msg.message)
			local message = msg.message
			for _,player in ipairs(minetest.get_connected_players()) do
				local target = player:get_player_name()
				if beerchat.execute_callbacks('on_send_on_channel', msg.name, msg, target) then
					beerchat.send_message(target, message, {
						name = name,
						message = beerchat.format_message(me_message_string, {
							to_player = target,
							channel_name = channel,
							from_player = name,
							message = msg.message
						})
					})
				end
			end
		end
		return true
	end
})
