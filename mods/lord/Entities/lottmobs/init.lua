local mod_path    = minetest.get_modpath(minetest.get_current_modname())
local old_require = require
require           = function(name) return dofile(mod_path .. "/src/" .. name:gsub("%.", "/") .. ".lua") end


require("guarding")
require("craftitems")
require("racial")
require("animals")
require("eggs")
require("spawn")


require = old_require
