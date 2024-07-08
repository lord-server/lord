minetest.register_craft({
	output = 'technic:iron_chest 1',
	recipe = {
		{'default:steel_ingot','default:steel_ingot','default:steel_ingot'},
		{'default:steel_ingot','group:smallchest','default:steel_ingot'},
		{'default:steel_ingot','default:steel_ingot','default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'technic:iron_chest 1',
	recipe = {
		{'default:steel_ingot','default:steel_ingot','default:steel_ingot'},
		{'default:steel_ingot','default:chest','default:steel_ingot'},
		{'default:steel_ingot','default:steel_ingot','default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'technic:iron_locked_chest 1',
	recipe = {
		{'default:steel_ingot','default:steel_ingot','default:steel_ingot'},
		{'default:steel_ingot','default:chest_locked','default:steel_ingot'},
		{'default:steel_ingot','default:steel_ingot','default:steel_ingot'},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "technic:iron_locked_chest 1",
	recipe = {"technic:iron_chest", "default:steel_ingot"}
})

technic.chests:register("Iron", {
	width = 9,
	height = 5,
	sort = true,
	autosort = false,
	infotext = false,
	color = false,
	locked = false,
})

technic.chests:register("Iron", {
	width = 9,
	height = 5,
	sort = true,
	autosort = false,
	infotext = false,
	color = false,
	locked = true,
})

