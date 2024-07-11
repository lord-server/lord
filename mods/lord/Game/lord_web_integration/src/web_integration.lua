local Storage      = require("web_integration.Storage")
local Logger       = require("web_integration.Logger")
local WebPlayer    = require("web_integration.WebPlayer")
local WebClan      = require("web_integration.WebClan")
local sync_command = require("web_integration.sync_command")


WebPlayer.init(Storage, Logger)
WebClan.init(Storage, Logger)


local register_for_players = function()
	minetest.register_on_joinplayer(function(player, last_login)
		if not player:is_player() then return end

		if not last_login then -- player is new
			WebPlayer.create(player)
		else -- player Not new
			WebPlayer.update_or_create(player)
		end
	end)

	minetest.register_on_leaveplayer(function(player, _)
		WebPlayer.offline(player)
	end)

end

local register_for_clans = function()
	clans.on_clan_created(WebClan.create)
	clans.on_clan_deleted(WebClan.delete)
	clans.on_clan_player_added(WebClan.player_add)
	clans.on_clan_player_removed(WebClan.player_del)
	clans.on_clan_player_join(WebClan.is_online)
	clans.on_clan_player_leave(WebClan.set_is_online)
	clans.on_clan_blocked(WebClan.set_blocked)
	clans.on_clan_unblocked(WebClan.set_unblocked)
end


return {
	init = function()
		if not rawget(_G, "web_api") then
			minetest.log(
				"warning",
				"Can't initialize `lord_web_integration`: Global variable `web_api` not found: \
					mod `lord_wed_api` not loaded or not initialized.")
			return
		end

		register_for_players()
		register_for_clans()

		sync_command.register(Storage, Logger)
	end,
}
