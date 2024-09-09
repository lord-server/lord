--- @alias damage.callbacks.OnDamage fun(player:Player,amount:number,reason:PlayerHPChangeReason,damage_type:string)

--- @class damage.Event: base_classes.Event
--- @field on      fun(self:self,event:string|damage.Event.Type): fun(callback:damage.callbacks.OnDamage)
--- @field trigger fun(self:self,event:string|damage.Event.Type, ...): void
local Event = base_classes.Event:extended()

--- @class damage.Event.Type
Event.Type = {
	on_damage = "on_damage",
}
--- @type table<string,damage.callbacks.OnDamage[]>
Event.subscribers = {
	--- @type damage.callbacks.OnDamage[]
	on_damage = {},
}


return Event
