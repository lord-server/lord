
local WebClan = {
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
function WebClan.init(storage, logger)
	WebClan.storage = storage
	WebClan.logger  = logger
end


--- @static
--- @param clan clans.Clan
function WebClan.create(clan)
	local leader_id = WebClan.storage.get_player_web_id(clan.leader);
	if not leader_id then
		WebClan.logger.error("Can't create web-clan '%s': failed to get leader '%s' web id", clan.name, clan.leader)
		return
	end

	web_api.clans:create(
		{
			name      = clan.name,
			title     = clan.title,
			leader_id = leader_id
		},

		function(result)
			local created_clan = minetest.parse_json(result.data)
			if created_clan == nil then
				return WebClan.logger.error("Can't store clan web id: unable to parse response json: " .. result.data)
			end

			WebClan.storage.set_clan_web_id(clan.name, created_clan.id)
		end,

		function(result)
			if result.code == 409 then
				local response = minetest.parse_json(result.data)
				if response and response.field == "name" and response.entry then
					WebClan.storage.set_clan_web_id(clan.name, response.entry.id)
				end
			end

			WebClan.logger.log_api_error(result)
		end
	)
end

--- @static
--- @param clan clans.Clan
function WebClan.delete(clan)
	local clan_web_id = WebClan.storage.get_clan_web_id(clan.name)
	if not clan_web_id then
		return WebClan.logger.error("Can't delete web-clan '%s': failed to get clan web id", clan.name)
	end

	web_api.clans:delete(clan_web_id, nil, WebClan.logger.log_api_error)
end

--- @static
--- @param clan        clans.Clan
--- @param player_name string
function WebClan.player_add(clan, player_name)
	local clan_web_id   = WebClan.storage.get_clan_web_id(clan.name)
	local player_web_id = WebClan.storage.get_player_web_id(player_name)

	if not clan_web_id or not player_web_id then
		return WebClan.logger.error("Can't add player '%s' into clan '%s': failed get web id(s)", player_name, clan.name)
	end

	web_api.clans:players(clan_web_id):add(player_web_id, nil, WebClan.logger.log_api_error)
end

--- @static
--- @param clan        clans.Clan
--- @param player_name string
function WebClan.player_del(clan, player_name)
	local clan_web_id   = WebClan.storage.get_clan_web_id(clan.name)
	local player_web_id = WebClan.storage.get_player_web_id(player_name)

	if not clan_web_id or not player_web_id then
		return WebClan.logger.error("Can't delete player '%s' from clan '%s': failed get web id(s)", player_name, clan.name)
	end

	web_api.clans:players(clan_web_id):delete(player_web_id, nil, WebClan.logger.log_api_error)
end

--- @static
--- @param clan        clans.Clan
--- @param player_name string
function WebClan.is_online(clan, player_name)
	local clan_web_id = WebClan.storage.get_clan_web_id(clan.name)

	if not clan_web_id then
		return WebClan.logger.error("Can't set clan '%s' is online: failed get web id", clan.name)
	end

	web_api.clans:is_online(clan_web_id, true, nil, WebClan.logger.log_api_error)
end

--- @static
--- @param clan        clans.Clan
--- @param player_name string
function WebClan.set_is_online(clan, player_name)
	local clan_web_id = WebClan.storage.get_clan_web_id(clan.name)

	if not clan_web_id then
		return WebClan.logger.error("Can't set clan '%s' is {on/off}line: failed get web id", clan.name)
	end

	local is_online = clans.clan_is_online(clan) or false
	web_api.clans:is_online(clan_web_id, is_online, nil, WebClan.logger.log_api_error)
end

--- @static
--- @param clan clans.Clan
function WebClan.set_blocked(clan)
	local clan_web_id = WebClan.storage.get_clan_web_id(clan.name)

	if not clan_web_id then
		return WebClan.logger.error("Can't set clan '%s' blocked: failed get web id", clan.name)
	end

	web_api.clans:is_blocked(clan_web_id, true, nil, WebClan.logger.log_api_error)
end

--- @static
--- @param clan clans.Clan
function WebClan.set_unblocked(clan)
	local clan_web_id = WebClan.storage.get_clan_web_id(clan.name)

	if not clan_web_id then
		return WebClan.logger.error("Can't set clan '%s' unblocked: failed get web id", clan.name)
	end

	web_api.clans:is_blocked(clan_web_id, false, nil, WebClan.logger.log_api_error)
end


return WebClan
