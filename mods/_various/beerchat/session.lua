

minetest.register_on_joinplayer(function(player, last_login)

	local name = player:get_player_name()
	local meta = player:get_meta()

	local str = meta:get_string("beerchat:channels")
	if str and str ~= "" then
		beerchat.playersChannels[name] = minetest.parse_json(str) or {}
	else
		beerchat.playersChannels[name] = {}
		beerchat.playersChannels[name][beerchat.main_channel_name] = "joined"
		meta:set_string("beerchat:channels", minetest.write_json(beerchat.playersChannels[name]))
	end

	local current_channel = meta:get_string("beerchat:current_channel")
	if current_channel and current_channel ~= "" then
		beerchat.currentPlayerChannel[name] = current_channel
	else
		beerchat.currentPlayerChannel[name] = beerchat.main_channel_name
	end

	beerchat.execute_callbacks("after_joinplayer", player, last_login)

end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	beerchat.playersChannels[name] = nil
	beerchat.currentPlayerChannel[name] = nil
end)
