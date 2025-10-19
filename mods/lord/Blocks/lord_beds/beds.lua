local S = beds.get_translator

-- Fancy shaped bed

beds.register_bed("lord_beds:fancy_bed", {
	description = S("Fancy Bed"),
	inventory_image = "beds_fancy_bed_sheet.png^[sheet:11x1:0,0",
	wield_image = "beds_fancy_bed_sheet.png^[sheet:11x1:0,0",
	tiles = {
		bottom = {
			"beds_fancy_bed_sheet.png^[sheet:11x1:1,0",
			"beds_fancy_bed_sheet.png^[sheet:11x1:2,0",
			"beds_fancy_bed_sheet.png^[sheet:11x1:3,0",
			"beds_fancy_bed_sheet.png^[sheet:11x1:4,0",
			"beds_fancy_bed_sheet.png^[sheet:11x1:5,0",
			"beds_fancy_bed_sheet.png^[sheet:11x1:5,0",
		},
		top = {
			"beds_fancy_bed_sheet.png^[sheet:11x1:6,0",
			"beds_fancy_bed_sheet.png^[sheet:11x1:2,0",
			"beds_fancy_bed_sheet.png^[sheet:11x1:7,0",
			"beds_fancy_bed_sheet.png^[sheet:11x1:8,0",
			"beds_fancy_bed_sheet.png^[sheet:11x1:9,0",
			"beds_fancy_bed_sheet.png^[sheet:11x1:9,0",
		}
	},
	nodebox = {
		bottom = {
			{-0.5, -0.5, -0.5, -0.375, -0.065, -0.4375},
			{0.375, -0.5, -0.5, 0.5, -0.065, -0.4375},
			{-0.5, -0.375, -0.5, 0.5, -0.125, -0.4375},
			{-0.5, -0.375, -0.5, -0.4375, -0.125, 0.5},
			{0.4375, -0.375, -0.5, 0.5, -0.125, 0.5},
			{-0.4375, -0.3125, -0.4375, 0.4375, -0.0625, 0.5},
		},
		top = {
			{-0.5, -0.5, 0.4375, -0.375, 0.1875, 0.5},
			{0.375, -0.5, 0.4375, 0.5, 0.1875, 0.5},
			{-0.5, 0, 0.4375, 0.5, 0.125, 0.5},
			{-0.5, -0.375, 0.4375, 0.5, -0.125, 0.5},
			{-0.5, -0.375, -0.5, -0.4375, -0.125, 0.5},
			{0.4375, -0.375, -0.5, 0.5, -0.125, 0.5},
			{-0.4375, -0.3125, -0.5, 0.4375, -0.0625, 0.4375},
		}
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"", "", "group:stick"},
		{"wool:white", "wool:white", "wool:white"},
		{"group:wood", "group:wood", "group:wood"},
	},
})

-- Simple shaped bed

beds.register_bed("lord_beds:bed", {
	description = S("Simple Bed"),
	inventory_image = "beds_bed_sheet.png^[sheet:11x1:0,0",
	wield_image = "beds_bed_sheet.png^[sheet:11x1:0,0",
	tiles = {
		bottom = {
			"beds_bed_sheet.png^[sheet:11x1:1,0",
			"beds_bed_sheet.png^[sheet:11x1:2,0",
			"beds_bed_sheet.png^[sheet:11x1:3,0",
			"beds_bed_sheet.png^[sheet:11x1:4,0",
			"beds_bed_sheet.png^[sheet:11x1:10,0",
			"beds_bed_sheet.png^[sheet:11x1:5,0",
		},
		top = {
			"beds_bed_sheet.png^[sheet:11x1:6,0",
			"beds_bed_sheet.png^[sheet:11x1:2,0",
			"beds_bed_sheet.png^[sheet:11x1:7,0",
			"beds_bed_sheet.png^[sheet:11x1:8,0",
			"beds_bed_sheet.png^[sheet:11x1:9,0",
			"beds_bed_sheet.png^[sheet:11x1:10,0",
		}
	},
	nodebox = {
		bottom = {-0.5, -0.5, -0.5, 0.5, 0.0625, 0.5},
		top = {-0.5, -0.5, -0.5, 0.5, 0.0625, 0.5},
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.0625, 1.5},
	recipe = {
		{"wool:white", "wool:white", "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

-- Aliases for MT beds
minetest.register_alias("beds:fancy_bed", "lord_beds:fancy_bed")
minetest.register_alias("beds:fancy_bed_bottom", "lord_beds:fancy_bed_bottom")
minetest.register_alias("beds:fancy_bed_top", "lord_beds:fancy_bed_top")
minetest.register_alias("beds:bed", "lord_beds:bed")
minetest.register_alias("beds:bed_bottom", "lord_beds:bed_bottom")
minetest.register_alias("beds:bed_top", "lord_beds:bed_top")
-- Aliases for PilzAdam's beds mod
minetest.register_alias("beds:bed_bottom_red", "beds:bed_bottom")
minetest.register_alias("beds:bed_top_red", "beds:bed_top")

-- Fuel

minetest.register_craft({
	type = "fuel",
	recipe = "lord_beds:fancy_bed_bottom",
	burntime = 13,
})

minetest.register_craft({
	type = "fuel",
	recipe = "lord_beds:bed_bottom",
	burntime = 12,
})
