local S = beds.get_translator

local dyes = dye.dyes
for i = 1, #dyes do
	local color, desc = unpack(dyes[i])
	-- Fancy Bed
	node_name            = ('lord_beds:fancy_bed_'..color)
	node_texture         = 'beds_fancy_bed_'..color..'_sheet.png'
	beds.register_bed(node_name, {
		description = S('Fancy Bed '..desc),
		inventory_image = node_texture..'^[sheet:11x1:0,0',
		wield_image = node_texture..'^[sheet:11x1:0,0',
		tiles = {
			bottom = {
				node_texture..'^[sheet:11x1:1,0',
				node_texture..'^[sheet:11x1:2,0',
				node_texture..'^[sheet:11x1:3,0',
				node_texture..'^[sheet:11x1:4,0',
				node_texture..'^[sheet:11x1:5,0',
				node_texture..'^[sheet:11x1:5,0',
			},
			top = {
				node_texture..'^[sheet:11x1:6,0',
				node_texture..'^[sheet:11x1:2,0',
				node_texture..'^[sheet:11x1:7,0',
				node_texture..'^[sheet:11x1:8,0',
				node_texture..'^[sheet:11x1:9,0',
				node_texture..'^[sheet:11x1:9,0',
			}
		},
		nodebox = {
			bottom       = {
				{-0.5, -0.5, -0.5, -0.375, -0.065, -0.4375},
				{0.375, -0.5, -0.5, 0.5, -0.065, -0.4375},
				{-0.5, -0.375, -0.5, 0.5, -0.125, -0.4375},
				{-0.5, -0.375, -0.5, -0.4375, -0.125, 0.5},
				{0.4375, -0.375, -0.5, 0.5, -0.125, 0.5},
				{-0.4375, -0.3125, -0.4375, 0.4375, -0.0625, 0.5},
			},
			top          = {
				{-0.5, -0.5, 0.4375, -0.375, 0.1875, 0.5},
				{0.375, -0.5, 0.4375, 0.5, 0.1875, 0.5},
				{-0.5, 0, 0.4375, 0.5, 0.125, 0.5},
				{-0.5, -0.375, 0.4375, 0.5, -0.125, 0.5},
				{-0.5, -0.375, -0.5, -0.4375, -0.125, 0.5},
				{0.4375, -0.375, -0.5, 0.5, -0.125, 0.5},
				{-0.4375, -0.3125, -0.5, 0.4375, -0.0625, 0.4375},
			},
		},
		selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
		recipe = {
			{'', '', 'group:stick'},
			{'wool:'..color, 'wool:'..color, "wool:white"},
			{"group:wood", "group:wood", "group:wood"},
		},
	})
	minetest.register_craft({
		type = 'fuel',
		recipe = node_name..'_bottom',
		burntime = 13,
	})

	-- Simple Bed
	node_name            = ('lord_beds:bed_'..color)
	node_texture         = 'beds_bed_'..color..'_sheet.png'
	beds.register_bed(node_name, {
		description = S('Bed '..desc),
		inventory_image = node_texture..'^[sheet:11x1:0,0',
		wield_image = node_texture..'^[sheet:11x1:0,0',
		tiles = {
			bottom = {
				node_texture..'^[sheet:11x1:1,0',
				node_texture..'^[sheet:11x1:2,0',
				node_texture..'^[sheet:11x1:3,0',
				node_texture..'^[sheet:11x1:4,0',
				node_texture..'^[sheet:11x1:5,0',
				node_texture..'^[sheet:11x1:5,0',
			},
			top = {
				node_texture..'^[sheet:11x1:6,0',
				node_texture..'^[sheet:11x1:2,0',
				node_texture..'^[sheet:11x1:7,0',
				node_texture..'^[sheet:11x1:8,0',
				node_texture..'^[sheet:11x1:9,0',
				node_texture..'^[sheet:11x1:9,0',
			}
		},
		nodebox = {
			bottom          = {
				{-0.5, -0.5, -0.5, 0.5, 0.0625, 0.5},
			},
			top             = {
				{-0.5, -0.5, -0.5, 0.5, 0.0625, 0.5},
			},
		},
		selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
		recipe = {
			{'', '', ''},
			{'wool:'..color, 'wool:'..color, "wool:white"},
			{"group:wood", "group:wood", "group:wood"},
		},
	})
	minetest.register_craft({
		type = 'fuel',
		recipe = node_name..'_bottom',
		burntime = 12,
	})
end

-- Aliases for MT beds
minetest.register_alias("beds:fancy_bed",        "lord_beds:fancy_bed_red")
minetest.register_alias("beds:fancy_bed_bottom", "lord_beds:fancy_bed_red_bottom")
minetest.register_alias("beds:fancy_bed_top",    "lord_beds:fancy_bed_red_top")
minetest.register_alias("beds:bed",              "lord_beds:bed_red")
minetest.register_alias("beds:bed_bottom",       "lord_beds:bed_red_bottom")
minetest.register_alias("beds:bed_top",          "lord_beds:bed_red_top")
