local S = minetest.get_translator("clans_clothes")

minetest.register_tool("clans_clothes:mason_cloak", {
	description = S("Mason Clan Cloak"),
	inventory_image = "clans_clothes_inv_mason_cloak.png",
	groups = {armor_heal=0, clothes=1, no_preview = 1, clothes_cloak=1},
	wear = 0
})

minetest.register_tool("clans_clothes:vassal_cloak", {
	description = S("Vassal Clan Cloak"),
	inventory_image = "clans_clothes_inv_vassal_cloak.png",
	groups = {armor_heal=0, clothes=1, no_preview = 1, clothes_cloak=1},
	wear = 0
})
