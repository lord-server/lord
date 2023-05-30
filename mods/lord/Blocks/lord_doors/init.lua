local SL = minetest.get_translator("lord_doors")

doors.register("lord_doors:door_gondor", {
	tiles = {{ name = "lord_doors_gondor.png", backface_culling = true }},
	description =  SL("Gondor Door"),
	inventory_image = "lord_doors_item_gondor.png",
	groups = { snappy=1, bendy=2, cracky=1, melty=2, level=2, door=1, steel_item=1, },
})


-- Двери вынесены из MTG, так как в обновлении 5.4.1 удалены некоторые из них или заменены их названия.
dofile(minetest.get_modpath("lord_doors").."/mtg.lua")

-- Двери, открывающиеся только конкретной расой или отмычкой.
dofile(minetest.get_modpath("lord_doors").."/race_doors.lua")
