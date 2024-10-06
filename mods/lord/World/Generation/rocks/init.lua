minetest.register_biome({
	name = "stone_cave",
	node_stone = "default:stone",
	node_cave_liquid = "default:water_source",
	node_dungeon = "default:cobble",
    node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairs:stair_cobble",
	y_max = -32,
	y_min = -16000,
	vertical_blend = 8,
	heat_point = 50,
	humidity_point = 50,
})

minetest.register_biome({
	name = "stone_cave",
	node_stone = "default:stone",
	node_dungeon = "default:stonebrick",
	node_dungeon_stair = "stairs:stair_stonebrick",
	y_max = -16000,
	y_min = -31000,
	vertical_blend = 8,
	heat_point = 50,
	humidity_point = 50,
})


minetest.register_biome({
	name = "diorite_cave",
	node_stone = "lord_rocks:diorite",
	node_cave_liquid = "default:water_source",
	node_dungeon = "default:cobble",
    node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairs:stair_cobble",
	y_max = -7000,
	y_min = -10000,
	vertical_blend = 8,
	heat_point = 30,
	humidity_point = 80,
})

minetest.register_biome({
	name = "granite_cave",
	node_stone = "lord_rocks:granite",
	node_cave_liquid = "default:water_source",
	node_dungeon = "default:cobble",
    node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairs:stair_cobble",
	y_max = -4000,
	y_min = -8000,
	vertical_blend = 8,
	heat_point = 80,
	humidity_point = 30,
})

minetest.register_biome({
	name = "basalt_cave",
	node_stone = "lord_rocks:basalt",
	node_cave_liquid = "default:water_source",
	node_dungeon = "default:cobble",
    node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairs:stair_cobble",
	y_max = -1000,
	y_min = -4000,
	vertical_blend = 8,
	heat_point = 40,
	humidity_point = 70,
})

minetest.register_biome({
	name = "andesite_cave",
	node_stone = "lord_rocks:andesite",
	node_cave_liquid = "default:water_source",
	node_dungeon = "default:cobble",
    node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairs:stair_cobble",
	y_max = -3000,
	y_min = -10000,
	vertical_blend = 8,
	heat_point = 70,
	humidity_point = 40,
})

minetest.register_biome({
	name = "peridotite_cave",
	node_stone = "lord_rocks:peridotite",
	node_dungeon = "default:stonebrick",
	node_dungeon_stair = "stairs:stair_stonebrick",
	y_max = -8000,
	y_min = -31000,
	vertical_blend = 8,
	heat_point = 10,
	humidity_point = 90,
})

minetest.register_biome({
	name = "grey_tuff_cave",
	node_stone = "lord_rocks:grey_tuff",
	node_cave_liquid = "default:water_source",
	node_dungeon = "default:cobble",
    node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairs:stair_cobble",
	y_max = -32,
	y_min = -500,
	vertical_blend = 8,
	heat_point = 10,
	humidity_point = 90,
})

minetest.register_biome({
	name = "white_tuff_cave",
	node_stone = "lord_rocks:white_tuff",
	node_cave_liquid = "default:water_source",
	node_dungeon = "default:cobble",
	node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairs:stair_cobble",
	y_max = -500,
	y_min = -2500,
	vertical_blend = 8,
	heat_point = 10,
	humidity_point = 50,
})

minetest.register_biome({
	name = "red_tuff_cave",
	node_stone = "lord_rocks:red_tuff",
	node_cave_liquid = "default:water_source",
	node_dungeon = "default:cobble",
    node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairs:stair_cobble",
	y_max = -256,
	y_min = -1000,
	vertical_blend = 8,
	heat_point = 10,
	humidity_point = 10,
})

minetest.register_biome({
	name = "grey_quartzite_cave",
	node_stone = "lord_rocks:grey_quartzite",
	node_cave_liquid = "default:water_source",
	node_dungeon = "default:cobble",
    node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairs:stair_cobble",
	y_max = -4000,
	y_min = -8000,
	vertical_blend = 8,
	heat_point = 80,
	humidity_point = 20,
})

minetest.register_biome({
	name = "pink_quartzite_cave",
	node_stone = "lord_rocks:pink_quartzite",
	node_cave_liquid = "default:water_source",
	node_dungeon = "default:cobble",
    node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairs:stair_cobble",
	y_max = -7000,
	y_min = -11000,
	vertical_blend = 8,
	heat_point = 30,
	humidity_point = 20,
})

minetest.register_biome({
	name = "shale_cave",
	node_stone = "lord_rocks:shale",
	node_cave_liquid = "default:water_source",
	node_dungeon = "default:cobble",
    node_dungeon_alt = "default:mossycobble",
	node_dungeon_stair = "stairs:stair_cobble",
	y_max = -256,
	y_min = -4000,
	vertical_blend = 8,
	heat_point = 35,
	humidity_point = 60,
})

minetest.register_biome({
	name = "pyroxenite_cave",
	node_stone = "lord_rocks:pyroxenite",
	node_cave_liquid = "default:lava_source",
	node_dungeon = "default:stonebrick",
	node_dungeon_stair = "stairs:stair_stonebrick",
	y_max = -8000,
	y_min = -31000,
	vertical_blend = 8,
	heat_point = 90,
	humidity_point = 10,
})
