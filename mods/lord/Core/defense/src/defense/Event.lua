--- @alias defense.callback fun(player:Player,defense:defense.PlayerDefense)

--- @class defense.Event: base_classes.Event
--- @field on      fun(self:self,event:string|defense.Event.Type): fun(callback:defense.callback)
--- @field trigger fun(self:self,event:string|defense.Event.Type, ...): void
local Event = base_classes.Event:extended()

--- @class defense.Event.Type
Event.Type = {
	on_change = 'on_change',
	on_init   = 'on_init',
}
--- @type table<string,defense.callback[]>
Event.subscribers = {
	--- @type defense.callback[]
	on_change = {},
	--- @type defense.callback[]
	on_init   = {},
}


return Event
