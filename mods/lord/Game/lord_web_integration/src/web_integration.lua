local Storage     = require("web_integration.Storage")
local for_players = require("web_integration.for_players")
local for_clans   = require("web_integration.for_clans")



return {
	init = function()
		if not rawget(_G, "web_api") then
			minetest.log(
				"warning",
				"Can't initialize `lord_web_integration`: Global variable `web_api` not found: \
					mod `lord_wed_api` not loaded or not initialized.")
			return
		end

		for_players.register(Storage)
		for_clans.register(Storage)
	end,
}
