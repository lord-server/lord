local S = minetest.get_mod_translator()

minetest.register_chatcommand("mypos", {
	params = "<name>",
	description = S("Show your position for all or same player."),
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if not player then
			return false, S("Player not found!")
		end
		local mypos = player:get_pos()
		local message = string.format("x=%d, y=%d, z=%d", mypos.x,mypos.y,mypos.z)
		if param == "" then
			minetest.chat_send_all("<"..name.."> "..message)
		elseif minetest.get_player_by_name(param) then
			minetest.chat_send_player(param, message)
		else
			return false, S("Player for private message not found!")
		end
		return true, S("Done.")
	end,
})
