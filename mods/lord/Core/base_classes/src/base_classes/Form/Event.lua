local BaseEvent = require('base_classes.Event')


--- @generic GenericForm: base_classes.Form.Base
--- @alias base_classes.Form.callback.on_register fun(form:GenericForm)
--- @alias base_classes.Form.callback.on_instance fun(form:GenericForm, player:Player, ...)
--- @alias base_classes.Form.callback.on_open     fun(form:GenericForm)
--- @alias base_classes.Form.callback.on_close    fun(form:GenericForm)
--- @alias base_classes.Form.callback.on_handle   fun(form:GenericForm, player:Player, fields:table)
-- luacheck: no max line length
--- @alias base_classes.Form.callback base_classes.Form.callback.on_register|base_classes.Form.callback.on_instance|base_classes.Form.callback.on_open|base_classes.Form.callback.on_close|base_classes.Form.callback.on_handle


--- @generic GenericEvent: base_classes.Form.Event
--- @class base_classes.Form.Event: base_classes.Event
--- @field on      fun(event:string, base:GenericEvent): fun(callback:base_classes.Form.callback)
--- @field trigger fun(event:string, ...): void
local Event = BaseEvent:extended()

--- @class base_classes.Form.Event.Type
Event.Type = {
	on_register = 'on_register',
	on_instance = 'on_instance',
	on_open     = 'on_open',
	on_close    = 'on_close',
	on_handle   = 'on_handle',
}

--- @type table<string|base_classes.Form.Event.Type,base_classes.Form.callback[]>
Event.subscribers = {
	--- @type base_classes.Form.callback.on_register[]
	on_register = {},
	--- @type base_classes.Form.callback.on_instance[]
	on_instance = {},
	--- @type base_classes.Form.callback.on_open[]
	on_open     = {},
	--- @type base_classes.Form.callback.on_close[]
	on_close    = {},
	--- @type base_classes.Form.callback.on_handle[]
	on_handle   = {},
}

--- @generic GenericEvent: base_classes.Form.Event
--- @param child_class GenericEvent
--- @return GenericEvent
function Event:extended(child_class)
	child_class = child_class or {}

	child_class.Type        = child_class.Type        or table.copy(Event.Type)
	child_class.subscribers = child_class.subscribers or table.copy(Event.subscribers)

	return BaseEvent:extended(child_class)
end


return Event
