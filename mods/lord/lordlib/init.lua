lord = {}

function lord.load(file)
	local path = minetest.get_modpath(minetest.get_current_modname())
	return dofile(path .. '/' .. file)
end

lord.load("signals.lua")

function lord.require_intllib()
	if minetest.global_exists("intllib") then
		return intllib.make_gettext_pair()
	else
		return function(q) return q end
	end
end

function lord.mod_loaded()
	if minetest.settings:get_bool("msg_loading_mods") then
		minetest.log("action", minetest.get_current_modname() .. " mod loaded in " .. os.clock() .. ' s.')
	end
end
