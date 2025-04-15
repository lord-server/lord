--- @alias character.callbacks.OnRaceChange   fun(character:character.Character, race:string, old_race:string)
--- @alias character.callbacks.OnGenderChange fun(character:character.Character, gender:string)
--- @alias character.callbacks.OnSkinChange   fun(character:character.Character, skin_no:number)
-- luacheck: push no_max_line_length
--- @alias character.callback character.callbacks.OnRaceChange|character.callbacks.OnGenderChange|character.callbacks.OnSkinChange
-- luacheck: pop

--- @class character.Event: base_classes.Event
--- @field on      fun(self:self,event:string|character.Event.Type): fun(callback:character.callback)
--- @field trigger fun(self:self,event:string|character.Event.Type, ...): void
local Event = base_classes.Event:extended()

--- @class character.Event.Type
Event.Type = {
	on_race_change   = 'on_race_change',
	on_gender_change = 'on_gender_change',
	on_skin_change   = 'on_skin_change',
}
--- @type table<string,character.callback[]>
Event.subscribers = {
	--- @type character.callback[]
	on_race_change   = {},
	--- @type character.callback[]
	on_gender_change = {},
	--- @type character.callback[]
	on_skin_change   = {},
}


return Event
