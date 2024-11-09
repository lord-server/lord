
local function format_string(s, tab)
	return (s:gsub('($%b{})', function(w) return tab[w:sub(3, -2)] or w end))
end

-- Expose format_string to public
beerchat.format_string = format_string

local function colorize_target_name(s, target)
	if not target or not s then
		return s
	end
	return s:gsub(target, minetest.colorize("#ff0000", target))
end

beerchat.format_message = function(s, tab)
	local owner
	local password
	local color = beerchat.default_channel_color
	local channel_name = tab.channel_name or ""

	if beerchat.channels[channel_name] then
		owner = beerchat.channels[channel_name].owner
		password = beerchat.channels[channel_name].password
		color = beerchat.channels[channel_name].color
	end

	if tab.color then
		color = tab.color
	end

	if tab.colorize_all then
		s = minetest.colorize(color, s)
	else
		channel_name = minetest.colorize(color, channel_name)
	end

	local params = {
		channel_name = channel_name,
		channel_owner = owner,
		channel_password = password,
		from_player = tab.from_player,
		to_player = tab.to_player,
		message = colorize_target_name(tab.message, tab.to_player),
		time = os.date("%X")
	}

	return format_string(s, params)
end
