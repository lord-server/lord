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
	local node_name = {
		inactive = nodes_definitions.inactive.node_name:replace('^:', ''),
		active   = nodes_definitions.active.node_name:replace('^:', ''),
	}
	DeviceClass     = DeviceClass or create_generic_device(device_name, form, node_name, size_of)
	ProcessorClass  = ProcessorClass or create_generic_processor(DeviceClass, craft_method)

	local common              = definition.common.get(DeviceClass)
	local inventory_callbacks = definition.inventory_callbacks.get(device_name, ProcessorClass)

	--- @type NodeDefinition
	local inactive_node = {
		description = device_name,
		-- backwards compatibility: punch to set formspec
		on_punch = function(pos, player)
			local meta = minetest.get_meta(pos)
			meta:set_string('infotext', device_name)
			meta:set_string('formspec', form.get_spec('inactive'))
		end
	}
	inactive_node = table.merge(common, table.merge(inventory_callbacks, inactive_node))
	minetest.register_node(
		nodes_definitions.inactive.node_name,
		table.overwrite(inactive_node, nodes_definitions.inactive.definition)
	)

	--- @type NodeDefinition
	local active_node = {
		description = device_name,
		on_timer    = ProcessorClass.get_on_timer_function(ProcessorClass),
	}
	active_node = table.merge(common, table.merge(inventory_callbacks, active_node))
	minetest.register_node(
		nodes_definitions.active.node_name,
		table.overwrite(active_node, nodes_definitions.active.definition)
	)

	return DeviceClass, ProcessorClass
end


return {
	register = register_nodes
}
