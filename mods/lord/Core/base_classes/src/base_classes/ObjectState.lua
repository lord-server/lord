local Storage = require("base_classes.ObjectState.Storage")


--- @class base_classes.ObjectState
local ObjectState = {
	--- @private
	--- @type table<string,any>
	state_table = nil,
}

--- @param object table  Table of all state entries
--- @return base_classes.ObjectState
function ObjectState:new(object)
	local class = self

	self = setmetatable({}, { __index = class })
	self:load(object)

	return self
end

--- @param name string
--- @return any
function ObjectState:get_entry(name)
	return self.state_table[name]
end

--- @param name  string
--- @param value any
--- @return base_classes.ObjectState
function ObjectState:set_entry(name, value)
	self.state_table[name] = value

	return self
end
--- @param name string
--- @return base_classes.ObjectState
function ObjectState:del_entry(name)
	return self:set_entry(name, nil)
end

--- @param object ObjectRef
--- @return boolean
function ObjectState:save(object)
	return Storage.set_state_of(object, self.state_table)
end

--- @param object Player|Entity
function ObjectState:load(object)
	self.state_table = Storage.get_state_of(object)
end

return ObjectState
