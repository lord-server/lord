--- @static
--- @class base_classes.ObjectState.Storage
local Storage = {}

--- Obtains `ObjectState` from meta or object properties depending on whether `object` is a player or not
--- @param object Player|Entity
--- @return table
function Storage.get_state_of(object)
	if not object then
		return
	end

	return object:is_player()
		and minetest.deserialize(object:get_meta():get("object_state") or "return {}")
		or  object:get_luaentity().object_state or {}
end

--- Obtains `ObjectState` from meta or object properties depending on whether `object` is a player or not
---
--- @param object       Player|Entity   a player or an entity to apply `ObjectState` to
--- @param state_table  table
---
--- @return boolean  success or not
function Storage.set_state_of(object, state_table)
	if not object then
		return false
	end

	local state_string = minetest.serialize(state_table)

	if object:is_player() then
		local meta = object:get_meta()
		meta:set_string("object_state", state_string)
	else
		local entity = object:get_luaentity()
		if not entity then
			return false
		end
		entity.object_state = state_table
	end

	return true
end


return Storage
