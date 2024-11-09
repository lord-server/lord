
local http = ...

-- normal message in chat channel
beerchat.on_channel_message = function(channel, playername, message, event)
	http.fetch({
		url = beerchat.url .. "/api/message",
		method = "POST",
		extra_headers = {
			"Content-Type: application/json",
			"Authorization: Bearer " .. beerchat.token
		},
		timeout = 5,
		data = minetest.write_json({
			gateway = channel,
			username = playername,
			text = message,
			event = event
		})
	}, function()
		-- ignore errors
	end)

end

-- /me message in chat channel
beerchat.on_me_message = function(channel, playername, message)
	beerchat.on_channel_message(channel, playername, message, "user_action")
end

-- map to players -> new == true
local new_player_map = {}

-- check on prejoin if the player is new
minetest.register_on_prejoinplayer(function(name)
	if not minetest.player_exists(name) then
		new_player_map[name] = true
	end
end)

-- join player message
minetest.register_on_joinplayer(function(player)
	local playername = player:get_player_name()

	local msg = "❱ Joined the game"
	if new_player_map[playername] then
		msg = msg .. " (new player)"
		-- clear new-player flag
		new_player_map[playername] = nil
	end

	beerchat.on_channel_message(beerchat.main_channel_name, playername, msg)
end)

-- leave player message
minetest.register_on_leaveplayer(function(player, timed_out)
	local msg = "❰ Left the game"
	if timed_out then
		msg = msg .. " (timed out)"
	end

	beerchat.on_channel_message(beerchat.main_channel_name, player:get_player_name(), msg)
end)

-- initial message on start
beerchat.on_channel_message(beerchat.main_channel_name, "SYSTEM", "✔ Minetest started!")

minetest.register_on_shutdown(function()
	beerchat.on_channel_message(beerchat.main_channel_name, "SYSTEM", "✖ Minetest shutting down!")
end)
