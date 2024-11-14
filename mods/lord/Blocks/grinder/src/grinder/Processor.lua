--- @type Grinder
local Grinder   = require("grinder.Grinder")


--- @param inv InvRef
local function grinding_possible(inv)
	local result, remaining = minetest.get_craft_result({
		method = 'grinder',
		type   = 'cooking',
		width  = 1,
		items  = inv:get_list('src'),
	})
	if not result then
		return false
	end

	local result_fuel, remaining_fuel = minetest.get_craft_result({
		method = "fuel",
		width = 1,
		items = inv:get_list("fuel")
	})

	local time              = result and result.time
	local remaining_source  = result and remaining.items[1]
	local result_source     = result and ItemStack(result.item)

	return
		result ~= nil and result_fuel.time > 0 and inv:room_for_item("dst", result_source),
		time,
		remaining_fuel.items[1],
		remaining_source,
		result_fuel,
		result_source
end

--- @param meta NodeMetaRef
--- @param remaining_fuel ItemStack
--- @param result_fuel table
local function burn_fuel(meta, remaining_fuel, result_fuel)
	local fuel_time = meta:get_int("fuel_time")
	local fuel_totaltime = meta:get_int("fuel_totaltime")

	if fuel_totaltime ~= result_fuel.time then
		meta:set_int("fuel_totaltime", result_fuel.time)
	end
	if fuel_time == 0 then
		meta:get_inventory():set_stack("fuel", 1, remaining_fuel)
	end

	fuel_time = fuel_time + 1

	if fuel_time >= fuel_totaltime then
		fuel_time = 0
	end

	meta:set_int("fuel_time", fuel_time)
end

--- @param meta NodeMetaRef
--- @param remaining_source ItemStack
--- @param result_source ItemStack
--- @param time number
local function grind_source(meta, remaining_source, result_source, time)
	local src_time = meta:get_int("src_time")
	local src_totaltime = meta:get_int("src_totaltime")

	if src_time == 0 or src_totaltime == 0 then
		meta:set_int("src_totaltime", time)
	end

	src_time = src_time + 1

	if src_time >= src_totaltime then
		local inv = meta:get_inventory()
		inv:set_stack("src", 1, remaining_source)
		inv:add_item("dst", result_source)
		src_time = 0
	end

	meta:set_int("src_time", src_time)
end


---
--- @class Processor
---
local Processor = {}

-- -----------------------------------------------------------------------------------------------
-- Public functions:

--- @static
--- @param pos table {x,y,z}
function Processor.act(pos)

	local g    = Grinder:new(pos)
	local meta = g:get_meta()
	local inv  = meta:get_inventory()

	local possible, time, remaining_fuel, remaining_source, result_fuel, result_source = grinding_possible(inv)
	if possible then
		g:activate("%s Grinding")

		burn_fuel(meta, remaining_fuel, result_fuel)
		grind_source(meta, remaining_source, result_source, time)
	else
		g:deactivate("%s Out Of Heat")
	end

end

return Processor
