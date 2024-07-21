
--- @static
--- @class wield_item.Event: base_classes.Event
local Event = base_classes.Event:extended()

--- @class wield_item.Event.Type
Event.Type  = {
	on_index_change = "on_index_change",
}

--- @alias wield_item.callbacks.OnIndexChange fun(player:Player, key:string)
--- @alias wield_item.callback wield_item.callbacks.OnIndexChange

Event.subscribers = {
	---@type wield_item.callbacks.OnIndexChange[]
	on_index_change = {},
}


return Event
