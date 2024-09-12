-- This Events triggers when specific damage (damage.Type) has been done(dealt)

--- @alias damage.callbacks.OnDamageOf fun(player:Player,amount:number,reason:PlayerHPChangeReason)

--- @class damage.Type.Event: base_classes.Event
--- @field on      fun(self:self,event:string|damage.Type.Event.Type): fun(callback:damage.callbacks.OnDamageOf)
--- @field trigger fun(self:self,event:string|damage.Type.Event.Type, ...): void
local Event = base_classes.Event:extended()

--- This array fills when new damage.Type` registering
--- @class damage.Type.Event.Type: string[]
Event.Type        = {
	-- fleshy = "fleshy"
}
--- Initial arrays of subscribers sets when new `damage.Type` registering
--- @type table<string,damage.callbacks.OnDamageOf[]>
Event.subscribers = {
	-- fleshy = {}
}


return Event
