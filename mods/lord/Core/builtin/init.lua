
local mod_path = minetest.get_modpath(minetest.get_current_modname())
local require = function(name) return dofile(mod_path .. "/src/" .. name:gsub("%.", "/") .. ".lua") end

require("mapgen")

-- Translations (`./locale/__builtin.ru.tr`) need to be removed after it appears in MT (#1187).
