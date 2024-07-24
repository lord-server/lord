local BaseEvent = require('base_classes.Event')

--- @class base_classes.Form.Event: base_classes.Event
local Event = BaseEvent:extended()

--- @class base_classes.Form.Event.Type
Event.Type = {
	on_instance = 'on_instance',
	on_open     = 'on_open',
	on_close    = 'on_close',
	on_handle   = 'on_handle',
	on_register = 'on_register',
}

--- @generic GenericForm: base_classes.Form.Base
--- @alias base_classes.Form.callback fun(form:GenericForm)

Event.subscribers = {
	--- @type base_classes.Form.callback[]
	on_instance = {},
	--- @type base_classes.Form.callback[]
	on_open     = {},
	--- @type base_classes.Form.callback[]
	on_close    = {},
	--- @type base_classes.Form.callback[]
	on_handle   = {},
	--- @type base_classes.Form.callback[]
	on_register = {},
}


return Event
