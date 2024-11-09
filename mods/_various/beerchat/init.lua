
--
-- Mod settings -- Change these to your liking


local http = QoS and QoS(minetest.request_http_api(), 1) or minetest.request_http_api()

beerchat = {
	-- The main channel is the one you send messages to when no channel is specified
	main_channel_name = minetest.settings:get("beerchat.main_channel_name") or "main",

	-- Chat administrator privilege allows bypassing owner checks
	admin_priv = minetest.settings:get("beerchat.admin_priv") or "server",

	-- The default color of channels when no color is specified
	default_channel_color = "#ffffff",

	-- Global flag to enable/ disable sounds
	enable_sounds = true,

	-- how loud the sounds should be by default (0.0 = low, 1.0 = max)
	sounds_default_gain = 0.3,

	-- General sound when managing channels like /cc, /dc etc
	channel_management_sound = "beerchat_chirp",

	-- Sound when a message is sent to a channel
	channel_message_sound = "beerchat_chime",

	main_channel_message_string = "|#${channel_name}| <${from_player}> ${message}",

	moderator_channel_name = minetest.settings:get("beerchat.moderator_channel_name"),

	mod_storage = minetest.get_mod_storage(),

	channels = {},
	playersChannels = {},
	currentPlayerChannel = {},

	-- web settings
	url = minetest.settings:get("beerchat.matterbridge_url") or "http://127.0.0.1:4242",
	token = minetest.settings:get("beerchat.matterbridge_token")
}

local MP = minetest.get_modpath("beerchat")
dofile(MP.."/router.lua")

dofile(MP.."/common.lua")
dofile(MP.."/format_message.lua")
dofile(MP.."/hooks.lua")
dofile(MP.."/storage.lua")
dofile(MP.."/session.lua")
dofile(MP.."/message.lua")
dofile(MP.."/chatcommands.lua")

if http and beerchat.token then
	-- load web stuff
	print("[beerchat] connecting to proxy-endpoint at: " .. beerchat.url)

	dofile(MP.."/web/command.lua")
	dofile(MP.."/web/register.lua")
	dofile(MP.."/web/audit.lua")
	loadfile(MP.."/web/tx.lua")(http)
	loadfile(MP.."/web/rx.lua")(http)
end

-- Load beerchat extensions
dofile(MP.."/plugin/init.lua")
