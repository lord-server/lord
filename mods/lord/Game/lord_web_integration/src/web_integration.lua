local Storage     = require("web_integration.Storage")
local Logger      = require("web_integration.Logger")
local for_players = require("web_integration.for_players")
local for_clans   = require("web_integration.for_clans")

local function create_player_on_web(player_name, notify_player_name)
	minetest.chat_send_player(notify_player_name, player_name .. ": send `::create()`")
	web_api.players:create(
		{
			name       = player_name,
			race       = races.get_race(player_name),
			gender     = races.get_gender(player_name),
			last_login = minetest.get_auth_handler().get_auth(player_name).last_login
		},

		function(result)
			local created_player = minetest.parse_json(result.data)
			if created_player == nil then
				Logger.error("Can't store player web id: unable to parse response json: " .. result.data)
				return
			end

			Storage.set_player_web_id(player_name, created_player.id)
			minetest.chat_send_player(notify_player_name, player_name .. ":web_id: " .. created_player.id)
		end,

		Logger.log_api_error
	)
end

local function register_tmp_command_for_integrate_clan_players()
	minetest.register_chatcommand('web_send_clan_players', {
		privs = { server = true },
		func  = function(executor_name)
			local seconds = 0
			for _, clan in pairs(clans.list()) do
				for _, player_name in pairs(clan.players) do
					local player_web_id = Storage.get_player_web_id(player_name)
					if not player_web_id then
						seconds = seconds + 1
						minetest.after(seconds, function()
							create_player_on_web(player_name, executor_name)
						end)
					end
				end
			end
		end
	})
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

		for_players.register(Storage, Logger)
		for_clans.register(Storage, Logger)

		register_tmp_command_for_integrate_clan_players()
	end,
}
