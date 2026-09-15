core.register_alias("farming:sheaf_wheat","farming:wheat")
core.register_alias("farming:wheat0","farming:seed_wheat")


core.override_item("farming:cotton_wild", {drop = {
	max_items = 1,
	items = {
		{items = {"farming:cotton_wild"}, rarity = 8},
		{items = {"farming:seed_cotton"}},
	}
}})


-- Clear hoes tools
core.unregister_item("farming:hoe_mese")
core.unregister_item("farming:hoe_diamond")


-- Add food points description:
core.override_item("farming:bread", {
	on_use      = core.item_eat(12),
	_tt_food_hp = 12,
})
-- craft from dough:
core.clear_craft({ type = "cooking", output = "farming:bread" })
core.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "farming:bread",
	recipe = "lottfarming:dough"
})
