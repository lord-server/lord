
--- @class effects.Effect.Reason
--- @field name        string
--- @field description string

--- @alias effects.Effect.callback fun(player:Player,amount:number,duration:number,...)

--- @class effects.Effect
local Effect = {
	--- @type string
	name                  = nil, --- @diagnostic disable-line: assign-type-mismatch
	--- @type boolean
	stop_with_same_reason = nil, --- @diagnostic disable-line: assign-type-mismatch
}

--- @param name string
function Effect:new(name)
	local class = self

	self = {}
	self.name                  = name
	self.stop_with_same_reason = false

	return setmetatable(self, { __index = class })
end

--- @param is_stops boolean
--- @return effects.Effect
function Effect:is_stops_on_same_reason(is_stops)
	self.stop_with_same_reason = is_stops

	return self
end

--- @param start effects.Effect.callback
--- @return effects.Effect
function Effect:on_start(start)
	self.start = start

	return self
end

--- @param stop effects.Effect.callback
--- @return effects.Effect
function Effect:on_stop(stop)
	self.stop = stop

	return self
end

--- @param player   Player
--- @param amount   number
--- @param duration number
--- @param ...      any
function Effect:start(player, amount, duration, ...)
	error('No start function assign for effect: you have to set the `start()` function before; use `Effect:on_start()`')
end

--- @param player   Player
--- @param amount   number
--- @param duration number
--- @param ...      any
function Effect:stop(player, amount, duration, ...)
	error('No start function assign for effect: you have to set the `start()` function before; use `Effect:on_stop()`')
end


return Effect
