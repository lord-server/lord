
--- @generic GenericForm: fuel_device.node.Form
--- @param device_name        string
--- @param form               GenericForm
local function get_on_construct_function(device_name, form)
	return function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string('formspec', form.get_spec('inactive'))
		meta:set_string('infotext', device_name)
		local inv = meta:get_inventory()
		inv:set_size('fuel', 1)
		inv:set_size('src', 1)
		inv:set_size('dst', 4)
	end
end

local common_definition = {
	paramtype2        = 'facedir',
	is_ground_content = false,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty('fuel') then
			return false
		elseif not inv:is_empty('dst') then
			return false
		elseif not inv:is_empty('src') then
			return false
		end
		return true
	end,
}


return {
	--- @generic GenericForm: fuel_device.node.Form
	--- @param device_name        string
	--- @param inactive_node_name string
	--- @param form               GenericForm
	get = function(device_name, inactive_node_name, form)
		return table.merge(common_definition, {
			drop         = 'grinder:grinder',
			on_construct = get_on_construct_function(device_name, form)
		})
	end
}
