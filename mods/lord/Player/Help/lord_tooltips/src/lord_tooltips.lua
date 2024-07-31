local items,                     colorize
    = minetest.registered_items, minetest.colorize

local S = minetest.get_translator(minetest.get_current_modname())


local properties = {
	'crumbly', 'cracky', 'snappy', 'choppy', 'fleshy', 'explody',
}


--- @param item_string string
--- @return string|nil
local function properties_snippet(item_string)
	local groups = items[item_string].groups

	local prop_strings = {}
	for _, property in pairs(properties) do
		if table.has_key(groups, property) then
			prop_strings[#prop_strings+1] = '  • ' .. colorize('#bbb', S(property)) .. ': ' .. groups[property]
		end
	end

	return #prop_strings ~= 0
		and (colorize('#ee8', '\n' .. S('Properties')) .. ':\n' .. table.concat(prop_strings, '\n'))
		or nil
end

--- @param item_string string
--- @return string|nil
local function damage_snippet(item_string)
	local tool_capabilities = items[item_string].tool_capabilities
	if not tool_capabilities or not tool_capabilities.damage_groups then return nil end

	local interval = tool_capabilities.full_punch_interval or 1
	local damage_strings = {}
	for type, damage in pairs(tool_capabilities.damage_groups) do
		local damage_in_sec = damage / interval
		local list_item = S(
			'$dmg-item-tpl$ @1: @2 in @3 sec @4',
			colorize('#bbb', S(type..'_dmg')), damage, interval, colorize('#ddd', S('(@1/sec)', damage_in_sec))
		)
		damage_strings[#damage_strings+1] = '  • ' .. list_item
	end

	return #damage_strings ~=0
		and (
			'\n' .. colorize('#ee8', S('Damage')) .. ':\n' ..
				table.concat(damage_strings, '\n') .. '\n' ..
				S('Punch Speed: @1', interval)
		)
		or  nil
end


return {
	init = function()
		tt.register_snippet(properties_snippet)
		tt.register_snippet(damage_snippet)
	end,
}
