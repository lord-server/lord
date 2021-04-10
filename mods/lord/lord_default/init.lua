
local S = minetest.get_translator("lord_default")

minetest.register_craftitem(":default:scorched_stuff", {
	description = S("Scorched Stuff"),
	inventory_image = "default_scorched_stuff.png",
})

-- Charcoal / Древесный уголь
minetest.register_craftitem(":default:charcoal_lump", {
	description = S("Charcoal Lump"),
	inventory_image = "charcoal_lump.png",
	groups = {coal = 1},
})
