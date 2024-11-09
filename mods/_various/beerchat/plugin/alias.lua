--luacheck: no_unused_args

beerchat.alias = {
	priv = minetest.settings:get("beerchat.alias.priv") or "ban"
}

-- Data table for alias targets
local channels = minetest.deserialize(beerchat.mod_storage:get("alias.channels")) or {}

local function write_storage()
	local data = minetest.serialize(channels)
	beerchat.mod_storage:set_string("alias.channels", data)
end

local function switch_player_channel(name, alias, resolved)
	-- Aliases can allow joining protected channel without authorization.
	if beerchat.get_player_channel(name) == alias then
		-- Add and move player to resolved channel
		beerchat.set_player_channel(name, resolved)
	else
		-- Add player to resolved channel but keep active channel
		beerchat.add_player_channel(name, resolved)
	end
end

-- Attempts to resolve alias target, returns nil if there is no target for given alias
local function resolve_alias(alias)
	if channels[alias] then
		if beerchat.channels[channels[alias]] then
			return channels[alias]
		end
		-- Cleanup invalid alias, target channel disappeared
		channels[alias] = nil
	end
end

-- Do recursive resolution and return channel, returns unchanged input if there is no target for given alias
local function resolve_alias_recursive(alias)
	local resolved = resolve_alias(alias)
	while (resolved) do
		alias = resolved
		resolved = resolve_alias(alias)
	end
	return alias
end

-- Do chain resolution and relink previous aliases through shortest possible path (direct links)
local function relink_related(alias, target)
	local found = {}
	for a, c in pairs(channels) do
		if c == alias then
			-- Collect list of updated existing aliases here if reporting updates is wanted.
			if a == target then
				-- Loop detected, cancel relinking operation. Situation must be fixed by player.
				return false
			end
			table.insert(found, a)
		end
	end
	-- Only update aliases if every rewrite was ok
	for _, a in ipairs(found) do
		channels[a] = target
	end
	return true, found
end

local function add_alias(alias, target)
	-- Always use canonical name, resolve first to make direct links and skip chaining
	target = resolve_alias_recursive(target)
	if not alias then
		return false, "ERROR: Invalid source channel."
	elseif not target then
		return false, "ERROR: Invalid target channel."
	elseif target == alias then
		return false, "ERROR: Target channel cannot be same as source. Make sure you are not creating loop."
	end
	-- Try to do related channel relinking and add alias if resolution seems sane
	local success, relinked = relink_related(alias, target)
	if success then
		channels[alias] = target
		write_storage()
		for _,player in ipairs(minetest.get_connected_players()) do
			local name = player:get_player_name()
			if beerchat.playersChannels[name][target] then
				beerchat.add_player_channel(name, alias)
			end
			if beerchat.playersChannels[name][alias] then
				switch_player_channel(name, alias, target)
			end
		end
		local msgs = { "Alias #" .. alias .. " created. You can now use both names to access #" .. target .. "." }
		if #relinked > 0 then
			table.insert(msgs, " > Previous aliases were relinked to target: #" .. table.concat(relinked, ", #"))
		end
		return true, table.concat(msgs, "\n")
	end
	return false, "ERROR: Relinking existing aliases has failed, make sure your aliases are sane and without loops."
end

local function remove_alias(alias)
	channels[alias] = nil
end

beerchat.register_callback("after_joinplayer", function(player, last_login)
	if last_login then
		local name = player:get_player_name()
		local possible_alias = beerchat.get_player_channel(name)
		local resolved = resolve_alias(possible_alias)
		if resolved then
			minetest.chat_send_player(name, "ATTENTION: Your last active chat channel were linked with #" .. resolved
				.. " and you will be moved there. This is for your information, no action needed from you side.")
			switch_player_channel(name, possible_alias, resolved)
		end
	end
end)

beerchat.register_callback("before_send_on_channel", function(name, msg)
	local resolved = resolve_alias(msg.channel)
	if resolved then
		msg.channel = resolved
	end
end, "high")

beerchat.register_callback('before_switch_chan', function(name, switch)
	local resolved = resolve_alias(switch.to)
	if resolved then
		if resolved == switch.from then
			-- cannot switch back to origin
			return false, "Channel #" .. switch.to .. " is alias for #" .. switch.from .. " and you are already there."
		end
		switch.to = resolved
	end
end, "high")

beerchat.register_callback('before_leave', function(name, channel)
	local resolved = resolve_alias(channel)
	if resolved and resolved ~= channel then
		beerchat.remove_player_channel(name, resolved)
	end
end, "low")

