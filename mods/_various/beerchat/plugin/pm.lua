local private_message_string = "[PM] from (${from_player}) ${message}"
local self_message_string = "(${from_player} utters to him/ herself) ${message}"
local private_message_sent_string = "[PM] sent to @(${to_player}) ${message}"

local private_message_sound = "beerchat_chime" -- Sound when you receive a private message
local self_message_sound = "beerchat_utter" -- Sound when you send a private message to yourself

-- @ chat a.k.a. at chat/ PM chat code, to PM players using @player1 only you can read this player1!!
local atchat_lastrecv = {}

-- cleanup upon leave
minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	atchat_lastrecv[name] = nil
end)

local send_pm = function(name, msg, target, ping)
	-- Checking if the target exists
	if not minetest.get_player_by_name(target) then
		minetest.chat_send_player(name, ""..target.." is not online")
	elseif target ~= name then
		if beerchat.execute_callbacks("before_send_pm", name, msg, target) then
			-- Sending the message
			minetest.chat_send_player(
				target,
				beerchat.format_message(
					private_message_string, {
						from_player = name,
						to_player = target,
						message = msg
					}
				)
			)
			if ping then
				beerchat.sound_play(target, private_message_sound)
			end
			return true
		end
	else
		minetest.chat_send_player(
			target,
			beerchat.format_message(
				self_message_string, {
					from_player = name,
					to_player = target,
					message = msg
				}
			)
		)
		beerchat.sound_play(target, self_message_sound)
		return true
	end
	return false
end

local send_pm_all = function(name, msg, targets)
	local sent = {}
	for target in targets do
		if send_pm(name, msg, target, true) then
			table.insert(sent, target)
		end
	end
	-- Register the chat in the target persons last spoken to table
	if #sent > 0 then
		atchat_lastrecv[name] = sent
		minetest.chat_send_player(
			name,
			beerchat.format_message(
				private_message_sent_string, {
					to_player = table.concat(sent, ","),
					message = msg
				}
			)
		)
	end
end

beerchat.register_on_chat_message(function(name, message)
	minetest.log("action", "CHAT " .. name .. ": " .. message)
	local players, msg = string.match(message, "^@([^%s:]*)[%s:](.*)")
	if players and msg then
		if msg == "" then
			minetest.chat_send_player(name, "Please enter the private message you would like to send")
		else
			if players ~= "" then
				send_pm_all(name, msg, string.gmatch(","..players..",", ",([^,]+),"))
			elseif atchat_lastrecv[name] and #atchat_lastrecv[name] > 0 then
				local i = 0
				send_pm_all(name, msg, function() i = i + 1; return atchat_lastrecv[name][i] end)
			else
				minetest.chat_send_player(name, "You have not sent private messages to anyone yet, " ..
					"please specify player names to send message to")
			end
		end
		return true
	end
end)

local msg_override = {
	params = "<Player Name> <Message>",
	description = "Send private message to player, "..
		"for compatibility with the old chat command but with new style chat muting support "..
		"(players will not receive your message if they muted you) and multiple (comma separated) player support",
	func = function(name, param)
		local msg_data = beerchat.default_on_receive(name, param)
		if not msg_data then
			return true
		end
		name = msg_data.name
		param = msg_data.message

		minetest.log("action", "PM " .. name .. ": " .. param)
		local players, msg = string.match(param, "^(.-) (.*)")
		if players and msg then
			if players == "" then
				minetest.chat_send_player(name, "ERROR: Please enter the private message you would like to send")
				return false
			elseif msg == "" then
				minetest.chat_send_player(name, "ERROR: Please enter the private message you would like to send")
				return false
			elseif players and players ~= "" then
				local targets = string.gmatch(","..players..",", ",([^,]+),")
				send_pm_all(name, msg, targets)
			end
			return true
		end
	end
}

minetest.register_chatcommand("msg", msg_override)
minetest.register_chatcommand("pm", msg_override)
minetest.register_chatcommand("dm", msg_override)
