--- @class ForeachPlayerEverySecondsCallback
--- @field every_seconds number
--- @field current_timer number
--- @field callback      fun(player:Player,delta_time:number)

--- @type ForeachPlayerEverySecondsCallback[]
local callbacks = {}

--- @param every_seconds number|nil|0
--- @param callback      fun(player:Player,delta_time:number)
minetest.foreach_player_every = function(every_seconds, callback)
	assert(type(callback) == "function")
	callbacks[#callbacks + 1] = {
		every_seconds = every_seconds or 0,
		current_timer = 0,
		callback      = callback,
	}
end

--- @param delta_time number
--- @return fun(player:Player,delta_time:number)[]
local function get_now_to_call(delta_time)
	local now_to_call = {}
	for _, callback in pairs(callbacks) do
		callback.current_timer = callback.current_timer + delta_time
		if callback.current_timer > callback.every_seconds then
			callback.current_timer = 0
			now_to_call[#now_to_call + 1] = callback.callback
		end
	end

	return now_to_call
end

minetest.register_globalstep(function(delta_time)
	local now_to_call = get_now_to_call(delta_time)

	for _, player in pairs(minetest.get_connected_players()) do
		for _, call in pairs(now_to_call) do
			call(player, delta_time)
		end
	end
end)
