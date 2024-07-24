local pairs
    = pairs


--- @static
--- @class base_classes.Event
local Event = {
	Type        = {},
	subscribers = {},
}

--- @static
--- @return base_classes.Event
function Event:extended(object_or_class)
	local class = self
	self = object_or_class or {}
	return setmetatable(self, { __index = class} )
end


--- @alias base_classes.Event.callback function

--- @generic GenericEvent: base_classes.Event
--- @param event string       name of event (One of `Event.Type::<const>`)
--- @param base  GenericEvent if you want to link returned function to this `base` class|object
--- @return fun(callback:controls.callback)
function Event:on(event, base)
	return base
		and
			function(callback)
				base:subscribe(event, callback)
			end
		or
			function(callback)
				self:subscribe(event, callback)
			end
end

--- @param event    string name of event (One of `Event.Type::<const>`)
--- @param callback controls.callback
function Event:subscribe(event, callback)
	assert(self.Type[event], "Unknown controls.Event.Type: " .. event)
	assert(type(callback) == "function")

	table.insert(self.subscribers[event], callback)
end

--- @private
--- @param event string name of event (One of `Event.Type::<const>`)
--- @vararg any pass args that will be passed to subscribers callbacks. See `controls.callbacks.<func-types>`
function Event:notify(event, ...)
	assert(self.Type[event], "Unknown controls.Event.Type: " .. event)

	for _, func in pairs(self.subscribers[event]) do
		func(...)
	end
end

--- @param event string name of event (One of `Event.Type::<const>`)
--- @vararg any pass args that will be passed to subscribers callbacks. See `controls.callbacks.<func-types>`
function Event:trigger(event, ...)
	self:notify(event, ...)
end


return Event
