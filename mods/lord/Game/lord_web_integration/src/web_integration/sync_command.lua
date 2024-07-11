--- @type web_integration.Storage
local Storage
--- @type web_integration.Player
local WebPlayer
--- @type web_integration.Clan
local WebClan

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

---@param clan clans.Clan
---@param notify_player_name string
local function create_clan_on_web(clan, notify_player_name)
	minetest.chat_send_player(notify_player_name, "Clan " .. clan.name .. ": send `::create()`")

	WebClan.create(
		clan,
		function(created_clan)
			minetest.chat_send_player(notify_player_name, clan.name .. ":web_id: " .. created_clan.id)
		end,
		function(linked_clan)
			minetest.chat_send_player(notify_player_name, clan.name .. ":linked web_id: " .. linked_clan.id)
		end,
		function(result)
			minetest.chat_send_player(notify_player_name, clan.name .. ":failed: " .. dump(result))
		end
	)
end

---@param players_names string[]
---@param executor_name string
---@param iteration number
local function sync_players(players_names, executor_name, iteration)
	for _, player_name in pairs(players_names) do
		local player_web_id = Storage.get_player_web_id(player_name)

		if not player_web_id then
			minetest.chat_send_player(executor_name, "Web Sync Player: " .. player_name)
			iteration = iteration + 1
			minetest.after(iteration, function()
				create_player_on_web(player_name, executor_name)
			end)
		else
			minetest.chat_send_player(
				executor_name,
				"Web Sync Player: " .. player_name .. " already synced: " .. player_web_id
			)
		end
	end

	return iteration
end

--- @param clan clans.Clan
--- @param executor_name string
--- @param iteration number
local function sync_clan(clan, executor_name, iteration)
	local clan_web_id = Storage.get_clan_web_id(clan.name)
	if not clan_web_id then
		iteration = iteration + 1
		minetest.after(iteration, function()
			create_clan_on_web(clan, executor_name)
		end)
	end
end


local function sync_clans_handler(executor_name)
	minetest.chat_send_player(executor_name, "Web Sync Clans Start")
	local iteration = 0
	for _, clan in pairs(clans.list()) do
		minetest.chat_send_player(executor_name, "Web Sync Clan: " .. clan.name)
		iteration = sync_players(clan.players, executor_name, iteration)
		iteration = sync_clan(clan, executor_name, iteration)
	end

	minetest.chat_send_player(executor_name, "Web Sync Clans Finish")
end



return {
	--- @param storage    web_integration.Storage
	--- @param web_player web_integration.Player
	--- @param web_clan   web_integration.Clan
	register = function(storage, web_player, web_clan)
		Storage, WebPlayer, WebClan = storage, web_player, web_clan
		minetest.register_chatcommand('web_sync_clans', {
			privs = { server = true },
			func  = sync_clans_handler
		})
	end
}
