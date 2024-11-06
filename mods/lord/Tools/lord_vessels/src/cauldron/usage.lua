
local cauldron_changes = {
	['lord_artisan_benches:cauldron_3_3'] = 'lord_artisan_benches:cauldron_2_3',
	['lord_artisan_benches:cauldron_2_3'] = 'lord_artisan_benches:cauldron_1_3',
	['lord_artisan_benches:cauldron_1_3'] = 'lord_artisan_benches:cauldron_0_3',
}

--- @param pos       Position
--- @param itemstack ItemStack
--- @param user      Player
local function fill_from(pos, itemstack, user, filled_item_name)
	local leftover

	for from, to in pairs(cauldron_changes) do
		if (minetest.get_node(pos).name == from) then
			minetest.remove_node(pos)
			minetest.set_node(pos, { name = to })
			itemstack:take_item()
			leftover = user:get_inventory():add_item('main', filled_item_name)
			if leftover then
				minetest.item_drop(leftover, user, pos)
			end
			return itemstack
		end
	end
end


return {
	fill_from = fill_from,
}
