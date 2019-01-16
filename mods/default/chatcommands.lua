local SL = lord.require_intllib()

--Modified from builtin/game/chatcommands.lua to hide privs starting with GAME

local function get_privs_string(privs)
	local privs_string = ""
	local i = 1
	for key,_ in pairs(privs) do
		if not key:match("GAME", 1) then
			if i == 1 then
				privs_string = privs_string .. key
			else
				privs_string = privs_string .. ", " .. key
			end
			i = i + 1
		end
	end
	return privs_string
end

minetest.register_chatcommand("privs", {
	params = "<name>",
	description = SL("print out privileges of player"),
	func = function(name, param)
		param = (param ~= "" and param or name)
		local privs_table = minetest.get_player_privs(param)
		local privs_string = get_privs_string(privs_table)
		return true, "Privileges of " .. param .. ": " .. privs_string
	end,
})

minetest.register_chatcommand("grant", {
	params = "<name> <privilege>|all",
	description = SL("Give privilege to player"),
	func = function(name, param)
		if not minetest.check_player_privs(name, {privs=true}) and
			not minetest.check_player_privs(name, {basic_privs=true}) then
			return false, "Your privileges are insufficient."
		end
		local grant_name, grantprivstr = string.match(param, "([^ ]+) (.+)")
		if not grant_name or not grantprivstr then
			return false, "Invalid parameters (see /help grant)"
		elseif not minetest.auth_table[grant_name] then
			return false, "Player " .. grant_name .. " does not exist."
		end
		local grantprivs = minetest.string_to_privs(grantprivstr)
		if grantprivstr == "all" then
			grantprivs = minetest.registered_privileges
		end
		local privs = minetest.get_player_privs(grant_name)
		local privs_unknown = ""
		for priv, _ in pairs(grantprivs) do
			if priv ~= "interact" and priv ~= "shout" and
					not minetest.check_player_privs(name, {privs=true}) then
				return false, "Your privileges are insufficient."
			end
			if not minetest.registered_privileges[priv] then
				privs_unknown = privs_unknown .. "Unknown privilege: " .. priv .. "\n"
			end
			if not priv:match("GAME", 1) then
				privs[priv] = true
			end
		end
		if privs_unknown ~= "" then
			return false, privs_unknown
		end
		minetest.set_player_privs(grant_name, privs)
		local privs_table = minetest.get_player_privs(grant_name)
		local privs_string = get_privs_string(privs_table)
		minetest.log(
			"action",
			name..' granted ' .. minetest.privs_to_string(grantprivs, ', ') .. ' privileges to '.. grant_name
		)
		if grant_name ~= name then
			minetest.chat_send_player(grant_name, name
					.. " granted you privileges: "
					.. minetest.privs_to_string(grantprivs, ' '))
		end
		return true, "Privileges of " .. grant_name .. ": " .. privs_string
	end,
})

minetest.register_chatcommand("revoke", {
	params = "<name> <privilege>|all",
	description = SL("Remove privilege from player"),
	privs = {},
	func = function(name, param)
		if not minetest.check_player_privs(name, {privs=true}) and
				not minetest.check_player_privs(name, {basic_privs=true}) then
			return false, "Your privileges are insufficient."
		end
		local revoke_name, revoke_priv_str = string.match(param, "([^ ]+) (.+)")
		if not revoke_name or not revoke_priv_str then
			return false, "Invalid parameters (see /help revoke)"
		elseif not minetest.auth_table[revoke_name] then
			return false, "Player " .. revoke_name .. " does not exist."
		end
		local revoke_privs = minetest.string_to_privs(revoke_priv_str)
		local privs = minetest.get_player_privs(revoke_name)
		for priv, _ in pairs(revoke_privs) do
			if priv ~= "interact" and priv ~= "shout" and
					not minetest.check_player_privs(name, {privs=true}) then
				return false, "Your privileges are insufficient."
			end
		end
		if revoke_priv_str == "all" then
			for priv, _ in pairs(privs) do
				if priv:find("GAME", 1) == nil then
					privs[priv] = nil
				end
			end
		else
			for priv, _ in pairs(revoke_privs) do
				if priv:find("GAME", 1) == nil then
					privs[priv] = nil
				end
			end
		end
		minetest.set_player_privs(revoke_name, privs)
		local privs_table = minetest.get_player_privs(revoke_name)
		local privs_string = get_privs_string(privs_table)
		minetest.log("action", name..' revoked ('
				..minetest.privs_to_string(revoke_privs, ', ')
				..') privileges from '..revoke_name)
		if revoke_name ~= name then
			minetest.chat_send_player(revoke_name, name
					.. " revoked privileges from you: "
					.. minetest.privs_to_string(revoke_privs, ' '))
		end
		return true, "Privileges of " .. revoke_name .. ": " .. privs_string
	end,
})
