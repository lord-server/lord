local pairs
    = pairs


--- @alias base_classes.Event.callback fun(...):void

--- @abstract
--- @class base_classes.Event
local Event = {
	--- @alias base_classes.Event.Type table<string,string>
	--- @class base_classes.Event.Type
	Type        = nil,
	--- @type table<string,base_classes.Event.callback[]>
	subscribers = nil,
}

--- @generic GenericEvent: base_classes.Event
--- @param child_class GenericEvent
--- @return GenericEvent
function Event:extended(child_class)
	self = setmetatable(child_class or {}, { __index = self })

	self.Type        = self.Type or {}
	self.subscribers = self.subscribers or {}

	return self
end

--- @generic GenericEvent: base_classes.Event
--- @param event string       name of event (One of `Event.Type::<const>`)
--- @param base  GenericEvent if you want to link returned function to this `base` class|object
--- @return fun(callback:base_classes.Event.callback)
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
--- @param callback base_classes.Event.callback
function Event:subscribe(event, callback)
	assert(self.Type[event], "Unknown Event.Type: " .. event)
	assert(type(callback) == "function")

	table.insert(self.subscribers[event], callback)
end

--- @private
--- @param event string name of event (One of `Event.Type::<const>`)
--- @vararg any pass args that will be passed to subscribers callbacks.
function Event:notify(event, ...)
	assert(self.Type[event], "Unknown Event.Type: " .. event)

	for _, func in pairs(self.subscribers[event]) do
		func(...)
	end
end

--- @param event string name of event (One of `Event.Type::<const>`)
--- @vararg any pass args that will be passed to subscribers callbacks.
function Event:trigger(event, ...)
	self:notify(event, ...)
end


return Event
