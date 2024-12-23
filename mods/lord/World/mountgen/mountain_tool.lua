local S = minetest.get_mod_translator()

mountgen.config = {
	ANGLE = 120,
	Y0 = 0,
	METHOD = "diamond-square",
	SNOW_LINE = 50,
	SNOW_LINE_RAND = 4,
	GRASS_PERCENT = 10,
	FLOWERS_LINE = 35,
	FLOWERS_PERCENT = 10,
	TREE_LINE = 20,
	TREE_PROMILLE = 4,

	rk_big = 5,
	rk_small = 100,
	rk_thr = 5,

	top_cover = "lottmapgen:dunland_grass",
}

minetest.register_tool("mountgen:mount_tool", {
	description = S("Mountain tool"),
	inventory_image = "ghost_tool.png",
	on_use = function(itemstack, placer, pointed_thing)
		local pos = placer:get_pos()
        minetest.set_node(pos, {name = "mountgen:mountain_spawner"})
	end,
	group = {},
	on_drop = function(itemstack, dropper, pos)
		return
	end,
})
