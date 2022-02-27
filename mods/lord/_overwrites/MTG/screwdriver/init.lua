-- screwdriver/init.lua

-- у нас свои отвертки в `lord/lord_screwdriver`
minetest.clear_craft({output = "screwdriver:screwdriver"})

minetest.register_craft({
	output = "screwdriver:screwdriver",
	recipe = {
		{"default:steel_ingot", ""},
		{"", "group:stick"}
	}
})
