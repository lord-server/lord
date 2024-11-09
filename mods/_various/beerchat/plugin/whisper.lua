local whisper_default_range = tonumber(minetest.settings:get("beerchat.whisper.range")) or 32
local whisper_max_range = tonumber(minetest.settings:get("beerchat.whisper.max_range")) or 200
local whisper_color = minetest.settings:get("beerchat.whisper.color") or "#aaaaaa"
local whisper_string = minetest.settings:get("beerchat.whisper.format") or "<${from_player}> whispers: ${message}"

local whisperers = {}

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	whisperers[name] = nil
end)

-- Returns true when someone heard whisper and false if nobody else can hear whisper (cancelled, too far, no position)
local function whisper(pos, radius, name, msg)
	radius = radius or whisper_default_range
	if not beerchat.execute_callbacks('before_whisper', name, msg, "", radius, pos) then
		-- Whispering was cancelled by one of external callbacks
		return false
	end
	-- true if someone heard the player
	local successful = false
	for _, other_player in ipairs(minetest.get_connected_players()) do
		-- calculate distance
		local opos = other_player:get_pos()
		local distance = vector.distance(opos, pos)
		if distance < radius then
			-- player in range
			local target = other_player:get_player_name()
			-- check if muted
			if not beerchat.has_player_muted_player(target, name) then
				-- mark as sent if anyone else is hearing it
				if name ~= target then
					successful = true
				end
				-- deliver message
				beerchat.send_message(target, nil, {
					name = name,
					message = beerchat.format_message(whisper_string, {
						from_player = name,
						to_player = target,
						message = msg,
						color = whisper_color,
						colorize_all = true
					})
				})
			end
		end
	end
	return successful
end

-- Returns 2 values: radius as a number and message as a string.
-- Unspecified radius returns nil: return nil, "hello world"
-- Specified radius with empty message returns: return 32, ""
-- Unspecified radius with empty message returns: return nil, ""
-- Invalid command returns nil message: return nil, nil
local function parse_command(message)
	local radius, msg = message:match("^$(%S*)%s*(.*)$")
	if radius == "" or tonumber(radius) then
		-- Valid whisper command, return values
		return tonumber(radius), msg
	end
	-- Invalid whisper command, return nil
	return nil, nil
end

-- Send message to players near position, public API function for backward compatibility.
-- $ chat a.k.a. dollar chat code, to whisper messages in chat to nearby players only using $,
-- optionally supplying a radius e.g. $32 Hello
beerchat.whisper = function(name, message)
	if message:sub(1,1) == "$" then
		-- This is whisper command, parse values
		local radius, msg = parse_command(message)
		if not msg then
			-- Invalid whisper command
			minetest.chat_send_player(name, "Invalid whisper command, make sure that radius is valid number and try again.")
			return true
		end
		local player = minetest.get_player_by_name(name)
		if radius and (radius > whisper_max_range or radius < 1) then
			-- Complain about too long range (also negative or zero range without specific error message)
			minetest.chat_send_player(name, "You cannot whisper outside of a radius of "..whisper_max_range.." nodes")
		elseif msg == "" then
			-- Toggle whisper mode when $ used without message
			if not whisperers[name] then
				-- Enter whisper mode
				whisperers[name] = radius or whisper_default_range
				minetest.chat_send_player(name, "Whisper mode activated with radius "..whisperers[name]
					..", to cancel write $ again without message")
			elseif radius then
				-- Update radius while in whisper mode
				whisperers[name] = radius
				minetest.chat_send_player(name, "Whisper mode is active and radius updated to "..radius
					..", to cancel write $ again without message")
			else
				-- Disable whisper mode
				whisperers[name] = nil
				minetest.chat_send_player(name, "Whisper mode canceled, messages will be sent to channel")
			end
		elseif player then
			-- Do whisper by command
			if not whisper(player:get_pos(), radius, name, msg) then
				minetest.chat_send_player(name, "no one heard you whispering!")
			end
		end
		-- Message handled, stop processing message
		return true
	elseif whisperers[name] then
		-- This is not whisper command but player has enabled whisper mode
		local player = minetest.get_player_by_name(name)
		if player then
			if not whisper(player:get_pos(), whisperers[name], name, message) then
				minetest.chat_send_player(name, "no one heard you whispering!")
			end
		end
		-- Message handled, stop processing message
		return true
	end
end

beerchat.register_on_chat_message(beerchat.whisper)

minetest.register_chatcommand("whis", {
	params = "<message>",
	description = "Whisper command for those who can't use $",
	func = function(name, param)
		local msg = beerchat.default_on_receive(name, param)
		if msg then
			beerchat.whisper(msg.name, "$ " .. msg.message)
		end
		return true
	end
})
