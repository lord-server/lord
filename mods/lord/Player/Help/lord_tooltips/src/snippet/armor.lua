local items,                     colorize
    = minetest.registered_items, minetest.colorize

local S = minetest.get_mod_translator()


local armor_groups = { 'defense_fleshy', 'defense_fire', 'defense_soul', 'defense_poison', }


--- @param item_string string
--- @return string|nil
return function(item_string)
	local groups = items[item_string].groups

	local defense_strings = {}
	for _, armor_group in pairs(armor_groups) do
		local defense = groups[armor_group]
		if defense then
			local list_item = colorize('#bbb', S(armor_group)) .. ': +' .. defense .. '%'
			defense_strings[#defense_strings+1] = '  • ' .. list_item
		end
	end

	return #defense_strings ~= 0
		and ('\n' ..
			colorize('#ee8', S('Defense')) .. ':\n' ..
				table.concat(defense_strings, '\n')
		)
		or nil
end
