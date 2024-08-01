local items,                     colorize
    = minetest.registered_items, minetest.colorize

local S = minetest.get_translator(minetest.get_current_modname())


--- @type table<string,string>
local buffs_groups = {
	damage_avoid_chance = '@1@2% chance to avoid a hit',
	physics_speed = '@1@2% to speed',
	physics_jump = '@1@2% to jump',
	physics_gravity = '@1@2% to gravity',
}
--- @param value number
--- @return string
local function sign(value)
	return value > 0 and '+' or (value < 0 and '-' or '')
end


--- @param item_string string
--- @return string|nil
return function (item_string)
	local groups = items[item_string].groups

	local buffs_strings = {}
	for group, template in pairs(buffs_groups) do
		if groups[group] then
			local value = groups[group]
			value = group:starts_with('physics_') and value * 100 or value
			buffs_strings[#buffs_strings+1] = '  • ' .. S(template, sign(value), value)
		end
	end

	return #buffs_strings ~= 0
		and ('\n' ..
			colorize('#ee8', S('Effects')) .. ':\n' ..
				table.concat(buffs_strings, '\n')
		)
		or nil
end
