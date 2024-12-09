
--- @generic GenericDevice: fuel_device.Device
--- @param Device fuel_device.Device
--- @return fun(pos:Position)
local function get_on_construct_function(Device)
	return function(pos)
		Device:new(pos):init()
	end
end

--- @generic GenericDevice: fuel_device.Device
--- @param Device fuel_device.Device
--- @return fun(pos:Position,player:Player)
local function get_can_dig_function(Device)
	--- @param pos    Position
	--- @param player Player
	return function(pos, player)
		if Device:new(pos):is_empty() then
			return true
		end
		return false
	end
end

local common_definition = {
	paramtype2        = 'facedir',
	is_ground_content = false,
}


return {
	--- @generic GenericDevice: fuel_device.Device
	--- @param Device GenericDevice
	get = function(Device)
		return table.merge(common_definition, {
			drop         = Device.node_name.inactive,
			on_construct = get_on_construct_function(Device),
			can_dig      = get_can_dig_function(Device),
		})
	end
}
