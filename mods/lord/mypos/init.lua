local SL = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end

minetest.register_chatcommand("mypos", {
	params = "<name>",
	description = SL("Show your position for all or same player."),
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if not player then
			return false, SL("Player not found!")
		end
		local mypos = player:getpos()
		local message = string.format("x=%d, y=%d, z=%d", mypos.x,mypos.y,mypos.z)
		if param == "" then
			minetest.chat_send_all("<"..name.."> "..message)
		elseif minetest.get_player_by_name(param) then
			minetest.chat_send_player(param, message)
		else
			return false, SL("Player for private message not found!")
		end
		return true, SL("Done.")
	end,
})
