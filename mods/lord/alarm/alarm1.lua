ALARM = false

local function registered_player(name) -- если игрок уже зарегистрирован, возвращает true
	local file = minetest.get_worldpath() .. "/players/" .. name
	return os.rename(file, file)
end

minetest.register_on_prejoinplayer(function(name, ip)
	if ALARM and not registered_player(name) then
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
