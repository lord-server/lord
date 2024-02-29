local mod_path    = minetest.get_modpath(minetest.get_current_modname())
local old_require = require
require           = function(name) return dofile(mod_path .. "/src/" .. name:gsub("%.", "/") .. ".lua") end


require("trees")
require("wild_crops")
require("flowers")
require("herbs")
require("nodes")
--- @type lottplants.Planks_API
_G.planks = require('planks')


require = old_require
