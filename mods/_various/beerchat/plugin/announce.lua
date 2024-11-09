
-- Main in memory storage for all announcements
local announcements = {}

-- Links to currently active announcements
local active_announcements = {}

-- Announcement chat message formatting
local format_string = minetest.colorize("#f00", "Server") .. ": %s"

-- All current announcements formatted and combined
local announce_message

-- Write announcement data to mod data storage
local function write_announcements()
	local data = minetest.serialize(announcements)
	beerchat.mod_storage:set_string("announce.data", data)
end

local function format_message(message, color)
	if color then
		message = minetest.colorize(color, message)
	end
	return format_string:format(message)
end

local function combine_announcements()
	if #active_announcements > 0 then
		local messages = {"== Server has following public announcements =="}
		for _,announcement in ipairs(active_announcements) do
			table.insert(messages, format_message(announcement.message, announcement.color))
		end
		announce_message = table.concat(messages, "\n")
	else
		announce_message = nil
	end
end

-- Cleanup announcements table removing expired announcements
local function cleanup_announcements()
	local now = os.time()
	local removed = false
	local tmp = {}
	local tmp_active = {}
	for _,announcement in ipairs(announcements) do
		if not announcement.expire or announcement.expire > now then
			table.insert(tmp, announcement)
			if announcement.active then
				table.insert(tmp_active, announcement)
			end
		else
			removed = true
		end
	end
	if removed or #tmp ~= #announcements or #tmp_active ~= #active_announcements then
		-- Write latest data to mod storage if anything expired or main table size changed
		announcements = tmp
		active_announcements = tmp_active
		write_announcements()
		combine_announcements()
	end
end

local function send_global_announcement(data)
	if data then
		minetest.sound_play(beerchat.channel_message_sound, { gain = beerchat.sounds_default_gain }, true)
		minetest.chat_send_all(format_message(data.message, data.color))
	elseif announce_message then
		minetest.sound_play(beerchat.channel_message_sound, { gain = beerchat.sounds_default_gain }, true)
		minetest.chat_send_all(announce_message)
	end
end

local function manage_announcements(param)
	local escape_pattern = "\\([nte])"
	local escape_sequences = {
		n = "\n",
		t = "\t",
		e = string.char(0x1B),
	}
	local opts = {}
	local text = {}
	local args = param:gmatch("%S+")
	local arg = args()
	-- Parse arguments
	while arg do
		if arg == "-c" or arg == "-e" or arg == "-D" then
			opts[arg:sub(2,2)] = args()
		elseif arg == "-q" then
			opts[arg:sub(2,2)] = true
		elseif arg == "--" then
			arg = args()
			break
		else
			if arg:sub(1,1) == "-" then
				return false, "Invalid argument: " .. arg
			end
			break
		end
		arg = args()
	end
	-- Read message content
	while arg do
		local value = arg:gsub(escape_pattern, escape_sequences)
		table.insert(text, value)
		arg = args()
	end
	local msgs = {}
	-- Warning about not so fine behavior
	if opts.e then
		table.insert(msgs, "Warning: expiry is not fully automatic yet. Feel free to fix and submit PR.")
	end
	-- Add, delete, enable, disable or whatever was requested
	opts.D = tonumber(opts.D)
	if opts.D or #text > 0 then
		if opts.D and announcements[opts.D] then
			-- Mark deleted announcement
			announcements[opts.D].expire = 0
			table.insert(msgs, "Removed announcement " .. opts.D .. ".")
		end
		if #text > 0 then
			-- Add new announcement
			local data = {
				active = true,
				color = opts.c,
				expire = tonumber(opts.e),
				message = table.concat(text, " "),
			}
			table.insert(announcements, data)
			if opts.q then
				table.insert(msgs, "Added announcement '" .. data.message .. "'")
			else
				table.insert(msgs, "Added announcement.")
				send_global_announcement(data)
			end
		end
		-- Cleanup, save data and combine active announcements
		cleanup_announcements()
	else
		table.insert(msgs, "Arguments are not valid for anything.")
		return false, table.concat(msgs, "\n")
	end
	return true, table.concat(msgs, "\n")
end

minetest.register_chatcommand("server-announce", {
	params = "[-c <color>] [-e <expire>] [-D <delete id>] [-q] <message>",
	description = "List and manage server wide messages. Supports \\n, \\t and \\e escape sequences.",
	func = function(name, param)
		if param and param ~= "" then
			if minetest.check_player_privs(name, { ban = true }) then
				return manage_announcements(param)
			end
			return false, "Required privileges for arguments: ban. You can run this command without arguments."
		elseif announce_message then
			return true, announce_message
		end
		return true, "No active announcements."
	end
})

minetest.register_on_joinplayer(function(player)
	if announce_message then
		minetest.chat_send_player(player:get_player_name(), announce_message)
	end
end)

-- Read announcement data from mod data storage
do
	local data = minetest.deserialize(beerchat.mod_storage:get("announce.data"))
	if data then
		announcements = data
		cleanup_announcements()
	end
end
