
local main_channel_owner = "Beerholder"		-- The owner of the main channel, usually ADMIN
local main_channel_color = "#ffffff"		-- The color in hex of the main channel


if beerchat.mod_storage:get_string("channels") == "" then
	minetest.log("action", "[beerchat] One off initializing mod storage")
	beerchat.channels[beerchat.main_channel_name] = {
		owner = main_channel_owner,
		color = main_channel_color
	}
	beerchat.mod_storage:set_string("channels", minetest.write_json(beerchat.channels))
end

beerchat.channels = minetest.parse_json(beerchat.mod_storage:get_string("channels")) or {}
beerchat.channels[beerchat.main_channel_name] = {
	owner = main_channel_owner,
	color = main_channel_color
}
