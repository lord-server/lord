--- @class base_classes.ObjectState
local ObjectState = {
	--- @type table
	state = nil,
}

--- @param state_table table  Table of all state entries
--- @return ObjectState
function ObjectState:new(state_table)
	local class = self
	self = {}
	self.state = state_table or {}

	return setmetatable(self, {__index = class})
end

function ObjectState:add_state_entry(entry_name, value)
	self.state[entry_name] = value
	return self
end

function ObjectState:remove_state_entry(entry_name)
	self.state[entry_name] = nil
	return self
end

return ObjectState
