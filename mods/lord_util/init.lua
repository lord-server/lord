util = {}

dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/kv.lua")

function util.require_intllib()
	if minetest.global_exists("intllib") then
		return intllib.Getter()
	else
		return function(q) return q end
	end
end

function util.mod_loaded()
	if minetest.setting_getbool("msg_loading_mods") then
		minetest.log("action", minetest.get_current_modname().." mod loaded")
	end
end
