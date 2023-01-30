-- lord_screwdriver/init.lua

-- Load support for MT game translation.
local S = minetest.get_translator("lord_screwdriver")

-- Galvorn Screwdriver
minetest.register_tool(":screwdriver:screwdriver_galvorn", {
	description = S("Galvorn Screwdriver") .. "\n" .. S("(left-click rotates face, right-click rotates axis)"),
	inventory_image = "screwdriver_galvorn.png",
	groups = {tool = 1, galvorn_item = 1},
	on_use = function(itemstack, user, pointed_thing)
		screwdriver.handler(itemstack, user, pointed_thing, screwdriver.ROTATE_FACE, 2000)
		return itemstack
	end,
	on_place = function(itemstack, user, pointed_thing)
		screwdriver.handler(itemstack, user, pointed_thing, screwdriver.ROTATE_AXIS, 2000)
		return itemstack
	end,
})

minetest.register_craft({
	output = "screwdriver:screwdriver_galvorn",
	recipe = {
		{"lottores:galvorn_ingot", ""},
		{"", "group:stick"}
	}
})
