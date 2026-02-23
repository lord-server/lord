
minetest.override_item("bees:honey", {
	on_use      = minetest.item_eat(18),
	_tt_food_hp = 18,
})
