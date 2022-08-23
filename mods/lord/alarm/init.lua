local function registered_player(name) -- если игрок уже зарегистрирован, возвращает true
	local file = minetest.get_worldpath() .. "/players/" .. name
	return os.rename(file, file)
end

minetest.register_on_prejoinplayer(function(name, ip)
	local alarm_enabled = minetest.settings:get_bool("alarm", false)

	if alarm_enabled and not registered_player(name) then
		minetest.log("action", "Alarm: new player "..name.." from "..ip.." not created")
		return "network connection error"
	end
end)

local function get_status_str()
	local status = minetest.settings:get_bool("alarm", false)
	if status then
		return "Alarm is on"
	else
		return "Alarm is off"
	end
end

minetest.register_chatcommand("alarm", {
	params = "<status> | <on> | <off>",
	description = "Enable, disable, or show status of alarm",
	privs = {ban = true},
	func = function(name, param)
		if param == "on" or param == "off" then
			minetest.settings:set_bool("alarm", param == "on")
			local status = get_status_str()
			minetest.log("action", status)
			minetest.chat_send_player(name, status)
		else
			local status = get_status_str()
			minetest.chat_send_player(name, status)
		end
	end,
})

