local SL = lord.require_intllib()

beds = {}
beds.player = {}
beds.pos = {}
beds.spawn = {}

beds.formspec = "size[8,15;true]"..
		"bgcolor[#080808BB; true]"..
		"button_exit[2,12;4,0.75;leave;"..SL("Leave Bed").."]"

local modpath = minetest.get_modpath("beds")

-- load files
dofile(modpath.."/functions.lua")
dofile(modpath.."/api.lua")
dofile(modpath.."/beds.lua")
dofile(modpath.."/spawns.lua")

if minetest.settings:get_bool("msg_loading_mods") then minetest.log("action", minetest.get_current_modname().." mod LOADED") end
