minetest.register_craft({
	output = 'technic:mithril_chest 1',
	recipe = {
		{'lottores:mithril_ingot','lottores:mithril_ingot','lottores:mithril_ingot'},
		{'lottores:mithril_ingot','technic:gold_chest','lottores:mithril_ingot'},
		{'lottores:mithril_ingot','lottores:mithril_ingot','lottores:mithril_ingot'},
	}
})

minetest.register_craft({
	output = 'technic:mithril_locked_chest 1',
	recipe = {
		{'lottores:mithril_ingot','lottores:mithril_ingot','lottores:mithril_ingot'},
		{'lottores:mithril_ingot','technic:gold_locked_chest','lottores:mithril_ingot'},
		{'lottores:mithril_ingot','lottores:mithril_ingot','lottores:mithril_ingot'},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "technic:mithril_locked_chest 1",
	recipe = {"technic:mithril_chest", "default:steel_ingot"}
})

technic.chests:register("Mithril", {
	width = 15,
	height = 6,
	sort = true,
	autosort = true,
	infotext = false,
	color = false,
	locked = false,
})

technic.chests:register("Mithril", {
	width = 15,
	height = 6,
	sort = true,
	autosort = true,
	infotext = false,
	color = false,
	locked = true,
})

