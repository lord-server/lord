local SL = minetest.get_translator("lord_doors")

doors.register_door("lord_doors:door_gondor", {
	tiles = {{ name = "lord_doors_gondor.png", backface_culling = true }},
	description =  SL("Gondor Door"),
	inventory_image = "lord_doors_item_gondor.png",
	groups = { snappy=1, bendy=2, cracky=1, melty=2, level=2, door=1, steel_item=1, },
})
