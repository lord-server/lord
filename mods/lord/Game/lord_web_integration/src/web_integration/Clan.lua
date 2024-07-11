--- @class web_integration.WebClan
--- @field id            number
--- @field name          string
--- @field title         string
--- @field about         string
--- @field description   string
--- @field leader_id     number
--- @field negotiator_id number
--- @field is_blocked    boolean
--- @field is_online     boolean
--- @field created_at    string   format: "YYYY-MM-DD hh:mm:ss" ("2024-07-10 16:59:11")
--- @field updated_at    string   format: "YYYY-MM-DD hh:mm:ss"
--- @field deleted_at    string   format: "YYYY-MM-DD hh:mm:ss"


--- @class web_integration.Clan
local Clan = {
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
function Clan.init(storage, logger)
	Clan.storage = storage
	Clan.logger  = logger
end


--- @static
--- @param clan clans.Clan
--- @param on_done fun(created_clan:web_integration.WebClan)
--- @param on_link fun(linked_clan:web_integration.WebClan)
--- @param on_fail fun(result:HTTPRequestResult)
function Clan.create(clan, on_done, on_link, on_fail)
	local leader_id = Clan.storage.get_player_web_id(clan.leader);
	if not leader_id then
		Clan.logger.error("Can't create web-clan '%s': failed to get leader '%s' web id", clan.name, clan.leader)
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
				return Clan.logger.error("Can't store clan web id: unable to parse response json: " .. result.data)
			end

			Clan.storage.set_clan_web_id(clan.name, created_clan.id)
			if on_done then on_done() end
		end,

		function(result)
			if result.code == 409 then
				local response = minetest.parse_json(result.data)
				if response and response.field == "name" and response.entry then
					Clan.storage.set_clan_web_id(clan.name, response.entry.id)
					if on_link then on_link(response.entry) end

					return
				end
			end

			Clan.logger.log_api_error(result)
			if on_fail then on_fail(result) end
		end
	)
end

--- @static
--- @param clan clans.Clan
function Clan.delete(clan)
	local clan_web_id = Clan.storage.get_clan_web_id(clan.name)
	if not clan_web_id then
		return Clan.logger.error("Can't delete web-clan '%s': failed to get clan web id", clan.name)
	end

	web_api.clans:delete(clan_web_id, nil, Clan.logger.log_api_error)
end

--- @static
--- @param clan        clans.Clan
--- @param player_name string
function Clan.player_add(clan, player_name)
	local clan_web_id   = Clan.storage.get_clan_web_id(clan.name)
	local player_web_id = Clan.storage.get_player_web_id(player_name)

	if not clan_web_id or not player_web_id then
		return Clan.logger.error("Can't add player '%s' into clan '%s': failed get web id(s)", player_name, clan.name)
	end

	web_api.clans:players(clan_web_id):add(player_web_id, nil, Clan.logger.log_api_error)
end

--- @static
--- @param clan        clans.Clan
--- @param player_name string
function Clan.player_del(clan, player_name)
	local clan_web_id   = Clan.storage.get_clan_web_id(clan.name)
	local player_web_id = Clan.storage.get_player_web_id(player_name)

	if not clan_web_id or not player_web_id then
		return Clan.logger.error("Can't delete player '%s' from clan '%s': failed get web id(s)", player_name, clan.name)
	end

	web_api.clans:players(clan_web_id):delete(player_web_id, nil, Clan.logger.log_api_error)
end

--- @static
--- @param clan        clans.Clan
--- @param player_name string
function Clan.is_online(clan, player_name)
	local clan_web_id = Clan.storage.get_clan_web_id(clan.name)

	if not clan_web_id then
		return Clan.logger.error("Can't set clan '%s' is online: failed get web id", clan.name)
	end

	web_api.clans:is_online(clan_web_id, true, nil, Clan.logger.log_api_error)
end

--- @static
--- @param clan        clans.Clan
--- @param player_name string
function Clan.set_is_online(clan, player_name)
	local clan_web_id = Clan.storage.get_clan_web_id(clan.name)

	if not clan_web_id then
		return Clan.logger.error("Can't set clan '%s' is {on/off}line: failed get web id", clan.name)
	end

	local is_online = clans.clan_is_online(clan) or false
	web_api.clans:is_online(clan_web_id, is_online, nil, Clan.logger.log_api_error)
end

--- @static
--- @param clan clans.Clan
function Clan.set_blocked(clan)
	local clan_web_id = Clan.storage.get_clan_web_id(clan.name)

	if not clan_web_id then
		return Clan.logger.error("Can't set clan '%s' blocked: failed get web id", clan.name)
	end

	web_api.clans:is_blocked(clan_web_id, true, nil, Clan.logger.log_api_error)
end

--- @static
--- @param clan clans.Clan
function Clan.set_unblocked(clan)
	local clan_web_id = Clan.storage.get_clan_web_id(clan.name)

	if not clan_web_id then
		return Clan.logger.error("Can't set clan '%s' unblocked: failed get web id", clan.name)
	end

	web_api.clans:is_blocked(clan_web_id, false, nil, Clan.logger.log_api_error)
end


return Clan
