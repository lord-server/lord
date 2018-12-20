--- @type Grinder
local Grinder   = require("grinder.Grinder")
--- @type Recipe
local Recipe    = require("grinder.Recipe")

---
--- @class Processor
---
local Processor = {}

-- -----------------------------------------------------------------------------------------------
-- Public functions:

--- @static
--- @param pos table {x,y,z}
function Processor.act (pos)

	local g          = Grinder:new(pos)
	local meta       = g:getMeta()
	local inv        = meta:get_inventory()

	local recipe

	local result     = Recipe.get_grinding_recipe("grinding", inv:get_list("src"))
	local was_active = false

	if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
		was_active = true
		meta:set_int("fuel_time", meta:get_int("fuel_time") + 1)
		if result then
			meta:set_int("src_time", meta:get_int("src_time") + 1)
			if meta:get_int("src_time") >= result.time then
				meta:set_int("src_time", 0)
				local result_stack = ItemStack(result.output)
				if inv:room_for_item("dst", result_stack) then
					inv:set_stack("src", 1, result.new_input)
					inv:add_item("dst", result_stack)
				end
			end
		else
			meta:set_int("src_time", 0)
		end
	end

	local cooked = 10
	if result then
		cooked = result.time or 10
	end
	if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
		g:activate("%s Grinding", cooked)
		return
	end

	recipe = Recipe.get_grinding_recipe("grinding", inv:get_list("src"))
	if not recipe then
		if was_active then
			g:deactivate("%s is empty")
		end
		return
	end

	local fuel
	local afterfuel
	local fuellist = inv:get_list("fuel")

	if fuellist then
		fuel, afterfuel = minetest.get_craft_result({ method = "fuel", width = 1, items = fuellist })
	end

	if fuel.time <= 0 then
		g:deactivate("%s Out Of Heat")
		return
	end

	meta:set_int("fuel_totaltime", fuel.time)
	meta:set_int("fuel_time", 0)

	inv:set_stack("fuel", 1, afterfuel.items[1])
end

return Processor
