-- screwdriver/init.lua
local S = core.get_translator('screwdriver')


core.override_item('screwdriver:screwdriver', {
	description = S('Screwdriver'),
	_tt_help    = S('(left-click rotates face, right-click rotates axis)'),
	_rank       = item_rank.Type.RARE,
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
