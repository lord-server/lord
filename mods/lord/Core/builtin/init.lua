
local mod_path = minetest.get_modpath(minetest.get_current_modname())
local require = function(name) return dofile(mod_path .. "/src/" .. name:gsub("%.", "/") .. ".lua") end

require("map.manipulations")
require("map.dungeons_gen")
