
-- Test if message from one player to another would get muted based on recipient ignore list
local is_muted = function(from, to)
	assert(type(to) == "string", "is_muted(from, to): 'to' should be a string, got "..type(to)..".")
	local player = minetest.get_player_by_name(to)
	if player then
		local meta = player:get_meta()
		return meta:get("beerchat:muted:" .. (from or "")) == "true"
	end
end

-- Events

beerchat.register_callback("before_send_pm", function(name, _, target)
	if is_muted(name, target) then
		return false
	end
end)

-- Ambiguous arguments for before_check_muted event, TBD if event should be deprecated or reworked.
beerchat.register_callback("before_check_muted", function(name, target)
	if is_muted(name, target) then
		return false
	end
end)

beerchat.register_callback("on_send_on_channel", function(name, _, target)
	if is_muted(name, target) ~= false then
		return false
	end
end)

-- Chat commands

local mute_player = {
	params = "<Player Name>",
	description = "Mute a player. After muting a player, you will no longer see chat "
		.. "messages of this user, regardless of what channel his user sends messages to.",
	func = function(name, param)
		if not beerchat.execute_callbacks("before_mute", name, param) then
			return false
		end

		if not param or param == "" then
			return false, "ERROR: Invalid number of arguments. Please supply the name of the user to mute."
		end

		if beerchat.has_player_muted_player(name, param) then
			minetest.chat_send_player(name, "Player " .. param .. " is already muted.")
		else
			minetest.get_player_by_name(name):get_meta():set_string("beerchat:muted:" .. param, "true")
			minetest.chat_send_player(name, "Muted player " .. param .. ".")
		end
		return true
	end
}

local unmute_player = {
	params = "<Player Name>",
	description = "Unmute a player. After unmuting a player, you will again see chat messages of this user",
	func = function(name, param)
		if not param or param == "" then
			return false, "ERROR: Invalid number of arguments. Please supply the name of the user to mute."
		end

		if beerchat.has_player_muted_player(name, param) then
			minetest.get_player_by_name(name):get_meta():set_string("beerchat:muted:" .. param, "")
			minetest.chat_send_player(name, "Unmuted player " .. param .. ".")
		else
			minetest.chat_send_player(name, "Player " .. param .. " was not muted.")
		end
		return true
	end
}

local list_muted = {
	params = "",
	description = "Show list of muted players.",
	func = function(name)
		local player = minetest.get_player_by_name(name)
		local meta = player and player:get_meta():to_table()

		if meta and meta.fields then
			local muted = {}
			for field, _ in pairs(meta.fields) do
				if field:sub(1, 15) == "beerchat:muted:" then
					table.insert(muted, field:sub(16, -1))
				end
			end

			if #muted > 0 then
				minetest.chat_send_player(name, table.concat(muted, ", "))
			else
				minetest.chat_send_player(name, "You have not muted any players.")
			end

			return true
		end
		return false
	end
}

minetest.register_chatcommand("mute", mute_player)
minetest.register_chatcommand("ignore", mute_player)
minetest.register_chatcommand("unmute", unmute_player)
minetest.register_chatcommand("unignore", unmute_player)
minetest.register_chatcommand("list_muted", list_muted)
