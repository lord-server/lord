
--- @class factions.FactionDefinition
--- @field name        string   faction code/id.
--- @field title       string   human-readable translated faction title.
--- @field description string   human-readable translated description of faction.
--- @field hostiles    string[] you can use any purpose string-names to configure list of hostiles for the faction.
--- @field friends     string[] you can use any purpose string-names to configure list of friends for the faction.


--- @class factions.Faction
local Faction = {
	--- @type string   faction code/id.
	name        = nil,
	--- @type string   human-readable translated faction title.
	title       = '',
	--- @type string   human-readable translated description of faction.
	description = '',
	--- @type string[] list of hostiles for the faction.
	hostiles    = {},
	--- @type string[] list of friends for the faction.
	friends     = {},
}

--- @param definition factions.FactionDefinition
function Faction:new(definition)
	assert(type(definition.name) == 'string')
	assert(type(definition.title) == 'string')
	assert(type(definition.description) == 'string')
	definition.hostiles = definition.hostiles or {}
	definition.friends  = definition.friends  or {}
	assert(type(definition.hostiles) == 'table')
	assert(type(definition.friends)  == 'table')

	local class = self
	self = {}

	self.name        = definition.name
	self.title       = definition.title
	self.description = definition.description
	self.hostiles    = {}
	self.friends     = {}
	for _, hostile_name in pairs(definition.hostiles) do
		self.hostiles[hostile_name] = true
	end
	for _, hostile_name in pairs(definition.friends) do
		self.friends[hostile_name] = true
	end

	return setmetatable(self, { __index = class })
end

--- @param name string name of checking hostile.
--- @return boolean
function Faction:has_hostile(name)
	return self.hostiles[name] == true
end

--- @param name string name of checking hostile.
--- @return boolean
function Faction:has_friend(name)
	return self.friends[name] == true
end

--- @param name string name of hostile to add.
--- @return factions.Faction
function Faction:add_hostile(name)
	self.hostiles[name] = true

	return self
end

--- @param name string name of hostile to add.
--- @return factions.Faction
function Faction:add_friend(name)
	self.friends[name] = true

	return self
end


return Faction
