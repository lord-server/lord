local pairs
	= pairs


--- @class equipment.Event
local Event = {}

-- TODO make registration of equipment kind (`equipment.register_kind` API)
--- @private
Event.subscribers = {
	["armor"] = {
		["set"] = {},
		["delete"] = {},
		["change"] = {},
	},
	["clothing"] = {
		["set"] = {},
		["delete"] = {},
		["change"] = {},
	},
	["*any*"] = {
		["set"] = {},
		["delete"] = {},
		["change"] = {},
	},
}

--- @param kind     string equipment kind(type)
--- @param event    string
--- @param callback fun(player:Player, kind:string, event:string, slot:number, item:ItemStack)
function Event.subscribe(kind, event, callback)
	table.insert(Event.subscribers[kind][event], callback)
end

--- @private
function Event.notify(player, kind, event, slot, item)
	for _, callback in pairs(Event.subscribers[kind][event]) do
		callback(player, kind, event, slot, item)
	end
end

function Event.trigger(player, kind, event, slot, item)
	Event.notify(player, kind, event, slot, item)
	Event.notify(player, kind, "change", slot, item)  -- TODO use Event.CHANGE constant
	Event.notify(player, "*any*", event, slot, item)
	Event.notify(player, "*any*", "change", slot, item)
end

return {
	subscribe = Event.subscribe,
	trigger   = Event.trigger,
}
