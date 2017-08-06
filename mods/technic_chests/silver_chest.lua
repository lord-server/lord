minetest.register_craft({
	output = 'technic:silver_chest',
	recipe = {
		{'lottores:silver_ingot','lottores:silver_ingot','lottores:silver_ingot'},
		{'lottores:silver_ingot','technic:copper_chest','lottores:silver_ingot'},
		{'lottores:silver_ingot','lottores:silver_ingot','lottores:silver_ingot'},
	}
})

minetest.register_craft({
	output = 'technic:silver_locked_chest',
	recipe = {
		{'lottores:silver_ingot','lottores:silver_ingot','lottores:silver_ingot'},
		{'lottores:silver_ingot','technic:copper_locked_chest','lottores:silver_ingot'},
		{'lottores:silver_ingot','lottores:silver_ingot','lottores:silver_ingot'},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "technic:silver_locked_chest",
	recipe = {"technic:silver_chest", "default:steel_ingot"}
})

technic.chests:register("Silver", {
	width = 12,
	height = 6,
	sort = true,
	autosort = true,
	infotext = true,
	color = false,
	locked = false,
})

technic.chests:register("Silver", {
	width = 12,
	height = 6,
	sort = true,
	autosort = true,
	infotext = true,
	color = false,
	locked = true,
})

