local pairs
    = pairs

--- @static
--- @class controls.Event
local Event       = {}

--- @class controls.Event.Type
Event.Type        = {
	on_press   = "on_press",
	on_hold    = "on_hold",
	on_release = "on_release",
}

--- @alias controls.callbacks.OnPress fun(player:Player, control_name:string)
--- @alias controls.callbacks.OnHold fun(player:Player, control_name:string, hold_time:number, delta_time:number)
--- @alias controls.callbacks.OnRelease fun(player:Player, control_name:string, release_time:number)
--- @alias controls.callback controls.callbacks.OnPress|controls.callbacks.OnHold|controls.callbacks.OnRelease

local subscribers = {
	---@type controls.callbacks.OnPress[]
	on_press   = {},
	---@type controls.callbacks.OnHold[]
	on_hold    = {},
	---@type controls.callbacks.OnRelease[]
	on_release = {},
}

--- @param event string name of event (One of `Event.Type::<const>`)
---
--- @return fun(callback:controls.callback)
function Event.on(event)
	return function(callback)
		Event.subscribe(event, callback)
	end
end

--- @param event    string name of event (One of `Event.Type::<const>`)
--- @param callback controls.callback
function Event.subscribe(event, callback)
	assert(Event.Type[event], "Unknown controls.Event.Type: " .. event)
	assert(type(callback) == "function")

	table.insert(subscribers[event], callback)
end

--- @private
--- @param event string name of event (One of `Event.Type::<const>`)
--- @vararg any pass args that will be passed to subscribers callbacks. See `controls.callbacks.<func-types>`
function Event.notify(event, ...)
	assert(Event.Type[event], "Unknown controls.Event.Type: " .. event)

	for _, func in pairs(subscribers[event]) do
		func(...)
	end
end

--- @param event string name of event (One of `Event.Type::<const>`)
--- @vararg any pass args that will be passed to subscribers callbacks. See `controls.callbacks.<func-types>`
function Event.trigger(event, ...)
	Event.notify(event, ...)
end

return Event
