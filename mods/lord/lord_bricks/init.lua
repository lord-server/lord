local S = minetest.get_translator(minetest.get_current_modname())

dofile(minetest.get_modpath(minetest.get_current_modname()).."/crafts.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/nodes.lua")

-- Raw Brick for default clay

minetest.register_craftitem("lord_bricks:clay_brick_raw", {
	description = S("Raw Clay Brick"),
	inventory_image = "lord_bricks_clay_brick_raw.png"
})

-- Chamotte Brick
minetest.register_craftitem("lord_bricks:chamotte_brick_raw", {
	description = S("Raw Chamotte Brick"),
	inventory_image = "lord_bricks_chamotte_brick_raw.png"
})

minetest.register_craftitem("lord_bricks:chamotte_brick_dried", {
	description = S("Dried Chamotte Brick"),
	inventory_image = "lord_bricks_chamotte_brick_dried.png"
})

-- Mordor Clay Brick
minetest.register_craftitem("lord_bricks:mordor_clay_brick_raw", {
	description = S("Raw Mordor Clay Brick"),
	inventory_image = "lord_bricks_mordor_clay_brick_raw.png"
})

minetest.register_craftitem("lord_bricks:mordor_clay_brick_dried", {
	description = S("Dried Mordor Clay Brick"),
	inventory_image = "lord_bricks_mordor_clay_brick_dried.png"
})
