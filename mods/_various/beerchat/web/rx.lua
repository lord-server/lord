local http = ...

local function handle_data(data)
	if not data or not data.username or not data.text or not data.gateway or not data.protocol then
		return
	end

	if not beerchat.execute_callbacks('on_http_receive', data) then
		return
	end

	if data.event == "user_action" then
		-- "/me" message, TODO: use format and helper in "plugin/me.lua"
		beerchat.send_on_local_channel({name=data.username, channel=data.gateway, message=data.text})
	elseif data.event == "join_leave" then
		-- join/leave message, from irc for example
		beerchat.send_on_local_channel({name=data.username, channel=data.gateway, message=data.text})
	else
		-- regular text
		if string.sub(data.text, 1, 1) == "!" then
			-- user command
			local cmd_name = string.sub(data.text, 2)
			local fn = beerchat.get_relaycommand(cmd_name)
			if not fn then
				beerchat.on_channel_message(data.gateway, "SYSTEM", "command not found: '" .. cmd_name .. "'")
			else
				beerchat.on_channel_message(data.gateway, "SYSTEM", fn(data.username, data.text, data.protocol))
			end
		else
			-- regular user message
			beerchat.send_on_local_channel({name=data.username, channel=data.gateway, message=data.text})
		end
	end
end

local function recv_loop()
	http.fetch({
		url = beerchat.url .. "/api/messages",
		extra_headers = {
			"Authorization: Bearer " .. beerchat.token
		},
		timeout = 10,
	}, function(res)
		if res.succeeded and res.code == 200 and res.data and res.data ~= "" then
			local data = minetest.parse_json(res.data)
			if not data then
				minetest.log("error", "[beerchat] content parsing error: " .. dump(res.data))
				return
			end

			if #data > 0 then
				-- array received
				for _, item in ipairs(data) do
					handle_data(item)
				end
			end
		else
			-- ignore errors
			minetest.log("error", "[beerchat] http request to " .. beerchat.url .. " failed with code " .. res.code)
		end

	end)
	-- re-schedule receive function in any case
	minetest.after(1, recv_loop)
end

-- start loop
minetest.after(1, recv_loop)
