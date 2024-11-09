
-- Load all integrated beerchat extensions here

local MP = minetest.get_modpath("beerchat")
local function load_plugin(name, enable_default)
	if minetest.settings:get_bool("beerchat.enable_"..name, enable_default) then
		minetest.log("info", "Loading beerchat extension: " .. name)
		dofile(MP.."/plugin/"..name..".lua")
	else
		minetest.log("info", "Beerchat extension disabled: " .. name)
	end
end

-- Allows players to mute other players
load_plugin("mute", true)

-- Allows sending special formatted "/me message here" messages to channel
load_plugin("me", true)

-- Allows switching channels with "#channelname" and sending to channel with "#channelname message here"
load_plugin("hash", true)

-- Allows "@player message here" to send private messages to players
load_plugin("pm", true)

-- Allows "$ message here" to send message to nearby players
load_plugin("whisper", true)

-- Adds "/chat_jail playername" and "/chat_unjail playername" commands
load_plugin("jail", false)

-- Adds "/channel_ban [#channel] playername" and "/channel_unban [#channel] playername" commands
load_plugin("ban", false)

-- Allow muting remote users
load_plugin("remote_mute", false)

-- Removes control characters from incoming messages
load_plugin("cleaner", false)

-- Overrides for message handlers provided by other mods
load_plugin("override", true)

-- Allows colorizing messages on specified channels
load_plugin("colorize", true)

-- Set server wide announcements
load_plugin("announce", false)

-- Adds command "/force2channel channel,player"
load_plugin("force2channel", true)

-- Adds complaints for bad password (default or empty)
load_plugin("password", true)

-- Adds logging and info messages for certain events
load_plugin("event-logging", true)

-- Allows linking channels through channel aliases
load_plugin("alias", false)
