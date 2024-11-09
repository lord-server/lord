
beerchat.cb = {} -- all custom callbacks

beerchat.cb.before_send        = {} -- executed before sending message
beerchat.cb.before_send_pm     = {} -- executed before sending private message
beerchat.cb.before_whisper     = {} -- executed before whisper message is sent
beerchat.cb.before_join        = {} -- executed before channel is joined
beerchat.cb.before_leave       = {} -- executed before channel is leaved
beerchat.cb.before_switch_chan = {} -- executed before channel is changed
beerchat.cb.before_invite      = {} -- excuted before channel invitation takes place
beerchat.cb.before_mute        = {} -- executed before player is muted
beerchat.cb.before_check_muted = {} -- executed before has_player_muted_player checks
beerchat.cb.on_forced_join     = {} -- executed right after player is forced to channel

-- Special events
beerchat.cb.after_joinplayer   = {} -- executed after player has joined and configurations loaded

-- Callbacks that can edit message contents
beerchat.cb.on_receive             = {} -- executed when new message is received
beerchat.cb.on_http_receive        = {} -- executed when new message is received through http polling
beerchat.cb.on_send_on_channel     = {} -- executed before delivering message to individual channel subscriber
beerchat.cb.before_send_on_channel = {} -- executed before sending message to channel
beerchat.cb.before_delete_channel  = {} -- executed before channel is deleted

local priorities = {
	high = 0,
	medium = 250,
	default = 500,
	low = 750,
	lowest = 1000
}
local cb_priority = {}

beerchat.register_callback = function(trigger, fn, priority)
	assert(type(trigger) == 'string',
		'Error: Invalid trigger argument for beerchat.register_callback, must be string. Got ' .. type(trigger))
	assert(type(fn) == 'function',
		'Error: Invalid fn argument for beerchat.register_callback, must be function. Got ' .. type(fn))
	priority = priority or priorities.default
	priority = type(priority) == 'number' and priority or priorities[priority]
	assert(type(priority) == 'number', 'Error: Invalid priority argument for beerchat.register_callback.')
	if not beerchat.cb[trigger] then
		local err = {('Error: Invalid callback trigger event %s, possible triggers:'):format(trigger)}
		for k,_ in pairs(beerchat.cb) do
			table.insert(err, ' ->   ' .. k)
		end
		error(table.concat(err, "\n"))
	end
	cb_priority[trigger] = cb_priority[trigger] or {}
	for i, v in ipairs(cb_priority[trigger]) do
		if priority < v then
			table.insert(cb_priority[trigger], i, priority)
			table.insert(beerchat.cb[trigger], i, fn)
			return
		end
	end
	table.insert(cb_priority[trigger], priority)
	table.insert(beerchat.cb[trigger], fn)
end

beerchat.execute_callbacks = function(trigger, ...)
	local cb_list = beerchat.cb[trigger]
	local arg = {...}
	for _,fn in ipairs(cb_list) do
		local result, msg = fn(unpack(arg))
		if result ~= nil then
			if msg and type(arg[1]) == "string" then
				minetest.chat_send_player(arg[1], msg)
			end
			return result
		end
	end
	return true
end

-- Log notification for bad event definition, use before_send_pm if possible

beerchat.register_callback("before_check_muted", function()
	minetest.log("warning", "Beerchat 'before_check_muted' event fired: this event has issues and should probably be "
		.. "either deprecated or updated. Use 'before_send_pm' or beerchat.has_player_muted_player(a,b) if possible.")
end, -1)

-- TODO: harmonize callbacks

-- called on every channel message
-- params: channel, playername, message
beerchat.on_channel_message = function()
end

-- called on every /me message
-- params: channel, playername, message
beerchat.on_me_message = function()
end