beerchat.register_callback('before_delete_channel', function(name, data)
	local resolved = resolve_alias(data.channel)
	if resolved and resolved ~= data.channel then
		return false, "ERROR: #" .. data.channel .. " is alias for #" .. resolved .. ". Unlink channel before deleting."
	end
end)

--[[ HANDLERS FOR THESE EVENTS ARE WANTED BUT NOT YET FLEXIBLE ENOUGH FOR CHANNEL ALIASES:
beerchat.register_callback('on_join_channel', function(name, channel) end)
beerchat.register_callback('before_invite', function(name, recipient, channel) end)
beerchat.register_callback('before_join', function(name, channel) end)
beerchat.register_callback('on_forced_join', function(name, target, channel, from_channel) end)
--]]

minetest.register_chatcommand("channel-alias", {
	params = "<Alias name> [<Channel Name>]",
	description = "Link <Alias name> channel to <Channel Name> channel. Both channels must exist."
		.. "\nResolves alias to channel name if only first argument is given."
		.. "\nRequires `" .. beerchat.alias.priv .. "` privileges and channel ownership for alias management.",
	func = function(name, param)
		local match = param:gmatch("#?([^%s,]+)")
		local alias, channel = match(), match()

		-- Check if command is valid and decide alternate actions
		if not alias or match() then
			return false, "ERROR: Invalid number of arguments. Please supply the channel names."
		elseif not channel then
			-- Resolve alias end return results if channel argument is not supplied
			local resolved = resolve_alias(alias)
			if resolved then
				return true, "Alias #" .. alias .. " resolved to #" .. resolved .. "."
			end
			local found = {}
			for calias, chan in pairs(channels) do
				if alias == chan then
					table.insert(found, "#" .. calias)
				end
			end
			if #found > 0 then
				return true, "Resolving #" .. alias .. " failed. " ..
					"Instead it is regular channel with following aliases:\n" .. table.concat(found, ", ")
			end
			return true, "Could not resolve #" .. alias .. " to channel, it does not seem to be alias."
		elseif alias == beerchat.main_channel_name then
			-- TODO: Use channel deletion event for check, if channel cannot be deleted then it also cannot be alias.
			return false, "ERROR: Cannot convert main channel to alias!"
		elseif not beerchat.channels[alias] then
			return false, "ERROR: Channel #" .. alias .. " does not exist."
		elseif not beerchat.channels[channel] then
			return false, "ERROR: Channel #" .. channel .. " does not exist."
		end

		-- Check permissions for alias management
		if not minetest.check_player_privs(name, beerchat.admin_priv) then
			if minetest.check_player_privs(name, beerchat.alias.priv) then
				if not beerchat.playersChannels[name][alias] then
					return false, "ERROR: You need to join #" .. alias .. " before linking it to #" .. channel .. "."
				elseif not beerchat.playersChannels[name][channel] then
					return false, "ERROR: You need to join #" .. channel .. " before linking #" .. alias .. " to it."
				end
			elseif name ~= beerchat.channels[alias].owner then
				return false, "ERROR: You are not the owner of alias #" .. alias
			elseif name ~= beerchat.channels[channel].owner then
				return false, "ERROR: You are not the owner of channel #" .. channel
			end
		end

		return add_alias(alias, channel)
	end
})

minetest.register_chatcommand("channel-unalias", {
	params = "<Alias name>",
	description = "Unlink <Alias name> channel and make it regular channel."
		.. "\nRequires `" .. beerchat.alias.priv .. "` privileges and alias ownership for alias management.",
	func = function(name, param)
		local alias = param:match("^#?(%S+)$")
		if not alias then
			return false, "ERROR: Invalid number of arguments. Please supply the alias name."
		elseif not beerchat.channels[alias] then
			return false, "ERROR: Channel #" .. alias .. " does not exist."
		end

		local resolved = resolve_alias(alias)
		if not resolved then
			return true, "Could not resolve #" .. alias .. " to channel, it does not seem to be alias."
		end

		-- Check permissions for alias management
		if not minetest.check_player_privs(name, beerchat.admin_priv) then
			if minetest.check_player_privs(name, beerchat.alias.priv) then
				if not beerchat.playersChannels[name][resolved] then
					return false, "ERROR: You need to join #" .. resolved .. " before unlinking #" .. alias .. "."
				end
			elseif beerchat.channels[alias] and name ~= beerchat.channels[alias].owner then
				return false, "ERROR: You are not the owner of alias #" .. alias
			end
		end

		remove_alias(alias)
		return true, "Alias #" .. alias .. " converted to regular channel. Delete channel if not needed anymore."
	end
})
