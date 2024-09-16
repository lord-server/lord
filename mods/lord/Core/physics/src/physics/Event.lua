--- @alias physics.callback fun(player:Player,physics:physics.PlayerPhysics)

--- @class physics.Event: base_classes.Event
--- @field on      fun(self:self,event:string|physics.Event.Type): fun(callback:physics.callback)
--- @field trigger fun(self:self,event:string|physics.Event.Type, ...): void
local Event = base_classes.Event:extended()

--- @class physics.Event.Type
Event.Type = {
	on_init   = 'on_init',
	on_change = 'on_change',
}
--- @type table<string,physics.callback[]>
Event.subscribers = {
	--- @type physics.callback[]
	on_init   = {},
	--- @type physics.callback[]
	on_change = {},
}


return Event
