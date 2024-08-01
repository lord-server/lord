local items,                     colorize
    = minetest.registered_items, minetest.colorize

local S = minetest.get_translator(minetest.get_current_modname())


local properties = {
	'crumbly', 'cracky', 'snappy', 'choppy', 'fleshy', 'explody',
}


--- @param item_string string
--- @return string|nil
return function(item_string)
	local definition = items[item_string]
	local groups = definition.groups
	if not groups then return nil end

	local prop_strings = {}
	for _, property in pairs(properties) do
		if table.has_key(groups, property) then
			prop_strings[#prop_strings+1] = '  • ' .. colorize('#bbb', S(property)) .. ': ' .. groups[property]
		end
	end

	local luminance = definition.light_source
	if luminance and luminance >= 1 then
		prop_strings[#prop_strings+1] = '  • ' .. colorize(tt.COLOR_DEFAULT, S("luminance")) .. ': ' .. luminance
	end


	return #prop_strings ~= 0
		and ('\n' ..
			colorize('#ee8', S('Properties')) .. ':\n' ..
				table.concat(prop_strings, '\n'))
		or nil
end
