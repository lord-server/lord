torches = {}
torches.enable_ceiling = minetest.settings:get_bool("torches_enable_ceiling") or false

local modpath = minetest.get_modpath("torches")

dofile(modpath.."/mt_style.lua")

lord.mod_loaded()
