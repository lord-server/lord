--- @type web_integration.Storage
local Storage
--- @type web_integration.Player
local WebPlayer
--- @type web_integration.Clan
--local WebClan

local function create_player_on_web(player_name, notify_player_name)
	minetest.chat_send_player(notify_player_name, player_name .. ": send `::create()`")
	WebPlayer.create(
		player_name,
		minetest.get_auth_handler().get_auth(player_name).last_login,
		nil,
		function(created_player)
			minetest.chat_send_player(notify_player_name, player_name .. ":web_id: " .. created_player.id)
		end,
		function(linked_player)
			minetest.chat_send_player(notify_player_name, player_name .. ":linked web_id: " .. linked_player.id)
		end,
		function(result)
			minetest.chat_send_player(notify_player_name, player_name .. ":failed: " .. dump(result))
		end
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
	--- @param storage    web_integration.Storage
	--- @param web_player web_integration.Player
	register = function(storage, web_player)
		Storage, WebPlayer = storage, web_player
		minetest.register_chatcommand('web_sync_clans', {
			privs = { server = true },
			func  = sync_clans_handler
		})
	end
}
