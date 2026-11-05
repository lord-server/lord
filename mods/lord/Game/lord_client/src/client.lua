local Info        = require('client.Info')
local Version     = require('client.Version')
local Requirement = require('client.version.Requirement')

local S = core.get_mod_translator()


--- Delay before logging: client sends window information some time after join.
local LOG_DELAY = 2

--- @type helpers.Logger
local logger

--- Disconnects the player with explanation, that his client is outdated.
--- @param player_name string
--- @param version     client.Version
--- @param lang_code   string
local function disconnect_outdated(player_name, version, lang_code)
	logger.action(
		'%s disconnected: client %s (protocol %d) is older than required %s (protocol %d)',
		player_name, version:string(), version:protocol(), Requirement.min, Requirement.min_protocol
	)
	core.disconnect_player(player_name, core.get_translated_string(lang_code, S(
		'Your Luanti client @1 is outdated.\nThis server requires version @2 or newer.\nDownload: @3',
		version:number(), Requirement.min, Requirement.download_url
	)))
end

--- Disconnects the player, if his client is outdated.
--- @param player_name string
--- @param player_info PlayerInformation
--- @return boolean `true`, if the client version is fine; `false`, if the player was disconnected.
local function check_version(player_name, player_info)
	local version = Version:new(player_info)
	if not version:is_outdated() then
		return true
	end

	-- no window information for the disconnected player, so log right now
	Info.log(player_name, player_info, nil)
	disconnect_outdated(player_name, version, player_info.lang_code or '')

	return false
end


return {
	--- @param mod core.Mod
	init = function(mod)
		logger = mod.logger

		Info.init(mod.logger)
		Requirement.init(mod.settings, mod.logger)
		logger.action('Minimal client version: %s (protocol %d)', Requirement.min, Requirement.min_protocol)

		core.register_on_joinplayer(function(player)
			local player_name = player:get_player_name()
			local player_info = core.get_player_information(player_name) --[[@as PlayerInformation present in `on_joinplayer`]]
			if not check_version(player_name, player_info) then
				return
			end
			-- Delay before logging: client sends window information some time after join.
			core.after(LOG_DELAY, function()
				Info.log(player_name, player_info, core.get_player_window_information(player_name))
			end)
		end)
		core.register_on_cheat(Info.log_cheat)
	end,
}
