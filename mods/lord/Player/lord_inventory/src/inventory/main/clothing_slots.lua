local SLOT_PURPOSE = {
	--[[ 1 --]] "head",   -- for items with `groups.clothes_head`
	--[[ 2 --]] "torso",  -- for items with `groups.clothes_torso`
	--[[ 3 --]] "legs",   -- for items with `groups.clothes_legs`
	--[[ 4 --]] "feet",   -- for items with `groups.clothes_feat`
	--[[ 5 --]] "cloak",  -- for items with `groups.clothes_cloak`
}

-- временно вынесено из кода detached inventory (ниже)
-- для дальнейшего переноса в соответствующие моды (см. #1012 #1017 #1021)
equipment.on_change("clothing", function(player, kind, event, slot, item)
	clothing:set_player_clothing(player)
	inventory.update(player)
end)

return {
	--- @param list_name string
	--- @param index number
	--- @param stack ItemStack
	--- @param player Player
	on_put = function(inv, list_name, index, stack, player)
		equipment.for_player(player):set(list_name, index, stack)
	end,
	--- @param list_name string
	--- @param index number
	--- @param player Player
	on_take = function(inv, list_name, index, stack, player)
		equipment.for_player(player):delete(list_name, index)
	end,
	--- @param index number
	--- @param stack ItemStack
	allow_put = function(inv, list_name, index, stack, player)
		local group_name = "clothes_" .. SLOT_PURPOSE[index]
		return (stack:get_definition().groups[group_name] == nil) and 0 or 1
	end,
	--- @param stack ItemStack
	allow_take = function(inv, list_name, index, stack, player)
		return stack:get_count()
	end,
	allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
		return 0
	end,
}
