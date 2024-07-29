minetest.register_alias("farming:sheaf_wheat","farming:wheat")
minetest.register_alias("farming:wheat0","farming:seed_wheat")


minetest.override_item("farming:cotton_wild", {drop = {
	max_items = 1,
	items = {
		{items = {"farming:cotton_wild"}, rarity = 8},
		{items = {"farming:seed_cotton"}},
	}
}})


-- Clear hoes tools
minetest.unregister_item("farming:hoe_mese")
minetest.unregister_item("farming:hoe_diamond")


-- Add food points description:
minetest.override_item("farming:bread", {
	on_use      = minetest.item_eat(9),
	_tt_food    = true,
	_tt_food_hp = 9,
})
