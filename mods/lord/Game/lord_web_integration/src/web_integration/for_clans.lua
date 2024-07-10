
local web_clan = {
	--- @private
	--- @static
	--- @type web_integration.Storage
	storage = nil,
	--- @private
	--- @static
	--- @type web_integration.Logger
	logger  = nil,
}

--- @param clan clans.Clan
function web_clan.create(clan)
	local leader_id = web_clan.storage.get_player_web_id(clan.leader);
	if not leader_id then
		web_clan.logger.error("Can't create web-clan '%s': failed to get leader '%s' web id", clan.name, clan.leader)
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
				return web_clan.logger.error("Can't store clan web id: unable to parse response json: " .. result.data)
			end

			web_clan.storage.set_clan_web_id(clan.name, created_clan.id)
		end,

		function(result)
			if result.code == 409 then
				local response = minetest.parse_json(result.data)
				if response and response.field == "name" and response.entry then
					web_clan.storage.set_clan_web_id(clan.name, response.entry.id)
				end
			end

			web_clan.logger.log_api_error(result)
		end
	)
end

--- @param clan clans.Clan
function web_clan.delete(clan)
	local clan_web_id = web_clan.storage.get_clan_web_id(clan.name)
	if not clan_web_id then
		return web_clan.logger.error("Can't delete web-clan '%s': failed to get clan web id", clan.name)
	end

	web_api.clans:delete(clan_web_id, nil, web_clan.logger.log_api_error)
end

--- @param clan        clans.Clan
--- @param player_name string
function web_clan.player_add(clan, player_name)
	local clan_web_id   = web_clan.storage.get_clan_web_id(clan.name)
	local player_web_id = web_clan.storage.get_player_web_id(player_name)

	if not clan_web_id or not player_web_id then
		return web_clan.logger.error("Can't add player '%s' into clan '%s': failed get web id(s)", player_name, clan.name)
	end

	web_api.clans:players(clan_web_id):add(player_web_id, nil, web_clan.logger.log_api_error)
end

--- @param clan        clans.Clan
--- @param player_name string
function web_clan.player_del(clan, player_name)
	local clan_web_id   = web_clan.storage.get_clan_web_id(clan.name)
	local player_web_id = web_clan.storage.get_player_web_id(player_name)

	if not clan_web_id or not player_web_id then
		return web_clan.logger.error("Can't delete player '%s' from clan '%s': failed get web id(s)", player_name, clan.name)
	end

	web_api.clans:players(clan_web_id):delete(player_web_id, nil, web_clan.logger.log_api_error)
end

--- @param clan        clans.Clan
--- @param player_name string
function web_clan.is_online(clan, player_name)
	local clan_web_id = web_clan.storage.get_clan_web_id(clan.name)

	if not clan_web_id then
		return web_clan.logger.error("Can't set clan '%s' is online: failed get web id", clan.name)
	end

	web_api.clans:is_online(clan_web_id, true, nil, web_clan.logger.log_api_error)
end

--- @param clan        clans.Clan
--- @param player_name string
function web_clan.set_is_online(clan, player_name)
	local clan_web_id = web_clan.storage.get_clan_web_id(clan.name)

	if not clan_web_id then
		return web_clan.logger.error("Can't set clan '%s' is {on/off}line: failed get web id", clan.name)
	end

	local is_online = clans.clan_is_online(clan) or false
	web_api.clans:is_online(clan_web_id, is_online, nil, web_clan.logger.log_api_error)
end

--- @param clan clans.Clan
function web_clan.set_blocked(clan)
	local clan_web_id = web_clan.storage.get_clan_web_id(clan.name)

	if not clan_web_id then
		return web_clan.logger.error("Can't set clan '%s' blocked: failed get web id", clan.name)
	end

	web_api.clans:is_blocked(clan_web_id, true, nil, web_clan.logger.log_api_error)
end

--- @param clan clans.Clan
function web_clan.set_unblocked(clan)
	local clan_web_id = web_clan.storage.get_clan_web_id(clan.name)

	if not clan_web_id then
		return web_clan.logger.error("Can't set clan '%s' unblocked: failed get web id", clan.name)
	end

	web_api.clans:is_blocked(clan_web_id, false, nil, web_clan.logger.log_api_error)
end


return {
	--- @param storage web_integration.Storage
	--- @param logger  web_integration.Logger
	register = function(storage, logger)
		web_clan.storage = storage
		web_clan.logger  = logger

		clans.on_clan_created(web_clan.create)
		clans.on_clan_deleted(web_clan.delete)
		clans.on_clan_player_added(web_clan.player_add)
		clans.on_clan_player_removed(web_clan.player_del)
		clans.on_clan_player_join(web_clan.is_online)
		clans.on_clan_player_leave(web_clan.set_is_online)
		clans.on_clan_blocked(web_clan.set_blocked)
		clans.on_clan_unblocked(web_clan.set_unblocked)
	end
}
