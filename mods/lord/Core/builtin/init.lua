local DS          = os.DIRECTORY_SEPARATOR
local mod_path    = minetest.get_modpath(minetest.get_current_modname())
local old_require = require
require           = function(name) return dofile(mod_path .. DS .. "src" .. DS .. name:gsub("%.", DS) .. ".lua") end


require("map.manipulations")
require("map.dungeons_gen")
require("globalstep")
require("mod")


require = old_require
