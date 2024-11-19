local math_floor
    = math.floor

local S = minetest.get_mod_translator()


--- - Returns whether processing possible &
--- - if possible, also returns (RecipeOutput - result, RecipeInput - remaining) for source & fuel.
--- - So, returns `possible, result_source, remaining_source, result_fuel, remaining_fuel`
--- @param inv    InvRef
--- @param meta   NodeMetaRef
--- @param method string
--- @return boolean, RecipeOutput|nil, RecipeInput|nil, RecipeOutput|nil, RecipeInput|nil
local function process_possible(inv, meta, method)
	local result_source, remaining_source = minetest.get_craft_result({
		method = method,
		type   = 'cooking',
		width  = 1,
		items  = inv:get_list('src'),
	})
	if not result_source or result_source.time == 0 then
		return false, nil, nil, nil, nil
	end

	local result_fuel, remaining_fuel = minetest.get_craft_result({
		method = 'fuel',
		width = 1,
		items = inv:get_list('fuel')
	})

	local possible =
		result_source.time > 0 and
		(result_fuel.time > 0 or meta:get_int('fuel_time') > 0) and
		inv:room_for_item('dst', result_source.item)
	if not possible then
		return false, nil, nil, nil, nil
	end

	return possible, result_source, remaining_source, result_fuel, remaining_fuel
end

--- @param meta           NodeMetaRef
--- @param remaining_fuel RecipeInput
--- @param result_fuel    RecipeOutput
local function burn_fuel(meta, remaining_fuel, result_fuel)
	local fuel_time = meta:get_int('fuel_time')
	local fuel_totaltime = meta:get_int('fuel_totaltime')

	if fuel_time == 0 then
		meta:get_inventory():set_list('fuel', remaining_fuel.items)
		meta:set_int('fuel_totaltime', result_fuel.time)
		fuel_totaltime = result_fuel.time
	end

	fuel_time = fuel_time + 1

	if fuel_time >= fuel_totaltime then
		fuel_time = 0
	end

	meta:set_int('fuel_time', fuel_time)
end

--- @param meta             NodeMetaRef
--- @param remaining_source RecipeInput
--- @param result_source    RecipeOutput
--- @param time number
local function grind_source(meta, remaining_source, result_source)
	local src_time = meta:get_int('src_time')
	local src_totaltime = meta:get_int('src_totaltime')

	if src_time == 0 or src_totaltime == 0 then
		meta:set_int('src_totaltime', result_source.time)
	end

	src_time = src_time + 1

	if src_time >= src_totaltime then
		local inv = meta:get_inventory()
		inv:set_list('src', remaining_source.items)
		inv:add_item('dst', result_source.item)
		src_time = 0
	end

	meta:set_int('src_time', src_time)
end


---
--- @class fuel_device.Processor
---
local Processor = {
	--- @static
	--- @type fuel_device.Device
	DeviceClass  = nil,
	--- @static
	--- @type string
	craft_method = nil,
}

--- @public
--- @generic GenericProcessor: fuel_device.Processor
--- @param child_class GenericProcessor
--- @return GenericProcessor
function Processor:extended(child_class)
	return setmetatable(child_class or {}, { __index = self })
end

-- -----------------------------------------------------------------------------------------------
-- Public functions:

--- @static
--- @overload fun():fun(position:Position):void
--- @generic GenericProcessor: fuel_device.Processor
--- @param self GenericProcessor just specify your own extended Processor class, or `fuel_device.Processor` well be used
function Processor.get_start_or_stop_function(self)
	self = self or Processor
	return function(position)
		self:start_or_stop(position)
	end
end

--- @static
--- @overload fun():fun(position:Position,elapsed:number):void
--- @generic GenericProcessor: fuel_device.Processor
--- @param self GenericProcessor just specify your own extended Processor class, or `fuel_device.Processor` well be used
function Processor.get_on_timer_function(self)
	self = self or Processor
	return function(position, elapsed)
		self:on_timer(position, elapsed)
	end
end

--- @param position Position
function Processor:start_or_stop(position)
	local device = self.DeviceClass:new(position)
	local meta   = device:get_meta()
	local inv    = meta:get_inventory()

	local possible = process_possible(inv, meta, self.craft_method)
	if possible then
		device:activate(S('Active'))
	else
		device:deactivate(S('Out Of Fuel'))
	end
end

--- @static
--- @param position Position
function Processor:act(position)
	local device = self.DeviceClass:new(position)
	local meta   = device:get_meta()
	local inv    = meta:get_inventory()

	local possible, result_source, remaining_source, result_fuel, remaining_fuel
		= process_possible(inv, meta, self.craft_method)
	if possible then
		device:activate(S('Active'))

		burn_fuel(meta, remaining_fuel, result_fuel)
		grind_source(meta, remaining_source, result_source)
	else
		device:deactivate(S('Out Of Fuel'))
	end
end

--- @static
--- @param position Position
--- @param elapsed  number
function Processor:on_timer(position, elapsed)
	for i = 1, math_floor(elapsed / self.DeviceClass.TIMER_TICK) do
		self:act(position)
	end

	minetest.get_node_timer(position):set(self.DeviceClass.TIMER_TICK, elapsed % self.DeviceClass.TIMER_TICK)
end


return Processor
