dofile(minetest.get_modpath(minetest.get_current_modname()).."/".."money.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/".."shop.lua")

if minetest.settings:get_bool("msg_loading_mods") then
	minetest.log("action", minetest.get_current_modname().." mod LOADED")
end
