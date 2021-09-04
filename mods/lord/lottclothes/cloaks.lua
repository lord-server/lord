local SL = lord.require_intllib()

minetest.register_tool("lottclothes:cloak_ranger", {
    description = SL("Ranger's Cloak"),
    inventory_image = "lottclothes_inv_cloak_ranger.png",
    groups = {armor_heal=0, clothes=1, no_preview = 1, clothes_cloak=1},
    wear = 0
})

minetest.register_craft({
	output = 'lottclothes:flaxthread 2',
	recipe = {
		{'lottclothes:cloak_ranger'},
	}
})

minetest.register_tool("lottclothes:cloak_mordor", {
    description = SL("Mordor Cloak"),
    inventory_image = "lottclothes_inv_cloak_mordor.png",
    groups = {armor_heal=0, clothes=1, no_preview = 1, clothes_cloak=1},
    wear = 0
})

minetest.register_craft({
	output = 'lottclothes:flaxthread 2',
	recipe = {
		{'lottclothes:cloak_mordor'},
	}
})
