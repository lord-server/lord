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
		local damage_in_sec = string.format('%.2f', damage / interval)
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

local armor_groups = { 'armor_head', 'armor_torso', 'armor_legs', 'armor_feet', 'armor_shield'}
local function armor_snippet(item_string)
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
		and (colorize('#ee8', '\n' .. S('Defense')) .. ':\n' .. table.concat(defense_strings, '\n'))
		or nil
end

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
local function buffs_snippet(item_string)
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
		and (colorize('#ee8', '\n' .. S('Effects')) .. ':\n' .. table.concat(buffs_strings, '\n'))
		or nil
end

-- Прочность: armor_use/wear

return {
	init = function()
		tt.register_snippet(properties_snippet)
		tt.register_snippet(damage_snippet)
		tt.register_snippet(armor_snippet)
		tt.register_snippet(buffs_snippet)
	end,
}
