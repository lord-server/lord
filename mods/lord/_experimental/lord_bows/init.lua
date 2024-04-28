local mod_path    = minetest.get_modpath(minetest.get_current_modname())
local old_require = require
require           = function(name) return dofile(mod_path .. "/src/" .. name:gsub("%.", "/") .. ".lua") end


GRAVITY = minetest.settings:get("movement_gravity") or 9.81

require("lord_bows").init()


require = old_require
