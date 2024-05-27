local S = minetest.get_translator(minetest.get_current_modname())

dofile(minetest.get_modpath(minetest.get_current_modname()).."/crafts.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/chamotte_bricks.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/mordor_bricks.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/rock_bricks.lua")


-- Raw Brick for default clay

minetest.register_craftitem("lord_bricks:clay_brick_raw", {
	description = S("Raw Clay Brick"),
	inventory_image = "lord_bricks_clay_brick_raw.png"
})

