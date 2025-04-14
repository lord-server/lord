--
-- router
--
lp_api.router     = {}
lp_api.router.cmd = minetest.settings:get("lp_api.router.cmd") or false

local SYS_NAME    = minetest.settings:get("lp_api.system_name") or "minetest"

function lp_api.router.to_string(tab, from_key)
	local res
	for k = #tab, from_key, -1 do
		if res then
			res = tab[k] .. " " .. res
		else
			res = tab[k]
		end
	end
	return res
end

function lp_api.msg_router(data)
	if data.type == "chat" then
		minetest.chat_send_all(core.colorize("#debd21", "<" .. data.player .. "> " .. data.message))
	end

	if data.type == "cmd" and lp_api.router.cmd then
		if data.command == "msg" then
			minetest.chat_send_player(data.args[1],
				core.colorize("#de6821", "<" .. data.player .. "> " .. lp_api.router.to_string(data.args, 2)))
		end

		if data.command == "ban" then
			minetest.ban_player(data.args[1])
			lp_api.publisher.pub_msg(SYS_NAME, "system", "Player {" .. data.args[1] .. "} Banned!", "")
		end

		if data.command == "unban" then
			minetest.unban_player_or_ip(data.args[1])
			lp_api.publisher.pub_msg(SYS_NAME, "system", "Player {" .. data.args[1] .. "} UnBanned!", "")
		end

		if data.command == "kick" then
			local result = minetest.kick_player(data.args[1], lp_api.router.to_string(data.args, 2))
			if result then
				if data.args[2] then
					lp_api.publisher.pub_msg(SYS_NAME, "system",
						"Player {" .. data.args[1] .. "} kicked!", lp_api.router.to_string(data.args, 2))
				else
					lp_api.publisher.pub_msg(SYS_NAME, "system",
						"Player {" .. data.args[1] .. "} kicked!", "")
				end
			end
		end

		if data.command == "grant" then
			if data.args[2] then
				local sp        = lp_api.router.to_string(data.args, 2)
				local add_privs = minetest.string_to_privs(sp)
				local privs     = minetest.get_player_privs(data.args[1])
				for p, _ in pairs(add_privs) do
					privs[p] = true
				end
				minetest.set_player_privs(data.args[1], privs)
				lp_api.publisher.pub_msg(SYS_NAME, "system", "The {" .. data.args[1] .. "} was given the", sp)
			end
		end

		if data.command == "revoke" then
			if data.args[2] then
				local sp        = lp_api.router.to_string(data.args, 2)
				local add_privs = minetest.string_to_privs(sp)
				local privs     = minetest.get_player_privs(data.args[1])
				for p, _ in pairs(add_privs) do
					privs[p] = nil
				end
				minetest.set_player_privs(data.args[1], privs)
				lp_api.publisher.pub_msg(SYS_NAME, "system", "The {" .. data.args[1] .. "} was taken away the", sp)
			end
		end

		if data.command == "privs" then
			local privs = minetest.privs_to_string(minetest.get_player_privs(data.args[1]), ' ')
			lp_api.publisher.pub_msg(SYS_NAME, "system", "Privileges of {" .. data.args[1] .. "}:", privs)
		end

		if data.command == "status" then
			lp_api.publisher.pub_msg(SYS_NAME, "system", "Status server.", minetest.get_server_status())
		end
	end
end

minetest.register_on_chat_message(function(name, message)
	lp_api.publisher.pub_msg(name, "chat", "", message)
end)

minetest.register_on_joinplayer(function(player, last_login)
	local name = player:get_player_name()
	local who  = (not last_login) and races.get_race(name) or "newbie"
	lp_api.publisher.pub_msg(SYS_NAME, "chat", "", who .. " {" .. name .. "} joined the game")
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	local who  = races.get_race(name)
	lp_api.publisher.pub_msg(SYS_NAME, "chat", "", who .. " {" .. name .. "} left the game")
end)
