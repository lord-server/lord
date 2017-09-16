lord = {}

dofile(minetest.get_modpath(minetest.get_current_modname()) .. "/kv.lua")

function lord.require_intllib()
	if minetest.global_exists("intllib") then
		return intllib.Getter()
	else
		return function(q) return q end
	end
end

function lord.mod_loaded()
	if minetest.settings:get_bool("msg_loading_mods") then
		minetest.log("action", minetest.get_current_modname() .. " mod loaded")
	end
end
