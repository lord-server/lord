
local WebPlayer = {
	--- @private
	--- @static
	--- @type web_integration.Storage
	storage = nil,
	--- @private
	--- @static
	--- @type web_integration.Logger
	logger  = nil,
}

--- @static
function WebPlayer.init(storage, logger)
	WebPlayer.storage = storage
	WebPlayer.logger  = logger
end


--- @static
--- @param player Player minetest player object
function WebPlayer.create(player)
	local player_name = player:get_player_name()

	web_api.players:create(
		{
			name      = player_name,
			race      = races.get_race(player_name),
			gender    = races.get_gender(player_name),
			is_online = 1,
		},

		function(result)
			local created_player = minetest.parse_json(result.data)
			if created_player == nil then
				WebPlayer.logger.error("Can't store player web id: unable to parse response json: " .. result.data)
				return
			end

			WebPlayer.storage.set_player_web_id(player_name, created_player.id)
		end,

		function(result)
			if result.code == 409 then
				local response = minetest.parse_json(result.data)
				if response and response.field == "name" and response.entry then
					WebPlayer.storage.set_player_web_id(player_name, response.entry.id)
				end
			end
			WebPlayer.logger.log_api_error(result)
		end
	)
end

--- @static
--- @param player_web_id number ID of player in the Web DB.
function WebPlayer.update(player_web_id, player_name)
	web_api.players:update(
		player_web_id,
		{
			last_login = os.date("%Y-%m-%d %H:%M:%S"),
			race       = races.get_race(player_name),
			gender     = races.get_gender(player_name),
			is_online  = 1,
		},
		nil,
		WebPlayer.logger.log_api_error
	)
end

--- @static
--- @param player Player minetest player object
function WebPlayer.update_or_create(player)
	local player_name = player:get_player_name()
	local player_web_id = WebPlayer.storage.get_player_web_id(player_name)

	if not player_web_id then
		WebPlayer.create(player)
	else
		WebPlayer.update(player_web_id, player_name)
	end
end

--- @static
--- @param player Player minetest player object
function WebPlayer.offline(player)
	local player_name = player:get_player_name()
	local player_web_id = WebPlayer.storage.get_player_web_id(player_name)
	web_api.players:update(player_web_id, {
		is_online = 0,
	})
end


return WebPlayer
