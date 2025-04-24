local SettingsGroup = require('SettingsGroup')

--- @class Voxrame.mod.Settings: Voxrame.SettingsGroup
local ModSettings = {}

--- @param mod_name string
--- @return Voxrame.mod.Settings
function ModSettings:new(mod_name) -- luacheck: ignore
	self = setmetatable({}, { __index = SettingsGroup })

	return self:new(mod_name or minetest.get_current_modname())
end


return ModSettings
