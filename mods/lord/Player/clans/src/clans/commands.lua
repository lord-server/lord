local S = minetest.get_translator("clans")

minetest.register_chatcommand("clans.list", {
	description = S("Lists all existing clans. Blocked clans are marked with gray color."),
	func = function(_, _)
		local clans_str = ""
		for _, clan in pairs(clans.list()) do
			local clan1_str = string.format("%s (%s)", clan.name, clan.title)
			if clan.is_blocked then
				clan1_str = clan1_str.." "..S("[Blocked]")
				clan1_str = minetest.colorize("silver", clan1_str)
			end
			clans_str = clans_str .. clan1_str
		end
		return true, S("List of clans:@n@1", clans_str)
	end
})

minetest.register_chatcommand("clans.show", {
	description = S("Shows given clan information."),
	func = function(_, param_str)
		local clan = clans.clan_get_by_name(param_str)
		if not clan then return false, S("Clan @1 does not exist.", param_str) end

		local msg = string.format("%s (%s)", clan.title, clan.name)
		if clan.is_blocked then
			msg = minetest.colorize("silver", msg.." "..S("[Blocked]"))
		end
		msg = msg .. ": "
		if #clan.players ~= 0 then
			msg = msg .. table.concat(clan.players, ", ")
		else
			msg = msg .. S("no players")
		end

		return true, msg
	end
})

minetest.register_chatcommand("clans.register", {
	params = S("<clan name> <clan title> [list of players separated by space]"),
	description = S("Register clan with given title and given players"),
	privs = { server = true, },
	func = function(_, param_str)
		local params = string.split(param_str, " ")

		local clan_name = params[1]
		local clan_title = params[2] -- TODO: handle clan title with spaces
		if not clan_name or not clan_title then
			return false, S("Didn't get enough arguments! See help.")
		end
		local members = {}
		for i, param in ipairs(params) do
			if i ~= 1 and i ~= 2 then table.insert(members, param) end
		end

		local is_executed, err = clans.clan_create(clan_name, clan_title, members)
		if is_executed then
			local members_str = table.concat(members, ", ")
			return true, S("Clan @1 is created successfully. Members: @2", clan_name, members_str)
		elseif err == clans.err[1] then
			return false, S("Clan @1 already exists.", clan_name)
		elseif err == clans.err[2] then
			return false, S("A player from given is already assigned to a clan. Can't create clan @1.", clan_name)
		elseif err == clans.err[5] then
			return false, S(
				"Too many players in clan (max is @1). Can't create clan @2.",
				clans.max_players_in_clan,
				clan_name
			)
		end
	end
})

minetest.register_chatcommand("clans.delete", {
	params = S("<clan name>"),
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

minetest.register_chatcommand("clans.players.add", {
	params = S("<clan name> <list of players separated by space>"),
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
				local is_executed, err = clans.clan_players_add(clan_name, param)
				if not is_executed then
					if err == clans.err[3] then
						return false, S("Clan @1 does not exist.", clan_name)
					elseif err == clans.err[2] then
						return false, S("A player from given is already assigned to a clan.")
					elseif err == clans.err[5] then
						return false, S(
							"Too many players in clan (max is @1). Can't add player(s).",
							clans.max_players_in_clan
						)
					elseif err == clans.err[6] then
						return false, S("Clan @1 is blocked!", clan_name)
					end
				end
			end
		end
		return true, S("Given player(s) is(are) added to clan @1.", clan_name)
	end
})

minetest.register_chatcommand("clans.players.remove", {
	params = S("<clan name> <player name>"),
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
	params = S("<clan name>"),
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
