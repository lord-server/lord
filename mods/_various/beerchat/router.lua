
-- Entry point for all messages handled by beerchat, ensures that all on_receive hooks accept
-- message before allowing any plugin or default handler to actually handle message.

local on_chat_message_handlers = {}

function beerchat.register_on_chat_message(func)
	table.insert(on_chat_message_handlers, func)
end

local function default_message_handler(msg)
	-- Do not allow players without shout priv to chat in channels
	if not minetest.check_player_privs(msg.name, "shout") then
		return true
	end

	msg.channel = beerchat.get_player_channel(msg.name)
	if not msg.channel then
		beerchat.fix_player_channel(msg.name, true)
	elseif msg.message == "" then
		minetest.chat_send_player(msg.name, "Please enter the message you would like to send to the channel")
	elseif not beerchat.is_player_subscribed_to_channel(msg.name, msg.channel) then
		minetest.chat_send_player(msg.name, "You need to join this channel in order to be able to send messages to it")
	else
		beerchat.send_on_channel(msg)
	end
	return true
end

function beerchat.default_on_receive(name, message)
	local msg_data = { name = name, message = message }
	if beerchat.execute_callbacks('on_receive', msg_data) then
		return msg_data
	end
	minetest.log("verbose", "Beerchat message discarded by on_receive hook, contents went to /dev/null")
end

-- All messages are handled either by sending to channel or through special plugin function.
minetest.register_on_chat_message(function(name, message)
	-- Execute on_receive callbacks allowing modifications to sender and message
	local msg = beerchat.default_on_receive(name, message)
	if not msg then
		return true
	end

	-- Execute message handlers
	for _, handler in ipairs(on_chat_message_handlers) do
		if handler(msg.name, msg.message) then
			-- Last executed handler marked message as handled, return
			return true
		end
	end

	-- None of extensions handled current message, call through default message handler
	return default_message_handler(msg)
end)
