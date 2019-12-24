-- carts/init.lua

-- Load support for MT game translation.
local SL = lord.require_intllib()

carts = {}
carts.modpath = minetest.get_modpath("carts")
carts.railparams = {}
carts.get_translator = SL

-- Maximal speed of the cart in m/s (min = -1)
carts.speed_max = 7
-- Set to -1 to disable punching the cart from inside (min = -1)
carts.punch_speed_max = 3
-- Maximal distance for the path correction (for dtime peaks)
carts.path_distance_max = 3


dofile(carts.modpath.."/functions.lua")
dofile(carts.modpath.."/functions_new.lua")
dofile(carts.modpath.."/crafting.lua")
dofile(carts.modpath.."/cart_entity.lua")
dofile(carts.modpath.."/rails.lua")



