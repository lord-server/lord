local S = minetest.get_mod_translator()

local colorize = minetest.colorize

--- Formats clan info in beautiful colored string! :3
---@param clan clans.Clan
---@return string
local function get_beautiful_clan_str(clan)
	local title_str = colorize(clans.COLOR, clan.title)
	local id_str = colorize("grey", clan.name)
	local status_str = colorize("green", "online")
	if not clans.clan_is_online(clan.name) then
		status_str = "offline"
		if clan.is_blocked then
			status_str = "blocked"
		end
		status_str = colorize("red", status_str)
	end
	return string.format("%s (%s) — %s", title_str, id_str, status_str)
end

minetest.register_chatcommand("clans.list", {
	description = S("Lists all existing clans. Blocked clans are marked with gray color."),
	func = function(_, _)
		local msg = S("List of clans in format '<clan title> (<clan name>) — <status>':") .. "\n"
		for _, clan in pairs(clans.list()) do
			msg = msg .. "- "..get_beautiful_clan_str(clan).."\n"
		end
		return true, "\n"..msg.."\n"
	end
})

---@param player_name string
---@return boolean
local function is_player_online(player_name)
	for _, p in ipairs(minetest.get_connected_players()) do
		if p:get_player_name() == player_name then
			return true
		end
	end
	return false
end

local auth_handler = minetest.get_auth_handler()
--- Returns beautiful and nice string with given player info! :3
---@param player_name string
---@return string|nil
local function get_beautiful_player_str(player_name)
	local race = races.list[character.of(minetest.get_player_by_name(player_name)):get_race()]
	local race_name = colorize("chocolate", race.name)
	local last_status = colorize("green", "online")
	if not is_player_online(player_name) then
		local auth = auth_handler.get_auth(player_name)
		if not auth then
			minetest.log("error", "[clans] can't get player auth for "..player_name)
			return nil
		end
		local seen = os.date("(%H:%M %d.%m.%y)", auth.last_login) -- "(18:49 12.06.24)"
		last_status = colorize("red", "offline ") .. colorize("grey", seen)
	end
	return string.format("%s (%s) — %s", player_name, race_name, last_status)
end

minetest.register_chatcommand("clans.show", {
	params = S("<clan ID>"),
	description = S("Shows given clan information."),
	func = function(_, param_str)
		local clan = clans.clan_get_by_name(param_str)
		if not clan then return false, S("Clan @1 does not exist.", param_str) end

		local msg = S("Clan") .. " " .. get_beautiful_clan_str(clan) .. ":\n"
		if #clan.players < 1 then
			msg = msg .. S("no players")
		else
			for _, player_name in ipairs(clan.players) do
				local player_str = get_beautiful_player_str(player_name)
				if player_str then
					msg = msg .. "- "..player_str.."\n"
				end
			end
		end
		return true, "\n" .. msg .. "\n"
	end
})

minetest.register_chatcommand("clans.register", {
	params = S("<leader name> <clan ID> <clan title>"),
	description = S("Register clan with given leader, name and title"),
	privs = { server = true, },
	func = function(_, param_str)
		local clan_leader, clan_name, clan_title = param_str:match('^(%S+)%s(%S+)%s(.+)$')

		if not clan_leader or not clan_name or not clan_title then
			return false, S("Didn't get enough arguments! See help.")
		end

		local is_executed, err = clans.clan_create(clan_name, clan_title, clan_leader)
		if is_executed then
			return true, S(
				"Clan '@1' successfully created. Leader: @2",
				colorize(clans.COLOR, clan_name),
				colorize(clans.COLOR, clan_leader)
			)
		elseif err == clans.err[1] then
			return false, S("Clan '@1' already exists.", colorize(clans.COLOR, clan_name))
		elseif err == clans.err[2] then
			return false, S(
				"Can't create clan '@1': The given leader player '@2' already assigned to another clan.",
				colorize(clans.COLOR, clan_name),
				colorize(clans.COLOR, clan_leader)
			)
		elseif err == clans.err[7] then
			return false, S("Player with name '@1' does not exists.", colorize(clans.COLOR, clan_leader))
		end
	end
})

minetest.register_chatcommand("clans.delete", {
	params = S("<clan ID>"),
	description = S("Delete clan with given name"),
	privs = { server = true, },
	func = function(_, param_str)
		local name = param_str
		if not name or name == "" then
			return false, S("Didn't get enough arguments! See help.")
		end

		local is_executed, err = clans.clan_remove(name)
		if is_executed then
			return true, S("Clan @1 deleted successfully.", name)
		elseif err == clans.err[3] then
			return false, S("Clan @1 does not exist.", name)
		end
	end
})


--- Gets localized string for given clans.err from /clans.players.add command
---@param err string @clans.err[some_num]
---@param clan_name string
---@return string @localized str for error
local function err2str(err, clan_name)
	local enum = {
		[2] = S("A player from given is already assigned to a clan."),
		[3] = S("Clan @1 does not exist.", clan_name),
		[5] = S("Too many players in clan (max is @1). Can't add player(s).", clans.max_players_in_clan),
		[6] = S("Clan @1 is blocked!", clan_name),
		[7] = S("A player from given does not exist."),
	}
	local idx = table.indexof(clans.err, err)
	return enum[idx]
end

minetest.register_chatcommand("clans.players.add", {
	params = S("<clan ID> <list of players separated by space>"),
	description = S("Add given players to given clan"),
	privs = { server = true, },
	func = function(_, param_str)
		local params = string.split(param_str, " ")

		local clan_name = params[1]
		if not clan_name or not params[2] then
			return false, S("Didn't get enough arguments! See help.")
		end

		for i, param in ipairs(params) do
			if i ~= 1 then
				local _, err = clans.clan_players_add(clan_name, param)
				if err then
					return false, err2str(err, clan_name)
				end
			end
		end
		return true, S("Given player(s) is(are) added to clan @1.", clan_name)
	end
})

minetest.register_chatcommand("clans.players.remove", {
	params = S("<clan ID> <player name>"),
	description = S("Removes given player from given clan."),
	privs = { server = true, },
	func = function(_, param_str)
		local params = string.split(param_str, " ")

		local clan_name = params[1]
		local player_name = params[2]
		if not clan_name or not player_name then
			return false, S("Didn't get enough arguments! See help.")
		end

		local is_executed, err = clans.clan_players_remove(clan_name, player_name)
		if is_executed then
			return true, S("Player @1 was removed from clan @2.", player_name, clan_name)
		elseif err == clans.err[4] then
			return false, S("Player @1 does not member of the @2 clan.", player_name, clan_name)
		elseif err == clans.err[3] then
			return false, S("Clan @1 does not exist.", clan_name)
		end
	end
})

minetest.register_chatcommand("clans.toggle_block", {
	params = S("<clan ID>"),
	description = S("Toggles clan block."),
	privs = { server = true, },
	func = function(_, param_str)
		local name = param_str
		if not name or name == "" then
			return false, S("Didn't get enough arguments! See help.")
		end

		local result = clans.clan_toggle_block(name)
		if result == nil then return false, S("Clan @1 does not exist.", name) end
		if result then
			return true, S("Clan @1 blocked successfully.", name)
		else
			return true, S("Clan @1 unblocked successfully.", name)
		end
	end
})
