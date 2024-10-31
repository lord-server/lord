local items,                     colorize
    = minetest.registered_items, minetest.colorize

local properties = {
	node = require('snippet.properties.node'),
	item = require('snippet.properties.item'),
}
local S = minetest.get_mod_translator()


local dig_properties = {
	'crumbly', 'cracky', 'snappy', 'choppy', 'fleshy', 'explody',
}


--- @param item_string string
--- @return string|nil
return function(item_string)
	local definition = items[item_string]
	local groups = definition.groups
	if not groups then return nil end

	local prop_strings = {}
	for _, property in pairs(dig_properties) do
		if table.has_key(groups, property) then
			prop_strings[#prop_strings+1] = colorize('#bbb', S(property)) .. ': ' .. groups[property]
		end
	end

	prop_strings = table.merge_values(prop_strings, properties.node.get_list_items(item_string))

	return #prop_strings ~= 0
		and ('\n' ..
			colorize('#ee8', S('Properties')) .. ':\n' ..
				'  • ' .. table.concat(prop_strings, '\n  • '))
		or nil
end
