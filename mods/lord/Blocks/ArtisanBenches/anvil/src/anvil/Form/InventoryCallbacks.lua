
--- @type DetachedInventoryCallbacksDef
local InventoryCallbacks

--- @param inv InvRef
--- @return RecipeOutput, RecipeInput
local function get_craft_result(inv)
	return minetest.get_craft_result({
		method = minetest.CraftMethod.ANVIL,
		width  = 3,
		items  = inv:get_list('craft'),
	})
end

--- @param inv InvRef
local function make_result_prediction(inv)
	local result = get_craft_result(inv)
	inv:set_list('craft_result', { result.item })
end

local function do_craft(inv)
	local result, new_input = get_craft_result(inv)
	inv:set_list('craft', new_input.items)
	inv:set_list('craft_result', { result.item })
end

InventoryCallbacks = {

	allow_put = function(inv, list_name, index, stack, player)
		return list_name == 'craft' and stack:get_count() or 0
	end,
	allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
		return (from_list ~= 'craft_result' and to_list ~= 'craft_result')
			and count
			or  0
	end,

	on_put = function(inv, list_name, index, stack, player)
		make_result_prediction(inv)
	end,
	on_move = function(inv, from_list, from_index, to_list, to_index, count, _)
		make_result_prediction(inv)
	end,

	on_take = function(inv, list_name, index, stack, player)
		if list_name == 'craft_result' then
			do_craft(inv)
		end
		make_result_prediction(inv)
	end,
}


return InventoryCallbacks
