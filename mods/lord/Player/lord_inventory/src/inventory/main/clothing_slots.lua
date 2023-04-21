local SLOT_PURPOSE = {
	--[[ 1 --]] "head",   -- for items with `groups.clothes_head`
	--[[ 2 --]] "torso",  -- for items with `groups.clothes_torso`
	--[[ 3 --]] "legs",   -- for items with `groups.clothes_legs`
	--[[ 4 --]] "feet",   -- for items with `groups.clothes_feat`
	--[[ 5 --]] "cloak",  -- for items with `groups.clothes_cloak`
}

return {
	on_put = function(inv, listname, index, stack, player)
		player:get_inventory():set_stack(listname, index, stack)
		clothing:set_player_clothing(player)
		inventory.update(player)
	end,
	on_take = function(inv, listname, index, stack, player)
		player:get_inventory():set_stack(listname, index, nil)
		clothing:set_player_clothing(player)
		inventory.update(player)
	end,
	allow_put = function(inv, listname, index, stack, player)
		local group_name = "clothes_" .. SLOT_PURPOSE[index]
		return (stack:get_definition().groups[group_name] == nil) and 0 or 1
	end,
	allow_take = function(inv, listname, index, stack, player)
		return stack:get_count()
	end,
	allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
		return 0
	end,
}
