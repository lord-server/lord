local SLOT_PURPOSE = {
	--[[ 1 --]] "head",   -- for items with `groups.armor_head`
	--[[ 2 --]] "torso",  -- for items with `groups.armor_torso`
	--[[ 3 --]] "legs",   -- for items with `groups.armor_legs`
	--[[ 4 --]] "feet",   -- for items with `groups.armor_feat`
	--[[ 5 --]] "shield", -- for items with `groups.armor_shield`
}

-- HACK: as for now, when player swaps an items in inventory,
--       MT calls `on_put` previously than `on_take`.
--       see https://github.com/minetest/minetest/issues/13486
--       This HACK is workaround of such MT behavior.
-- TODO: rollback this "hack"-commit (see comments to our #1029)
--       https://github.com/lord-server/lord/issues/1029
local now_swapping = {}

return {
	--- @param inv InvRef
	--- @param list_name string
	--- @param index number
	--- @param stack ItemStack
	--- @param player Player
	on_put = function(inv, list_name, index, stack, player)
		if (not equipment.for_player(player):get(list_name, index):is_empty()) then
			now_swapping[player:get_player_name()] = true
			equipment.for_player(player):delete(list_name, index)
		end
		equipment.for_player(player):set(list_name, index, stack)
	end,
	--- @param list_name string
	--- @param index number
	--- @param player Player
	on_take = function(inv, list_name, index, stack, player)
		if now_swapping[player:get_player_name()] then
			now_swapping[player:get_player_name()] = false
			return
		end
		equipment.for_player(player):delete(list_name, index)
	end,
	--- @param index number
	--- @param stack ItemStack
	allow_put = function(inv, list_name, index, stack, player)
		local group_name = "armor_" .. SLOT_PURPOSE[index]
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
