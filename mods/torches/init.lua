torches = {}
torches.enable_ceiling = minetest.setting_getbool("torches_enable_ceiling") or false

local modpath = minetest.get_modpath("torches")

dofile(modpath.."/mt_style.lua")

if minetest.setting_getbool("msg_loading_mods") then minetest.log("action", minetest.get_current_modname().." mod LOADED") end