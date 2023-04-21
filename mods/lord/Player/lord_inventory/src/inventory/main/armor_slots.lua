local SLOT_PURPOSE = {
	--[[ 1 --]] "head",   -- for items with `groups.armor_head`
	--[[ 2 --]] "torso",  -- for items with `groups.armor_torso`
	--[[ 3 --]] "legs",   -- for items with `groups.armor_legs`
	--[[ 4 --]] "feet",   -- for items with `groups.armor_feat`
	--[[ 5 --]] "shield", -- for items with `groups.armor_shield`
}

return {
	on_put = function(inv, list_name, index, stack, player)
		player:get_inventory():set_stack(list_name, index, stack)
		armor:set_player_armor(player)
		inventory.update(player)
		lottachievements.equip(stack, player, 1)
	end,
	on_take = function(inv, list_name, index, stack, player)
		player:get_inventory():set_stack(list_name, index, nil)
		armor:set_player_armor(player)
		inventory.update(player)
		lottachievements.equip(stack, player, -1)
	end,
	allow_put = function(inv, list_name, index, stack, player)
		local group_name = "armor_" .. SLOT_PURPOSE[index]
		return (stack:get_definition().groups[group_name] == nil) and 0 or 1
	end,
	allow_take = function(inv, list_name, index, stack, player)
		return stack:get_count()
	end,
	allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
		return 0
	end,
}
