local S = minetest.get_translator("lord_food")

-- As for now, this mod extremely small
-- So, it not follow mod structure convention

minetest.register_craftitem("lord_food:lembas", {
	description     = S("Lembas"),
	inventory_image = "lord_food_lembas.png",
	groups          = { food_bread = 1 },
	on_use          = minetest.item_eat(20),
	_tt_food        = true,
	_tt_food_hp     = 20,
})
