mountgen = {
    required_priv = "server"
}

dofile(minetest.get_modpath("mountgen").."/algorithms/height_map.lua")
dofile(minetest.get_modpath("mountgen").."/algorithms/cone.lua")
dofile(minetest.get_modpath("mountgen").."/algorithms/diamond_square.lua")
dofile(minetest.get_modpath("mountgen").."/mountgen.lua")
dofile(minetest.get_modpath("mountgen").."/map.lua")
dofile(minetest.get_modpath("mountgen").."/mountain_spawner.lua")
dofile(minetest.get_modpath("mountgen").."/mountain_tool.lua")
