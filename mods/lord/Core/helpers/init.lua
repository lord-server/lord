local mod_path    = minetest.get_modpath(minetest.get_current_modname())
local old_require = require
require           = function(name) return dofile(mod_path .. "/src/" .. name:gsub("%.", "/") .. ".lua") end


require("lua_ext")


require = old_require

--- @param list table
--- @param values table
function table_keys_has_one_of_values(list, values)
	for key in pairs(list) do
		if table.has_value(values, key) then
			return true
		end
	end
	return false
end
