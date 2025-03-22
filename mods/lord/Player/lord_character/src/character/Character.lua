local Property = require('character.Character.Property')
local Event    = require('character.Event')


--- @class character.Character
local Character     = {
	--- @protected
	--- @type character.Storage
	storage = nil,
}

--- @param storage character.Storage
---
--- @return character.Character
function Character:new(storage)
	local class  = self

	self         = {}
	self.storage = storage

	return setmetatable(self, { __index = class })
end

--- @return Player
function Character:get_player()
	return self.storage.player
end

--- @see lord_races.Name
--- @return string|nil one of lord_races.Name.<CONST>
function Character:get_race()
	return self.storage:get(Property.RACE)
end

--- @see lord_races.Name
--- @param default string one of lord_races.Name.<CONST>
--- @return string one of lord_races.Name.<CONST>
function Character:get_race_or(default)
	return self.storage:get(Property.RACE, default)
end

--- @see lord_races.Name
--- @param race string one of lord_races.Name.<CONST>
--- @return character.Character
function Character:set_race(race)
	self.storage:set(Property.RACE, race)
	Event:trigger(Event.Type.on_race_change, self, race)

	return self
end

--- @return string|nil one of `{ "male" | "female" | nil }`
function Character:get_gender()
	return self.storage:get(Property.GENDER)
end

--- @param default string one of `{ "male" | "female" }`
--- @return string one of `{ "male" | "female" }`
function Character:get_gender_or(default)
	return self.storage:get(Property.GENDER, default)
end

--- @param gender string one of `{ "male" | "female" }`
--- @return character.Character
function Character:set_gender(gender)
	assert(gender:is_one_of({ 'male', 'female' }))
	self.storage:set(Property.GENDER, gender)
	Event:trigger(Event.Type.on_gender_change, self, gender)

	return self
end

--- @see lord_skins
--- @return number|nil returns number of applied/chosen skin.
function Character:get_skin_no()
	return self.storage:get_int(Property.SKIN)
end

--- @see lord_skins
--- @param number number number of skin. Please check if skin available by `lord_skins` functions.
--- @return character.Character
function Character:set_skin_no(number)
	self.storage:set_int(Property.SKIN, number)
	Event:trigger(Event.Type.on_skin_change, self, number)

	return self
end

--- @return boolean returns whether the player can change Race.
function Character:has_second_chance()
	return self.storage:get_bool(Property.HAS_SECOND_CHANCE)
end

--- @param has boolean whether the player can change Race.
function Character:set_has_second_chance(has)
	self.storage:set_bool(Property.HAS_SECOND_CHANCE, has)

	return self
end


return Character
