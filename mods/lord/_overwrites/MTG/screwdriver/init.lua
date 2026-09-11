-- screwdriver/init.lua
core.override_item('screwdriver:screwdriver', {
	_rank = item_rank.Type.RARE,
})
-- у нас свои отвертки в `lord/lord_screwdriver`
core.clear_craft({output = "screwdriver:screwdriver"})

core.register_craft({
	output = "screwdriver:screwdriver",
	recipe = {
		{"default:steel_ingot", ""},
		{"", "group:stick"}
	}
})
