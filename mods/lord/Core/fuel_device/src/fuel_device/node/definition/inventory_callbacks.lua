
--- @param stack ItemStack
--- @return boolean
local function is_fuel(stack)
	return minetest.get_craft_result({ method = 'fuel', width = 1, items = { stack } }).time ~= 0
end

--- @type NodeDefinition
local inventory_callbacks = {
	allow_metadata_inventory_put  = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		if listname == 'fuel' then
			if is_fuel(stack) then
				return stack:get_count()
			else
				return 0
			end
		elseif listname == 'src' then
			return stack:get_count()
		elseif listname == 'dst' then
			return 0
		end
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta  = minetest.get_meta(pos)
		local inv   = meta:get_inventory()
		local stack = inv:get_stack(from_list, from_index)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		if to_list == 'fuel' then
			if is_fuel(stack) then
				return count
			else
				return 0
			end
		elseif to_list == 'src' then
			return count
		elseif to_list == 'dst' then
			return 0
		end
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		return stack:get_count()
	end,
}

return {
	get = function(device_name, Processor)
		return table.merge(inventory_callbacks, {
			on_metadata_inventory_move = Processor.get_start_or_stop_function(Processor),
			on_metadata_inventory_put  = Processor.get_start_or_stop_function(Processor),
			on_metadata_inventory_take = Processor.get_start_or_stop_function(Processor),
		})
	end
}
