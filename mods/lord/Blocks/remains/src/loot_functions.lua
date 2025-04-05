local math_random, type, pairs, ipairs, table_copy
    = math.random, type, pairs, ipairs, table.copy

local function get_random_items(count, items)
	local result_items = {}
	for _, row in pairs(items) do
		if math_random(row.rarity) == 1 then
			result_items[#result_items + 1] = type(row.item) == 'table'
				and row.item[math_random(#(row.item))]
				or  row.item
		end
		if #result_items == count then
			break
		end
	end


	return result_items
end

-- фукниция выбрасывания лута в мир
local function drop_items_to_world(remains_pos, player_pos, items)
	local drop_pos       = table_copy(remains_pos)
	drop_pos.y           = remains_pos.y + 1
	local drop_direction = {
		x = (player_pos.x - drop_pos.x),
		y = (player_pos.y - drop_pos.y + 3.5),
		z = (player_pos.z - drop_pos.z),
	}
	local random_loot = get_random_items(5, items)
	for _, loot in ipairs(random_loot) do
		if loot then
			local item = minetest.add_item(drop_pos, loot)
			item:set_velocity(drop_direction)
		end
	end
end


return {
	get_random_items = get_random_items,
	drop_items_to_world = drop_items_to_world
}
