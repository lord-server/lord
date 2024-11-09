-- Message string formats -- Change these if you would like different formatting
--
-- These can be changed to show "~~~#mychannel~~~ <player01> message" instead of "|#mychannel| or any
-- other format you like such as removing the channel name from the main channel, putting channel or
-- player names at the end of the chat message, etc.
--
-- The following parameters are available and can be specified :
-- ${channel_name} name of the channel
-- ${channel_owner} owner of the channel
-- ${channel_password} password to use when joining the channel, used e.g. for invites
-- ${from_player} the player that is sending the message
-- ${to_player} player to which the message is sent, will contain multiple player names
-- e.g. when sending a PM to multiple players
-- ${message} the actual message that is to be sent
-- ${time} the current time in 24 hour format, as returned from os.date("%X")
--

local send_on_local_channel = function(msg)
	local message = msg.message
	for _,player in ipairs(minetest.get_connected_players()) do
		local target = player:get_player_name()
		if beerchat.execute_callbacks('on_send_on_channel', msg.name, msg, target) then
			beerchat.send_message(target, message, msg)
		end
	end
end

beerchat.send_on_local_channel = function(msg)
	if beerchat.execute_callbacks('before_send_on_channel', msg.name, msg) then
		send_on_local_channel(msg)
	end
end

beerchat.send_on_channel = function(msg, ...)
	-- FIXME: Backwards compatibility hack. Remove once everything uses table for message handling.
	if type(msg) ~= "table" then
		local arg = {...}
		msg = {name=msg, channel=arg[1], message=arg[2]}
	end
	-- Execute registered event handlers, abort if told to do so
	if beerchat.execute_callbacks('before_send_on_channel', msg.name, msg) then
		-- Log and deliver message to both local and remote platforms
		beerchat.on_channel_message(msg.channel, msg.name, msg.message)
		send_on_local_channel(msg)
	end
end
