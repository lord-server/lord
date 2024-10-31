minetest.mod(function(mod)
	local S = minetest.get_mod_translator()


	minetest.register_craftitem(":bucket:bucket_ice", {
		description     = S("Ice Bucket"),
		inventory_image = "bucket_ice.png",
		stack_max       = 1,
	})

	minetest.register_craft({
		output = 'bucket:bucket_ice 1',
		recipe = { { 'bucket:bucket_empty', 'default:ice' } }
	})

	minetest.register_craft({
		output = "bucket:bucket_water",
		type   = "cooking",
		recipe = "bucket:bucket_ice",
	})

	minetest.register_craftitem(":bucket:bucket_snow", {
		description     = S("Snow Bucket"),
		inventory_image = "bucket_snow.png",
		stack_max       = 1,
	})

	minetest.register_craft({
		output = 'bucket:bucket_snow 1',
		recipe = { { 'bucket:bucket_empty', 'default:snowblock' } }
	})

	minetest.register_craft({
		output = "bucket:bucket_water",
		type   = "cooking",
		recipe = "bucket:bucket_snow",
	})

	minetest.register_craftitem(":bucket:bucket_salt", {
		description     = S("Salt Bucket"),
		inventory_image = "bucket_salt.png",
	})

	minetest.register_craft({
		type     = "cooking",
		output   = "bucket:bucket_salt",
		recipe   = "bucket:bucket_water",
		cooktime = 10,
	})

	minetest.register_craft({
		output       = "lottores:salt",
		recipe       = { { "bucket:bucket_salt" } },
		replacements = {
			{ "bucket:bucket_salt", "bucket:bucket_empty" },
		},
	})
end)

