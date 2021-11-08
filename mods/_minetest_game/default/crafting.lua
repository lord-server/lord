-- mods/default/crafting.lua

minetest.register_craft({
	output = "default:wood 4",
	recipe = {
		{"default:tree"},
	}
})

minetest.register_craft({
	output = "default:junglewood 4",
	recipe = {
		{"default:jungletree"},
	}
})

minetest.register_craft({
	output = "default:pine_wood 4",
	recipe = {
		{"default:pine_tree"},
	}
})

minetest.register_craft({
	output = "default:acacia_wood 4",
	recipe = {
		{"default:acacia_tree"},
	}
})

minetest.register_craft({
	output = "default:aspen_wood 4",
	recipe = {
		{"default:aspen_tree"},
	}
})

minetest.register_craft({
	output = "default:wood",
	recipe = {
		{"default:bush_stem"},
	}
})

minetest.register_craft({
	output = "default:acacia_wood",
	recipe = {
		{"default:acacia_bush_stem"},
	}
})

minetest.register_craft({
	output = "default:pine_wood",
	recipe = {
		{"default:pine_bush_stem"},
	}
})

minetest.register_craft({
	output = "default:sign_wall_steel 3",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "default:sign_wall_wood 3",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "default:coalblock",
	recipe = {
		{"default:coal_lump", "default:coal_lump", "default:coal_lump"},
		{"default:coal_lump", "default:coal_lump", "default:coal_lump"},
		{"default:coal_lump", "default:coal_lump", "default:coal_lump"},
	}
})

minetest.register_craft({
	output = "default:steelblock",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "default:copperblock",
	recipe = {
		{"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
		{"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
		{"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
	}
})

minetest.register_craft({
	output = "default:tinblock",
	recipe = {
		{"default:tin_ingot", "default:tin_ingot", "default:tin_ingot"},
		{"default:tin_ingot", "default:tin_ingot", "default:tin_ingot"},
		{"default:tin_ingot", "default:tin_ingot", "default:tin_ingot"},
	}
})

minetest.register_craft({
	output = "default:bronzeblock",
	recipe = {
		{"default:bronze_ingot", "default:bronze_ingot", "default:bronze_ingot"},
		{"default:bronze_ingot", "default:bronze_ingot", "default:bronze_ingot"},
		{"default:bronze_ingot", "default:bronze_ingot", "default:bronze_ingot"},
	}
})

minetest.register_craft({
	output = "default:bronze_ingot 9",
	recipe = {
		{"default:bronzeblock"},
	}
})

minetest.register_craft({
	output = "default:goldblock",
	recipe = {
		{"default:gold_ingot", "default:gold_ingot", "default:gold_ingot"},
		{"default:gold_ingot", "default:gold_ingot", "default:gold_ingot"},
		{"default:gold_ingot", "default:gold_ingot", "default:gold_ingot"},
	}
})

minetest.register_craft({
	output = "default:diamondblock",
	recipe = {
		{"default:diamond", "default:diamond", "default:diamond"},
		{"default:diamond", "default:diamond", "default:diamond"},
		{"default:diamond", "default:diamond", "default:diamond"},
	}
})

------------------------------------------------------------------------------------
minetest.register_craft({
	output = "default:sandstone",
	recipe = {
		{"group:sand", "group:sand"},
		{"group:sand", "group:sand"},
	}
})

minetest.register_craft({
	output = "default:sand 4",
	recipe = {
		{"default:sandstone"},
	}
})

minetest.register_craft({
	output = "default:sandstonebrick 4",
	recipe = {
		{"default:sandstone", "default:sandstone"},
		{"default:sandstone", "default:sandstone"},
	}
})

minetest.register_craft({
	output = "default:clay",
	recipe = {
		{"default:clay_lump", "default:clay_lump"},
		{"default:clay_lump", "default:clay_lump"},
	}
})

minetest.register_craft({
	output = "default:brick",
	recipe = {
		{"default:clay_brick", "default:clay_brick"},
		{"default:clay_brick", "default:clay_brick"},
	}
})

minetest.register_craft({
	output = "default:bookshelf",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"default:book", "default:book", "default:book"},
		{"group:wood", "group:wood", "group:wood"},
	}
})

minetest.register_craft({
	output = "default:ladder 7",
	recipe = {
		{"default:stick", "", "default:stick"},
		{"default:stick", "default:stick", "default:stick"},
		{"default:stick", "", "default:stick"},
	}
})

minetest.register_craft({
	output = "default:mese",
	recipe = {
		{"default:mese_crystal", "default:mese_crystal", "default:mese_crystal"},
		{"default:mese_crystal", "default:mese_crystal", "default:mese_crystal"},
		{"default:mese_crystal", "default:mese_crystal", "default:mese_crystal"},
	}
})

minetest.register_craft({
	output = "default:obsidian",
	recipe = {
		{"default:obsidian_shard", "default:obsidian_shard", "default:obsidian_shard"},
		{"default:obsidian_shard", "default:obsidian_shard", "default:obsidian_shard"},
		{"default:obsidian_shard", "default:obsidian_shard", "default:obsidian_shard"},
	}
})

minetest.register_craft({
	output = "default:stonebrick 4",
	recipe = {
		{"default:stone", "default:stone"},
		{"default:stone", "default:stone"},
	}
})

minetest.register_craft({
	output = "default:desert_stonebrick 4",
	recipe = {
		{"default:desert_stone", "default:desert_stone"},
		{"default:desert_stone", "default:desert_stone"},
	}
})

minetest.register_craft({
	output = "default:snowblock",
	recipe = {
		{"default:snow", "default:snow", "default:snow"},
		{"default:snow", "default:snow", "default:snow"},
		{"default:snow", "default:snow", "default:snow"},
	}
})

minetest.register_craft({
	output = "default:snow 9",
	recipe = {
		{"default:snowblock"},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "default:dirt",
	recipe = {"group:leaves", "group:leaves", "default:clay", "default:sand"},
})


--
-- Crafting (tool repair)
--

minetest.register_craft({
	type = "toolrepair",
	additional_wear = -0.02,
})


--
-- Cooking recipes
--

minetest.register_craft({
	type = "cooking",
	output = "default:glass",
	recipe = "group:sand",
})

minetest.register_craft({
	type = "cooking",
	output = "default:obsidian_glass",
	recipe = "default:obsidian_shard",
})

minetest.register_craft({
	type = "cooking",
	output = "default:stone",
	recipe = "default:cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "default:desert_stone",
	recipe = "default:desert_cobble",
})

minetest.register_craft({
	type = "cooking",
	output = "default:cobble",
	recipe = "default:gravel",
})

minetest.register_craft({
	type = "cooking",
	output = "default:steel_ingot",
	recipe = "group:steel_item",
})

minetest.register_craft({
	type = "cooking",
	output = "default:copper_ingot",
	recipe = "group:copper_item",
})

minetest.register_craft({
	type = "cooking",
	output = "default:bronze_ingot",
	recipe = "group:bronze_item",
})

minetest.register_craft({
	type = "cooking",
	output = "default:gold_ingot",
	recipe = "group:gold_item",
})


--
-- Fuels
--

minetest.register_craft({
	type = "fuel",
	recipe = "group:paper",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:grass",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:leaves",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:sapling",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:wool",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:wooden",
	burntime = 5,
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:wood",
	burntime = 10,
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:tree",
	burntime = 15,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:coalblock",
	burntime = 370,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:lava_source",
	burntime = 60,
})

