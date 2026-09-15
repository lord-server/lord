torches = {}
torches.enable_ceiling = core.settings:get_bool("torches_enable_ceiling") or false

local modpath = core.get_modpath("torches")

dofile(modpath.."/mt_style.lua")
