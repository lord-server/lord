local S = minetest.get_translator("clans")

minetest.register_chatcommand("clans.list", {
	description = S("Lists all existing clans."),
	privs = { server = true },
	func = function(_, _)
		local clans_str = ""
		for _, clan in pairs(clans.list()) do
			clans_str = clans_str .. clan.name.." ("..clan.title..")\n"
		end
		return true, S("List of clans:@n@1", clans_str)
	end
})

minetest.register_chatcommand("clans.show", {
	description = S("Shows given clan information."),
	privs = { server = true },
	func = function(_, param_str)
		local clan = clans.get_by_name(param_str)
		if not clan then
			return false, S("Clan @1 does not exist.", param_str)
		end
		return true, string.format("%s (%s): %s", clan.title, clan.name, table.concat(clan.players, ", "))
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

		local is_executed, err = clans.create_clan(clan_name, clan_title, members)
		if is_executed then
			local members_str = table.concat(members, ", ")
			return true, S("Clan @1 is created successfully. Members: @2", clan_name, members_str)
		elseif err == clans.err[1] then
			return false, S("Clan @1 already exists.", clan_name)
		elseif err == clans.err[2] then
			return false, S("A player from given is already assigned to a clan. Can't create clan @1.", clan_name)
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

		local is_executed, err = clans.remove_clan(name)
		if is_executed then
			return true, S("Clan @1 deleted successfully.", name)
		elseif err == clans.err[3] then
			return false, S("Clan @1 does not exist.", name)
		end
	end
})

minetest.register_chatcommand("clans.add_player", {
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
				local is_executed, err = clans.add_player_to_clan(clan_name, param)
				if not is_executed then
					if err == clans.err[3] then
						return false, S("Clan @1 does not exist.", clan_name)
					elseif err == clans.err[2] then
						return false, S("A player from given is already assigned to a clan.")
					end
				end
			end
		end
		return true, S("Given player(s) is(are) added to clan @1.", clan_name)
	end
})

minetest.register_chatcommand("clans.remove_player", {
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

		local is_executed, err = clans.remove_player_from_clan(clan_name, player_name)
		if is_executed then
			return true, S("Player @1 was removed from clan @2.", player_name, clan_name)
		elseif err == clans.err[4] then
			return false, S("Player @1 does not member of the @2 clan.", player_name, clan_name)
		elseif err == clans.err[3] then
			return false, S("Clan @1 does not exist.", clan_name)
		end
	end
})
