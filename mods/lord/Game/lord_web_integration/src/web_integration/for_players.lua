
local web_player = {
	--- @private
	--- @static
	--- @type web_integration.Storage
	storage = nil,
	--- @private
	--- @static
	--- @type web_integration.Logger
	logger  = nil,
}


--- @param player Player minetest player object
function web_player.create(player)
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
				web_player.logger.error("Can't store player web id: unable to parse response json: " .. result.data)
				return
			end

			web_player.storage.set_player_web_id(player_name, created_player.id)
		end,

		function(result)
			if result.code == 409 then
				local response = minetest.parse_json(result.data)
				if response and response.field == "name" and response.entry then
					web_player.storage.set_player_web_id(player_name, response.entry.id)
				end
			end
			web_player.logger.log_api_error(result)
		end
	)
end

--- @param player_web_id number ID of player in the Web DB.
function web_player.update(player_web_id, player_name)
	web_api.players:update(
		player_web_id,
		{
			last_login = os.date("%Y-%m-%d %H:%M:%S"),
			race       = races.get_race(player_name),
			gender     = races.get_gender(player_name),
			is_online  = 1,
		},
		nil,
		web_player.logger.log_api_error
	)
end

--- @param player     Player minetest player object
function web_player.update_or_create(player)
	local player_name = player:get_player_name()
	local player_web_id = web_player.storage.get_player_web_id(player_name)

	if not player_web_id then
		web_player.create(player)
	else
		web_player.update(player_web_id, player_name)
	end
end

--- @param player     Player minetest player object
function web_player.offline(player)
	local player_name = player:get_player_name()
	local player_web_id = web_player.storage.get_player_web_id(player_name)
	web_api.players:update(player_web_id, {
		is_online = 0,
	})
end



return {
	--- @param storage web_integration.Storage
	--- @param logger  web_integration.Logger
	register = function(storage, logger)
		web_player.storage = storage
		web_player.logger  = logger

		minetest.register_on_joinplayer(function(player, last_login)
			if not player:is_player() then return end

			if not last_login then -- player is new
				web_player.create(player)
			else -- player Not new
				web_player.update_or_create(player)
			end
		end)

		minetest.register_on_leaveplayer(function(player, _)
			web_player.offline(player)
		end)
	end
}
