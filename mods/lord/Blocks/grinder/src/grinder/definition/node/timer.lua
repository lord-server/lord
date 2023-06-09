local S = minetest.get_translator("grinder")
local form = require('grinder.definition.node.form')
local Recipe = require("grinder.Recipe")

local function swap_node(pos, name)
	local node = minetest.get_node(pos)
	if node.name == name then
		return
	end
	node.name = name
	minetest.swap_node(pos, node)
end

timer = {}

timer.on_timer = function(pos, elapsed)
	local meta = minetest.get_meta(pos)
	local fuel_time = meta:get_float("fuel_time") or 0
	local src_time = meta:get_float("src_time") or 0
	local fuel_totaltime = meta:get_float("fuel_totaltime") or 0

	local inv = meta:get_inventory()
	local srclist, fuellist
	local dst_full = false

	local timer_elapsed = meta:get_int("timer_elapsed") or 0
	meta:set_int("timer_elapsed", timer_elapsed + 1)

	local grindable, grinded
	local fuel

	local update = true
	while elapsed > 0 and update do
		update = false

		srclist = inv:get_list("src")
		fuellist = inv:get_list("fuel")

		--
		-- Cooking
		--

		-- Check if we have grindable content
		grinded = Recipe.get_grinding_result(srclist)
		local aftergrinded = Recipe.get_grinding_result(srclist)
		minetest.chat_send_all(dump(grinded))
		print(dump(grinded))
		minetest.chat_send_all(dump(aftergrinded))
		print(dump(aftergrinded))
		grindable = grinded.time ~= 0

		local el = math.min(elapsed, fuel_totaltime - fuel_time)
		if grindable then -- fuel lasts long enough, adjust el to cooking duration
			el = math.min(el, grinded.time - src_time)
		end

		-- Check if we have enough fuel to burn
		if fuel_time < fuel_totaltime then
			-- The grinder is currently active and has enough fuel
			fuel_time = fuel_time + el
			-- If there is a grindable item then check if it is ready yet
			if grindable then
				src_time = src_time + el
				if src_time >= grinded.time then
					-- Place result in dst list if possible
					if inv:room_for_item("dst", grinded.output) then
						inv:add_item("dst", grinded.output)
						inv:set_stack("src", 1, aftergrinded.new_input[1])
						src_time = src_time - grinded.time
						update = true
					else
						dst_full = true
					end
				else
					-- Item could not be grinded: probably missing fuel
					update = true
				end
			end
		else
			-- grinder ran out of fuel
			if grindable then
				-- We need to get new fuel
				local afterfuel
				fuel, afterfuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuellist})

				if fuel.time == 0 then
					-- No valid fuel in fuel list
					fuel_totaltime = 0
					src_time = 0
				else
					-- prevent blocking of fuel inventory (for automatization mods)
					local is_fuel = minetest.get_craft_result({method = "fuel", width = 1, items = {afterfuel.items[1]:to_string()}})
					if is_fuel.time == 0 then
						table.insert(fuel.replacements, afterfuel.items[1])
						inv:set_stack("fuel", 1, "")
					else
						-- Take fuel from fuel list
						inv:set_stack("fuel", 1, afterfuel.items[1])
					end
					-- Put replacements in dst list or drop them on the grinder.
					local replacements = fuel.replacements
					if replacements[1] then
						local leftover = inv:add_item("dst", replacements[1])
						if not leftover:is_empty() then
							local above = vector.new(pos.x, pos.y + 1, pos.z)
							local drop_pos = minetest.find_node_near(above, 1, {"air"}) or above
							minetest.item_drop(replacements[1], nil, drop_pos)
						end
					end
					update = true
					fuel_totaltime = fuel.time + (fuel_totaltime - fuel_time)
				end
			else
				-- We don't need to get new fuel since there is no grindable item
				fuel_totaltime = 0
				src_time = 0
			end
			fuel_time = 0
		end

		elapsed = elapsed - el
	end

	if fuel and fuel_totaltime > fuel.time then
		fuel_totaltime = fuel.time
	end
	if srclist and srclist[1]:is_empty() then
		src_time = 0
	end

	--
	-- Update formspec, infotext and node
	--
	local formspec
	local item_state
	local item_percent = 0
	if grindable then
		item_percent = math.floor(src_time / grinded.time * 100)
		if dst_full then
			item_state = S("100% (output full)")
		else
			item_state = S("@1%", item_percent)
		end
	else
		if srclist and not srclist[1]:is_empty() then
			item_state = S("Not grindable")
		else
			item_state = S("Empty")
		end
	end

	local fuel_state = S("Empty")
	local active = false
	local result = false

	if fuel_totaltime ~= 0 then
		active = true
		local fuel_percent = 100 - math.floor(fuel_time / fuel_totaltime * 100)
		fuel_state = S("@1%", fuel_percent)
		formspec = form.get('active', fuel_percent, item_percent)
		swap_node(pos, "grinder:grinder_active")
		-- make sure timer restarts automatically
		result = true

	else
		if fuellist and not fuellist[1]:is_empty() then
			fuel_state = S("@1%", 0)
		end
		formspec = form.get('inactive')
		swap_node(pos, "grinder:grinder")
		-- stop timer on the inactive grinder
		minetest.get_node_timer(pos):stop()
		meta:set_int("timer_elapsed", 0)
	end


	local infotext
	if active then
		infotext = S("Grinder active")
	else
		infotext = S("Grinder inactive")
	end
	infotext = infotext .. "\n" .. S("(Item: @1; Fuel: @2)", item_state, fuel_state)

	--
	-- Set meta values
	--
	meta:set_float("fuel_totaltime", fuel_totaltime)
	meta:set_float("fuel_time", fuel_time)
	meta:set_float("src_time", src_time)
	meta:set_string("formspec", formspec)
	meta:set_string("infotext", infotext)

	return result
end


return timer
