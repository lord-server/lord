-- Блоки, которые нельзя заменять
replacer.blacklist["lottores:tilkal"] = true
replacer.blacklist["stairs:slab_tilkal"] = true
replacer.blacklist["stairs:stair_tilkal"] = true
replacer.blacklist["stairs:stair_inner_tilkal"] = true
replacer.blacklist["stairs:stair_outer_tilkal"] = true
replacer.blacklist["lottblocks:palantir"] = true

-- Надо вырезать крафты
minetest.clear_craft({output = "replacer:inspect"})
minetest.clear_craft({output = "replacer:replacer"})

-- B добавить для реплейсера новый
minetest.register_craft({
	output = "replacer:replacer",
	recipe = {
		{ "default:steel_ingot", "default:stick"},
	}
})
