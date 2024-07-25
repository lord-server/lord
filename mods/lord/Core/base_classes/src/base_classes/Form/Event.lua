local BaseEvent = require('base_classes.Event')

--- @class base_classes.Form.Event: base_classes.Event
local Event = BaseEvent:extended()

--- @class base_classes.Form.Event.Type
Event.Type = {
	on_register = 'on_register',
	on_instance = 'on_instance',
	on_open     = 'on_open',
	on_close    = 'on_close',
	on_handle   = 'on_handle',
}

--- @generic GenericForm: base_classes.Form.Base
--- @alias base_classes.Form.callback.on_register fun(form:GenericForm)
--- @alias base_classes.Form.callback.on_instance fun(form:GenericForm, player:Player, ...)
--- @alias base_classes.Form.callback.on_open     fun(form:GenericForm)
--- @alias base_classes.Form.callback.on_close    fun(form:GenericForm)
--- @alias base_classes.Form.callback.on_handle   fun(form:GenericForm, player:Player, fields:table)


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


return Event
