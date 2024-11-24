local Device     = require('fuel_device.Device')
local Processor  = require('fuel_device.Processor')
local definition = {
	common              = require('fuel_device.node.definition.common'),
	inventory_callbacks = require('fuel_device.node.definition.inventory_callbacks'),
}


--- @alias fuel_device.NodeDef { node_name: string, definition: NodeDefinition }

--- @class fuel_device.NodesDefinitions
--- @field inactive fuel_device.NodeDef
--- @field active   fuel_device.NodeDef


--- @param device_name string                          name of device.
--- @param form        fuel_device.node.Form           any table that implements `fuel_device.node.Form` interface.
--- @param node_name   {inactive:string,active:string} names of inactive & active nodes.
---
--- @generic GenericDevice: fuel_device.Device
--- @return GenericDevice
local function create_generic_device(device_name, form, node_name, size_of)
	size_of = size_of or table.overwrite({ src = 1, dst = 1 }, size_of)

	return Device:extended({
		NAME       = device_name,
		form       = form,
		node_name  = node_name,
		size_of    = size_of,
	})
end

--- @generic GenericDevice: fuel_device.Device
--- @return GenericDevice
---
--- @param DeviceClass  GenericDevice
--- @param craft_method string
---
--- @generic GenericProcessor: fuel_device.Processor
--- @return GenericProcessor
local function create_generic_processor(DeviceClass, craft_method)
	return Processor:extended({
		DeviceClass  = DeviceClass,
		craft_method = craft_method,
	})
end

---@param fd_node_def         fuel_device.NodeDef
---@param common              NodeDefinition
---@param inventory_callbacks NodeDefinition
---@param base_def            NodeDefinition
local function register_node(fd_node_def, common, inventory_callbacks, base_def)
	base_def = table.merge(common, table.merge(inventory_callbacks, base_def))
	minetest.register_node(fd_node_def.node_name, table.overwrite(base_def, fd_node_def.definition))
end

--- @param inactive_full_name string                          inactive node name with ':' prefix
--- @param node_names         {inactive:string,active:string} nodes names without ':' prefix
--- @param DeviceClass        fuel_device.Device
local function register_lbm(inactive_full_name, node_names, DeviceClass)
	local node_name_parts = inactive_full_name:split(':')
	local mod_name, node_name = unpack(node_name_parts)

	minetest.register_lbm({
		label             = mod_name:first_to_upper() .. ' ' .. node_name .. ' initialization',
		name              = inactive_full_name .. '_init',
		nodenames         = { node_names.inactive, node_names.active },
		run_at_every_load = true,
		action            = function(pos, node)
			DeviceClass:new(pos):init()
		end
	})
end

--- @overload fun(device_name, craft_method, nodes_definitions, form)
--- @generic GenericDevice: fuel_device.Device
--- @generic GenericProcessor: fuel_device.Processor
---
--- @param device_name       string                       name of your device.
--- @param craft_method      string                       name of craft method (use `minetest.register_craft_method()`).
--- @param nodes_definitions fuel_device.NodesDefinitions partial nodes definitions (`drawtype` & `tiles` is enough).
--- @param form              fuel_device.node.Form        any table that implements `fuel_device.node.Form` interface.
--- @param size_of           {fuel:number,src:number,dst:number}  sizes of corresponding inventories.
--- @param DeviceClass       GenericDevice|nil            your own device, if you want something extend/change.
--- @param ProcessorClass    GenericProcessor|nil         your own processor, if you want something extend/change.
--- @return GenericDevice, GenericProcessor
local function register_nodes(device_name, craft_method, nodes_definitions, form, size_of, DeviceClass, ProcessorClass)
	local nodes_names = {
		inactive = nodes_definitions.inactive.node_name:replace('^:', ''),
		active   = nodes_definitions.active.node_name:replace('^:', ''),
	}
	DeviceClass    = DeviceClass    or create_generic_device(device_name, form, nodes_names, size_of)
	ProcessorClass = ProcessorClass or create_generic_processor(DeviceClass, craft_method)

	local common              = definition.common.get(DeviceClass)
	local inventory_callbacks = definition.inventory_callbacks.get(device_name, ProcessorClass)

	register_node(nodes_definitions.inactive, common, inventory_callbacks, {
		description = device_name,
	})

	register_node(nodes_definitions.active, common, inventory_callbacks, {
		description = device_name,
		on_timer    = ProcessorClass.get_on_timer_function(ProcessorClass),
	})

	-- Form or node meta inventories sizes can be changed in code in future.
	-- So we need to re-init formspec, infotext & sizes.
	-- LBM will works even the node name will be changed.
	register_lbm(nodes_definitions.inactive.node_name, nodes_names, DeviceClass)

	return DeviceClass, ProcessorClass
end


return {
	register = register_nodes
}
