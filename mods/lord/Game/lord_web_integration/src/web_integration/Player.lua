--- @class web_integration.WebPlayer
--- @field id         number
--- @field name       string
--- @field race       string   one of "shadow", "human", "elf", "hobbit", "dwarf", "orc"
--- @field gender     string   one of "male", "female"
--- @field experience number
--- @field is_online  boolean
--- @field last_login string   format: "YYYY-MM-DD hh:mm:ss" ("2024-07-10 16:59:11")
--- @field clan_id    number
--- @field created_at string   format: "YYYY-MM-DD hh:mm:ss" ("2024-07-10 16:59:11")
--- @field updated_at string   format: "YYYY-MM-DD hh:mm:ss" ("2024-07-10 16:59:11")

--- @class web_integration.Player
local Player = {
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
function Player.init(storage, logger)
	Player.storage = storage
	Player.logger  = logger
end


--- @static
--- @param player_name string
--- @param last_login  number|nil  timestamp or nil for use "now()"
--- @param is_online   boolean|nil if nil, does not passed to web
--- @param on_done     fun(created_player:web_integration.WebPlayer)
--- @param on_link     fun(linked_player:web_integration.WebPlayer)
--- @param on_fail     fun(result:HTTPRequestResult)
function Player.create(player_name, last_login, is_online, on_done, on_link, on_fail)
	--- @type web_integration.WebPlayer
	local web_player  = {
		name       = player_name,
		race       = races.get_race(player_name),
		gender     = races.get_gender(player_name),
		last_login = os.date("%Y-%m-%d %H:%M:%S", last_login)
	}
	if is_online ~= nil then
		web_player.is_online = is_online and 1 or 0
	end

	web_api.players:create(
		web_player,

		function(result)
			local created_player = minetest.parse_json(result.data)
			if created_player == nil then
				Player.logger.error("Can't store player web id: unable to parse response json: " .. result.data)
				return
			end

			Player.storage.set_player_web_id(player_name, created_player.id)
			if on_done then on_done(created_player) end
		end,

		function(result)
			if result.code == 409 then
				local existing_player = minetest.parse_json(result.data)
				if existing_player then
					Player.storage.set_player_web_id(player_name, existing_player.id)
					if on_link then on_link(existing_player) end

					return
				end
			end

			Player.logger.log_api_error(result)
			if on_fail then on_fail(result) end
		end
	)
end

--- @static
--- @param player_web_id number ID of player in the Web DB.
--- @param player_name   string
--- @param last_login    number|nil  timestamp or nil for use "now()"
--- @param is_online     boolean|nil if nil, does not passed to web
function Player.update(player_web_id, player_name, last_login, is_online)
	--- @type web_integration.WebPlayer
	local web_player  = {
		race       = races.get_race(player_name),
		gender     = races.get_gender(player_name),
		last_login = os.date("%Y-%m-%d %H:%M:%S", last_login)
	}
	if is_online ~= nil then
		web_player.is_online = is_online and 1 or 0
	end

	web_api.players:update(
		player_web_id,
		web_player,
		nil,
		Player.logger.log_api_error
	)
end

--- @static
--- @param player_name Player minetest player object
--- @param last_login  number|nil  timestamp or nil for use "now()"
--- @param is_online   boolean|nil if nil, does not passed to web
function Player.update_or_create(player_name, last_login, is_online)
	local player_web_id = Player.storage.get_player_web_id(player_name)

	if not player_web_id then
		Player.create(player_name, last_login, is_online)
	else
		Player.update(player_web_id, player_name, last_login, is_online)
	end
end

--- @static
--- @param player Player minetest player object
function Player.offline(player)
	local player_name = player:get_player_name()
	local player_web_id = Player.storage.get_player_web_id(player_name)
	web_api.players:update(player_web_id, {
		is_online = 0,
	})
end


return Player
