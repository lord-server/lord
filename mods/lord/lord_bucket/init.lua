local S = minetest.get_translator("lord_bucket")

minetest.register_craftitem(":bucket:bucket_ice", {
	description = S("Ice Bucket"),
	inventory_image = "bucket_ice.png",
	stack_max = 1,
})

minetest.register_craft({output = 'bucket:bucket_ice 1',
	recipe = {{'bucket:bucket_empty', 'default:ice'}}
})

minetest.register_craft({output = "bucket:bucket_water",
	type = "cooking",
	recipe = "bucket:bucket_ice",
})

minetest.register_craftitem(":bucket:bucket_snow", {
	description = S("Snow Bucket"),
	inventory_image = "bucket_snow.png",
	stack_max = 1,
})

minetest.register_craft({output = 'bucket:bucket_snow 1',
	recipe = {{'bucket:bucket_empty', 'default:snowblock'}}
})

minetest.register_craft({output = "bucket:bucket_water",
	type = "cooking",
	recipe = "bucket:bucket_snow",
})
