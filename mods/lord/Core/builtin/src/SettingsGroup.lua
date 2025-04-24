
--- @class Voxrame.SettingsGroup
local SettingsGroup = {
	--- @type string name of the Group, which used as prefix of setting key.
	group_name = nil,
	--- @type table<string,string> stripped key names are used (without group-name prefixes).
	settings = nil,
}

--- @protected
--- @param from_settings table<string,string> table of all settings from which the settings of Group to load.
--- @return table<string,string>
function SettingsGroup:load(from_settings)
	--- @type table<string,string>
	local settings = {}
	local prefix = self.group_name .. '.'

	for key, value in pairs(from_settings) do
		if key:starts_with(prefix) then
			settings[key:replace('^' .. prefix, '')] = value
		end
	end

	return settings
end

--- If no `from_settings` table specified,
--- the all `minetest.settings:to_table()` is used to search & filter settings for the Group.
--- @overload fun(group_name:string)
--- @param group_name string
--- @param from_settings table<string,string> optional table of all settings from which the settings of Group to load.
--- @return Voxrame.SettingsGroup
function SettingsGroup:new(group_name, from_settings)
	self = setmetatable({}, { __index = self })
	from_settings = from_settings or minetest.settings:to_table()

	self.group_name = group_name
	self.settings   = self:load(from_settings)

	return self
end

--- @param subgroup_name string
--- @return Voxrame.SettingsGroup
function SettingsGroup:group(subgroup_name)
	return SettingsGroup:new(subgroup_name, self.settings)
end

--- Return all settings of the Group.
---
--- Stripped key names are used (without group-name prefixes).
---
--- @return table<string,string>
function SettingsGroup:all()
	return self.settings
end

--- @overload fun(name:string)
--- @param name    string name of the setting (key). Stripped key names are used (without group-name prefixes).
--- @param default any    default value, if setting not found. [optional]
--- @return string|nil returns `nil` if setting not found and `default` not specified.
function SettingsGroup:get(name, default)
	return self.settings[name] or default
end

--- @param name string name of the setting (key). Stripped key names are used (without group-name prefixes).
--- @return Position|nil
function SettingsGroup:get_position(name)
	return minetest.string_to_pos(self.settings[name])
end


return SettingsGroup
