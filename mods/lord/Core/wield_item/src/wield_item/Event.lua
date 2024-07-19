local pairs
    = pairs

--- @static
--- @class wield_item.Event
local Event = {}

--- @class wield_item.Event.Type
Event.Type  = {
	on_index_change = "on_index_change",
}

--- @alias wield_item.callbacks.OnIndexChange fun(player:Player, key:string)
--- @alias wield_item.callback wield_item.callbacks.OnIndexChange

local subscribers = {
	---@type wield_item.callbacks.OnIndexChange[]
	on_index_change = {},
}

--- @param event string name of event (One of `Event.Type::<const>`)
---
--- @return fun(callback:wield_item.callback)
function Event.on(event)
	return function(callback)
		Event.subscribe(event, callback)
	end
end

--- @param event    string name of event (One of `Event.Type::<const>`)
--- @param callback wield_item.callback
function Event.subscribe(event, callback)
	assert(Event.Type[event], "Unknown wield_item.Event.Type: " .. event)
	assert(type(callback) == "function")

	table.insert(subscribers[event], callback)
end

--- @private
--- @param event string name of event (One of `Event.Type::<const>`)
--- @vararg any pass args that will be passed to subscribers callbacks. See `wield_item.callbacks.<func-types>`
function Event.notify(event, ...)
	assert(Event.Type[event], "Unknown wield_item.Event.Type: " .. event)

	for _, func in pairs(subscribers[event]) do
		func(...)
	end
end

--- @param event string name of event (One of `Event.Type::<const>`)
--- @vararg any pass args that will be passed to subscribers callbacks. See `wield_item.callbacks.<func-types>`
function Event.trigger(event, ...)
	Event.notify(event, ...)
end

return Event
