local S = minetest.get_translator("clans")

local colorize = minetest.colorize

minetest.register_chatcommand("clans.list", {
	description = S("Lists all existing clans. Blocked clans are marked with gray color."),
	func = function(_, _)
		local clans_str = ""
		for _, clan in pairs(clans.list()) do
			local clan1_str = string.format("%s \"%s\"", colorize("gray", clan.name), colorize(clans.COLOR, clan.title))
			if clan.is_blocked then
				clan1_str = clan1_str.." "..S("[Blocked]")
				clan1_str = colorize("silver", clan1_str)
			end
			clans_str = clans_str .. "\n" .. clan1_str
		end
		return true, "\n" .. S("List of clans:@n@1", clans_str) .. "\n\n"
	end
})

minetest.register_chatcommand("clans.show", {
	description = S("Shows given clan information."),
	func = function(_, param_str)
		local clan = clans.clan_get_by_name(param_str)
		if not clan then return false, S("Clan @1 does not exist.", param_str) end

		local msg = string.format("%s (%s)", clan.title, clan.name)
		if clan.is_blocked then
			msg = colorize("silver", msg.." "..S("[Blocked]"))
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
	params = S("<leader name> <clan name> <clan title>"),
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
