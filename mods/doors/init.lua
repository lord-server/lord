dofile(minetest.get_modpath(minetest.get_current_modname()).."/".."api.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/".."doors.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/".."trapdoors.lua")

if minetest.settings:get_bool("msg_loading_mods") then
	minetest.log("action", minetest.get_current_modname().." mod LOADED")
end
