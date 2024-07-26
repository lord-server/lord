--- @alias wield_item.callbacks.OnIndexChange fun(player:Player, key:string)
--- @alias wield_item.callback wield_item.callbacks.OnIndexChange


--- @static
--- @class wield_item.Event: base_classes.Event
--- @field on      fun(event:string|wield_item.Event.Type): fun(callback:wield_item.callback)
--- @field trigger fun(event:string|wield_item.Event.Type, ...): void
local Event = base_classes.Event:extended()

--- @class wield_item.Event.Type
Event.Type  = {
	on_index_change = "on_index_change",
}
--- @type table<string,wield_item.callback[]>
Event.subscribers = {
	---@type wield_item.callbacks.OnIndexChange[]
	on_index_change = {},
}


return Event
