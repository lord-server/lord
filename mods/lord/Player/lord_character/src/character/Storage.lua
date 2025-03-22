
--- @class character.Storage
local Storage = {
	--- @type Player
	player = nil,
	--- @type PlayerMetaRef
	meta   = nil,
}

--- @overload fun(player:Player)
--- @param player Player @ player object.
--- @param prefix string @ [optional] prefix for each property name. Default: `"character:"`
--- @return character.Storage
function Storage:new(player, prefix)
	local class = self

	self = {}
	self.player = player
	self.meta   = player:get_meta()
	self.prefix = prefix or 'character:'

	return setmetatable(self, { __index = class })
end

--- @overload fun(name:string)
--- @param name    string property name (without prefix).
--- @param default string default value if there is no value for the property `name`.
--- @return string
function Storage:get(name, default)
	return self.meta:get(self.prefix .. name) or default
end

--- @param name  string property name (without prefix).
--- @param value string value to set to the property `name`.
--- @return character.Storage
function Storage:set(name, value)
	self.meta:set_string(self.prefix .. name, value)

	return self
end

--- @overload fun(name:string)
--- @param name    string property name (without prefix).
--- @param default number default value if there is no value for the property `name`.
--- @return number
function Storage:get_int(name, default)
	return self.meta:contains(self.prefix .. name)
		and self.meta:get_int(self.prefix .. name)
		or  default
end

--- @param name  string property name (without prefix).
--- @param value number value to set to the property `name`.
--- @return character.Storage
function Storage:set_int(name, value)
	self.meta:set_int(self.prefix .. name, value)

	return self
end

--- @overload fun(name:string)
--- @param name    string  property name (without prefix).
--- @param default boolean default value if there is no value for the property `name`.
--- @return boolean
function Storage:get_bool(name, default)
	return self.meta:contains(self.prefix .. name)
		and (self.meta:get_string(self.prefix .. name) == 'true' and true or false)
		or  default
end

--- @param name  string  property name (without prefix).
--- @param value boolean value to set to the property `name`.
--- @return character.Storage
function Storage:set_bool(name, value)
	self.meta:set_string(self.prefix .. name, value and 'true' or 'false')

	return self
end


return Storage
