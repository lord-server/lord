local SL = lord.require_intllib()
-- mods/default/craftitems.lua

minetest.register_craftitem("default:stick", {
	description = SL("Stick"),
	inventory_image = "default_stick.png",
	groups = {stick=1},
})

minetest.register_craftitem("default:paper", {
	description = SL("Paper"),
	inventory_image = "default_paper.png",
	groups = {book=1, paper=1},
})

minetest.register_craftitem("default:book", {
	description = SL("Book"),
	inventory_image = "default_book.png",
	groups = {book=1, paper=1},
})

minetest.register_craftitem("default:coal_lump", {
	description = SL("Coal Lump"),
	inventory_image = "default_coal_lump.png",
})

minetest.register_craftitem("default:charcoal_lump", {
	description = SL("Charcoal Lump"),
	inventory_image = "charcoal_lump.png",
})

minetest.register_craftitem("default:iron_lump", {
	description = SL("Iron Lump"),
	inventory_image = "default_iron_lump.png",
})

minetest.register_craftitem("default:copper_lump", {
	description = SL("Copper Lump"),
	inventory_image = "default_copper_lump.png",
})

minetest.register_craftitem("default:mese_crystal", {
	description = SL("Mese Crystal"),
	inventory_image = "default_mese_crystal.png",
})

minetest.register_craftitem("default:gold_lump", {
	description = SL("Gold Lump"),
	inventory_image = "default_gold_lump.png",
})

minetest.register_craftitem("default:diamond", {
	description = SL("Diamond"),
	inventory_image = "default_diamond.png",
})

minetest.register_craftitem("default:clay_lump", {
	description = SL("Clay Lump"),
	inventory_image = "default_clay_lump.png",
})

minetest.register_craftitem("default:steel_ingot", {
	description = SL("Steel Ingot"),
	inventory_image = "default_steel_ingot.png",
})

minetest.register_craftitem("default:copper_ingot", {
	description = SL("Copper Ingot"),
	inventory_image = "default_copper_ingot.png",
})

minetest.register_craftitem("default:bronze_ingot", {
	description = SL("Bronze Ingot"),
	inventory_image = "default_bronze_ingot.png",
})

minetest.register_craftitem("default:gold_ingot", {
	description = SL("Gold Ingot"),
	inventory_image = "default_gold_ingot.png"
})

minetest.register_craftitem("default:mese_crystal_fragment", {
	description = SL("Mese Crystal Fragment"),
	inventory_image = "default_mese_crystal_fragment.png",
})

minetest.register_craftitem("default:clay_brick", {
	description = SL("Clay Brick"),
	inventory_image = "default_clay_brick.png",
})

minetest.register_craftitem("default:scorched_stuff", {
	description = SL("Scorched Stuff"),
	inventory_image = "default_scorched_stuff.png",
})

minetest.register_craftitem("default:obsidian_shard", {
	description = SL("Obsidian Shard"),
	inventory_image = "default_obsidian_shard.png",
})
