local math_random, type, pairs
    = math.random, type, pairs

local sound = {
	walk = { name = 'walk_on_bones',        gain = 0.25 },
	loot = { name = 'drop_loot_of_remains', gain = 3.0 },
}

--- @param count number              total max count of items to select from `items`.
--- @param items remains.drop.config list of items to select from.
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

local function sound_of_drop_loot()
	return {
		footstep = sound.walk,
		dug      = sound.loot,
		place    = sound.walk,
	}
end

local function sound_of_dig_remains()
	return {
		footstep = sound.walk,
		dug      = sound.walk,
		dig      = sound.walk,
		place    = sound.walk,
	}
end


return {
	get_random_items    = get_random_items,
	sound_of_drop_loot  = sound_of_drop_loot,
	sound_of_dig_remains = sound_of_dig_remains
}
