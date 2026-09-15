local S = core.get_mod_translator()

core.register_tool("lottclothes:cloak_ranger", {
    description = S("Ranger's Cloak"),
    inventory_image = "lottclothes_inv_cloak_ranger.png",
    groups = {clothes=1, no_preview = 1, clothes_cloak=1},
    wear = 0
})

core.register_craft({
	output = 'lottclothes:flaxthread 2',
	recipe = {
		{'lottclothes:cloak_ranger'},
	}
})

core.register_tool("lottclothes:cloak_mordor", {
    description = S("Mordor Cloak"),
    inventory_image = "lottclothes_inv_cloak_mordor.png",
    groups = {clothes=1, no_preview = 1, clothes_cloak=1},
    wear = 0
})

core.register_craft({
	output = 'lottclothes:flaxthread 2',
	recipe = {
		{'lottclothes:cloak_mordor'},
	}
})
