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
--- @param default string one of `lord_races.Name.<CONST>` or your own value if needed.
--- @return string|nil one of lord_races.Name.<CONST> or `default` value.
function Character:get_race(default)
	return self.storage:get(Property.RACE, default)
end

--- @see lord_races.Name
--- @param race string one of lord_races.Name.<CONST>
--- @return character.Character
function Character:set_race(race)
	assert(lord_races.get_player_races()[race])

	local old_race = self:get_race()
	self.storage:set(Property.RACE, race)
	Event:trigger(Event.Type.on_race_change, self, race, old_race)

	return self
end

--- @param default string one of `{ "male" | "female" }` or your own value if needed.
--- @return string|nil one of `{ "male" | "female" | nil }` or `default` value.
function Character:get_gender(default)
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
--- @param default number default skin number or your own value if needed.
--- @return number|nil returns number of applied/chosen skin.
function Character:get_skin_no(default)
	return self.storage:get_int(Property.SKIN, default)
end

--- Removes skin number from storage, if `number` is `nil`.
--- @overload fun()
--- @see lord_skins
--- @param number number|nil number of skin. Please check if skin available by `lord_skins` functions. Removes if `nil`.
--- @return character.Character
function Character:set_skin_no(number)
	if number == nil then
		self.storage:remove(Property.SKIN)
	else
		self.storage:set_int(Property.SKIN, number)
	end

	Event:trigger(Event.Type.on_skin_change, self, number)

	return self
end

--- @return boolean returns whether the player can change Race.
function Character:has_second_chance()
	return self.storage:get_bool(Property.HAS_SECOND_CHANCE, true)
end

--- @param has boolean whether the player can change Race.
function Character:set_has_second_chance(has)
	self.storage:set_bool(Property.HAS_SECOND_CHANCE, has)

	return self
end

--- @return string return skin texture file name
function Character:get_skin_texture()
	return lord_skins.get_texture_name(
		self:get_race(lord_races.Name.SHADOW), self:get_gender('male'), self:get_skin_no(1)
	)
end

--- @param preview_type string one of `"both"` | `"front"`.
--- @return string return skin preview file name
function Character:get_skin_preview_name(preview_type)
	return lord_skins.get_preview_name(
		preview_type, self:get_race(lord_races.Name.SHADOW), self:get_gender('male'), self:get_skin_no(1)
	)
end


return Character
