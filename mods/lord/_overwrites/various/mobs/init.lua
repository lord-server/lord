
minetest.override_item("mobs:honey", {
	on_use      = minetest.item_eat(18),
	_tt_food_hp = 18,
})
