-- Mob Api

dofile(minetest.get_modpath("mobs").."/api.lua")
dofile(minetest.get_modpath("mobs").."/bee.lua")

if minetest.setting_getbool("msg_loading_mods") then minetest.log("action", minetest.get_current_modname().." mod LOADED") end
