
--- Places an item in the inventory of the specified player
---   or drops it on the ground nearby, if there is not enough space in the inventory.
--- @param player Player
--- @param stack  ItemStack
--- @return boolean `true` if the item is put into inventory, and `false` if the item is dropped to the world.
function minetest.give_or_drop(player, stack)
	local inv = player:get_inventory()
	if inv:room_for_item("main", stack) then
		inv:add_item("main", stack)
		return true
	else
		minetest.item_drop(stack, player, player:get_pos())
		return false
	end
end
