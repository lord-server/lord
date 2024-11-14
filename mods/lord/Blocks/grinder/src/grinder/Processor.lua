--- @type Grinder
local Grinder   = require("grinder.Grinder")


--- - Returns whether grinding possible &
--- - if possible, also returns (RecipeOutput - result, RecipeInput - remaining) for source & fuel.
--- - So, returns `possible, result_source, remaining_source, result_fuel, remaining_fuel`
--- @param inv InvRef
--- @return boolean, RecipeOutput|nil, RecipeInput|nil, RecipeOutput|nil, RecipeInput|nil
local function grinding_possible(inv)
	local result_source, remaining_source = minetest.get_craft_result({
		method = 'grinder',
		type   = 'cooking',
		width  = 1,
		items  = inv:get_list('src'),
	})
	if not result_source or result_source.time == 0 then
		return false, nil, nil, nil, nil
	end

	local result_fuel, remaining_fuel = minetest.get_craft_result({
		method = "fuel",
		width = 1,
		items = inv:get_list("fuel")
	})

	local possible = result_source.time > 0 and result_fuel.time > 0 and inv:room_for_item("dst", result_source.item)
	if not possible then
		return false, nil, nil, nil, nil
	end

	return possible, result_source, remaining_source, result_fuel, remaining_fuel
end

--- @param meta           NodeMetaRef
--- @param remaining_fuel RecipeInput
--- @param result_fuel    RecipeOutput
local function burn_fuel(meta, remaining_fuel, result_fuel)
	local fuel_time = meta:get_int("fuel_time")
	local fuel_totaltime = meta:get_int("fuel_totaltime")

	if fuel_totaltime ~= result_fuel.time then
		meta:set_int("fuel_totaltime", result_fuel.time)
	end
	if fuel_time == 0 then
		meta:get_inventory():set_list("fuel", remaining_fuel.items)
	end

	fuel_time = fuel_time + 1

	if fuel_time >= fuel_totaltime then
		fuel_time = 0
	end

	meta:set_int("fuel_time", fuel_time)
end

--- @param meta             NodeMetaRef
--- @param remaining_source RecipeInput
--- @param result_source    RecipeOutput
--- @param time number
local function grind_source(meta, remaining_source, result_source)
	local src_time = meta:get_int("src_time")
	local src_totaltime = meta:get_int("src_totaltime")

	if src_time == 0 or src_totaltime == 0 then
		meta:set_int("src_totaltime", result_source.time)
	end

	src_time = src_time + 1

	if src_time >= src_totaltime then
		local inv = meta:get_inventory()
		inv:set_list("src", remaining_source.items)
		inv:add_item("dst", result_source.item)
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

	local possible, result_source, remaining_source, result_fuel, remaining_fuel = grinding_possible(inv)
	if possible then
		g:activate("%s Grinding")

		burn_fuel(meta, remaining_fuel, result_fuel)
		grind_source(meta, remaining_source, result_source)
	else
		g:deactivate("%s Out Of Heat")
	end

end

return Processor
