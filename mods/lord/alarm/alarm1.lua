ALARM = false

minetest.register_on_prejoinplayer(function(name, ip)
	if ALARM and not minetest.player_exists(name) then
		minetest.log("action", "Alarm: new player "..name.." from "..ip.."not created")
		return "network connection error"
	end
end)

minetest.register_chatcommand("alarm", {
	privs = {ban = true},
	func = function(name, param)
		ALARM = not ALARM
		minetest.log("action", "Alarm is "..tostring(ALARM))
	end,
})
