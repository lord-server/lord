
local min = 60
local hour = min * 60
local day = hour * 24
local month = day * 30
---@type number @in seconds
local MAX_INACTIVE_PERIOD = month * 3

local function kick_inactive_players_from_clan()
	local auth_handler = minetest.get_auth_handler()
	local time_now = os.time()
	for clan_name, clan in pairs(clans.list()) do
		for _, player in ipairs(clan.players) do
			local last_login = auth_handler.get_auth(player).last_login
			if last_login ~= nil and time_now - last_login > MAX_INACTIVE_PERIOD then
				clans.clan_players_remove(clan_name, player)
				minetest.log(
					"info",
					string.format(
						"[clans] removed %s player from %s clan for being offline since %d",
						player,
						clan_name,
						last_login
					)
				)
			end
		end
	end
end

--- Calls given function every day since server start with minetest.after
---@param func fun()
local function call_every_day(func)
	func()
	minetest.after(day, call_every_day, func)
end


return {
	register = function()
		minetest.register_on_mods_loaded(function()
			-- HACK: waiting for auth system loading:
			minetest.after(30, call_every_day, kick_inactive_players_from_clan)
		end)
	end
}
