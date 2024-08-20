--- Obtains `ObjectState` from meta or object properties depending on whether `object` is a player or not
--- @param object ObjectRef
--- @return base_classes.ObjectState|nil
function minetest.get_object_state(object)
	if not object then
		return
	end

	if object:is_player() then
		local meta = object:get_meta()
		local state_string = meta:get("object_state")
		local state_table = minetest.deserialize(state_string)
		local object_state = base_classes.ObjectState:new(state_table)
		return object_state
	else
		local entity = object:get_luaentity()
		local state_table = entity.object_state
		local object_state = base_classes.ObjectState:new(state_table)
		return object_state
	end
end

--- Obtains `ObjectState` from meta or object properties depending on whether `object` is a player or not
--- @param object        ObjectRef                 a player or an entity to apply `ObjectState` to
--- @param object_state  base_classes.ObjectState
function minetest.set_object_state(object, object_state)
	if not object then
		return
	end
	local state_table = object_state.state
	local state_string = minetest.serialize(state_table)
	print(state_string)

	if object:is_player() then
		local meta = object:get_meta()
		meta:set_string("object_state", state_string)
	else
		local entity = object:get_luaentity()
		entity.object_state = state_table
	end
end
