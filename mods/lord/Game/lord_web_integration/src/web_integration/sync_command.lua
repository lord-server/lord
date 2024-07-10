local Storage
local Logger

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

local function sync_clans_handler(executor_name)
	local seconds = 0
	minetest.chat_send_player(executor_name, "Web Sync Clans Start")
	for _, clan in pairs(clans.list()) do
		minetest.chat_send_player(executor_name, "Web Sync Clan: " .. clan.name)
		for _, player_name in pairs(clan.players) do
			local player_web_id = Storage.get_player_web_id(player_name)
			if not player_web_id then
				minetest.chat_send_player(executor_name, "Web Sync Player: " .. player_name)
				seconds = seconds + 1
				minetest.after(seconds, function()
					create_player_on_web(player_name, executor_name)
				end)
			else
				minetest.chat_send_player(
					executor_name,
					"Web Sync Player: " .. player_name .. " already synced: " .. player_web_id
				)
			end
		end
	end
	minetest.chat_send_player(executor_name, "Web Sync Clans Finish")
end



return {
	register = function(storage, logger)
		Storage, Logger = storage, logger
		minetest.register_chatcommand('web_sync_clans', {
			privs = { server = true },
			func  = sync_clans_handler
		})
	end
}
