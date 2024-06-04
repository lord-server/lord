
local web_player = {
	--- @private
	--- @static
	--- @type web_integration.Storage
	storage = nil
}

--- @type http.Client.callback
local log_response_error = function(result)
	minetest.log("error", dump(result))
end


--- @param player Player minetest player object
function web_player.create(player)
	local player_name = player:get_player_name()

	web_api.players:create(
		{
			name = player_name,
			race = races.get_race(player_name),
		},

		function(result)
			local created_player = minetest.parse_json(result.data)
			if created_player == nil then
				minetest.log("error", "Can't store player web id: unable to parse response json.")
			end

			web_player.storage.set_player_web_id(player_name, created_player.id)
		end,

		log_response_error
	)
end

--- @param player_web_id number ID of player in the Web DB.
--- @param last_login    number unix timestamp of the previous player login
function web_player.update(player_web_id, last_login)
	web_api.players:update(
		player_web_id,
		{ last_login = os.date("%Y-%m-%d %H:%M:%S", last_login) },
		nil,
		log_response_error
	)
end

--- @param player     Player minetest player object
--- @param last_login number unix timestamp of the previous player login
function web_player.update_or_create(player, last_login)
	local player_name = player:get_player_name()
	local player_web_id = web_player.storage.get_player_web_id(player_name)

	if not player_web_id then
		web_player.create(player)
	else
		web_player.update(player_web_id, last_login)
	end
end



return {
	--- @param storage web_integration.Storage
	register = function(storage)
		web_player.storage = storage

		minetest.register_on_joinplayer(function(player, last_login)
			if not player:is_player() then return end

			if not last_login then -- player is new
				web_player.create(player)
			else -- player Not new
				web_player.update_or_create(player, last_login)
			end
		end)
	end
}
