
local min = 60
local hour = min * 60
local day = hour * 24
local month = day * 30
---@type number @in seconds
local MAX_INACTIVE_PERIOD = month * 3

local function kick_inactive_players_from_clan()
	local auth_handler = core.get_auth_handler()
	local time_now = os.time()
	for clan_name, clan in pairs(clans.list()) do
		for _, player_name in ipairs(clan.players) do
			local auth = auth_handler.get_auth(player_name)
			if not auth then
				core.log("error", "[clans]: [auto-kick]: can't find player `" ..  player_name .. "`")
			else
				local last_login = auth.last_login
				if last_login ~= nil and time_now - last_login > MAX_INACTIVE_PERIOD then
					clans.clan_players_remove(clan_name, player_name)
					core.log(
						"info",
						string.format(
							"[clans]: [auto-kick]: removed %s player from %s clan for being offline since %d",
							player_name,
							clan_name,
							last_login
						)
					)
				end
			end
		end
	end
end

--- Calls given function every day since server start with core.after
---@param func fun()
local function call_every_day(func)
	func()
	core.after(day, call_every_day, func)
end


return {
	register = function()
		core.register_on_mods_loaded(function()
			-- HACK: waiting for auth system loading:
			core.after(60, call_every_day, kick_inactive_players_from_clan)
		end)
	end
}
