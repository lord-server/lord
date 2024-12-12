local items,                     colorize
    = minetest.registered_items, minetest.colorize

local S = minetest.get_mod_translator()




--- @param item_string string
--- @return string|nil
return function(item_string)
	local tool_capabilities = items[item_string].tool_capabilities
	if not tool_capabilities or not tool_capabilities.groupcaps then return nil end

	local strength_strings = {}
	for group, caps in pairs(tool_capabilities.groupcaps) do
		if caps.uses then
			local list_item = S('@1: @2', colorize('#bbb', S(group)), caps.uses)
			strength_strings[#strength_strings + 1] = '  • ' .. list_item
		end
	end

	return #strength_strings ~= 0
		and ('\n' ..
			colorize('#ee8', S('Durability')) .. ':\n' ..
				table.concat(strength_strings, '\n')
		)
		or nil
end
