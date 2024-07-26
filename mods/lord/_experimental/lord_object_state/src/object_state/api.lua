--- @class base_classes.ObjectState
local ObjectState = {
	--- @type ObjectRef
	object = nil,
}

--- @param object ObjectRef
--- @return ObjectState
function ObjectState:new(object)
	local class = self
	self = {}

	self.object = object
	
	return setmetatable(self, {__index = class})
end

---@param player ObjectRef
function ObjectState:get_player_state(player)
	local meta = player:get_meta()
	local state_string = meta:get("object_state")
	local state_table = minetest.deserialize(state_string)
	return state_table
end

---@param player ObjectRef
function ObjectState:set_player_state(player, state_table)
	local meta = player:get_meta()
	local state_string = minetest.serialize(state_table)
	meta:set_string("object_state", state_string)
end

---@param object ObjectRef
function ObjectState:get_entity_state(object)
	local properties = object:get_properties()
	local state_table = properties["object_state"]
	return state_table
end

---@param object ObjectRef
function ObjectState:set_entity_state(object, state_table)
	local properties = object:get_properties()
	properties["object_state"] = state_table
	object:set_properties(properties)
end

function ObjectState:add_state(player, state_name, value)
	-- body
end

function ObjectState:remove_state()
	-- body
end



return {

}
