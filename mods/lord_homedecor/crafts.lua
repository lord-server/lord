-- Crafting for homedecor mod (includes folding) by Vanessa Ezekowitz
--
-- Mostly my own code; overall template borrowed from game default

local S = lord_homedecor.gettext

-- misc craftitems

minetest.register_craftitem("lord_homedecor:terracotta_base", {
        description = S("Uncooked Terracotta Base"),
        inventory_image = "homedecor_terracotta_base.png",
})

minetest.register_craftitem("lord_homedecor:roof_tile_terracotta", {
        description = S("Terracotta Roof Tile"),
        inventory_image = "homedecor_roof_tile_terracotta.png",
})

--minetest.register_craftitem("lord_homedecor:oil_extract", {
        --description = S("Oil extract"),
        --inventory_image = "homedecor_oil_extract.png",
--})

minetest.register_craft( {
	type = "shapeless",
        output = "lord_homedecor:terracotta_base 8",
        recipe = {
		"default:dirt",
		"default:clay_lump",
		"bucket:bucket_water"
        },
	replacements = { {"bucket:bucket_water", "bucket:bucket_empty"}, },
})

minetest.register_craft({
        type = "cooking",
        output = "lord_homedecor:roof_tile_terracotta",
        recipe = "lord_homedecor:terracotta_base",
})

minetest.register_craft( {
        output = "lord_homedecor:shingles_terracotta",
        recipe = {
                { "lord_homedecor:roof_tile_terracotta", "lord_homedecor:roof_tile_terracotta"},
                { "lord_homedecor:roof_tile_terracotta", "lord_homedecor:roof_tile_terracotta"},
        },
})

minetest.register_craft( {
        output = "lord_homedecor:flower_pot_terracotta",
        recipe = {
                { "lord_homedecor:roof_tile_terracotta", "default:dirt", "lord_homedecor:roof_tile_terracotta" },
                { "", "lord_homedecor:roof_tile_terracotta", "" },
        },
})

-- кровля
minetest.register_craft( {
        output = "lord_homedecor:shingles_wood 12",
        recipe = {
                { "group:stick", "group:wood"},
                { "group:wood", "group:stick"},
        },
})

minetest.register_craft( {
        output = "lord_homedecor:shingles_wood 12",
        recipe = {
                { "group:wood", "group:stick"},
                { "group:stick", "group:wood"},
        },
})

minetest.register_craft({
        type = "fuel",
        recipe = "lord_homedecor:shingles_wood",
        burntime = 30,
})

----

-- мансардные стекла
minetest.register_craft( {
        output = "lord_homedecor:skylight 4",
        recipe = {
		{ "default:glass", "default:glass" },
        },
})

minetest.register_craft( {
	type = "shapeless",
        output = "lord_homedecor:skylight_frosted",
        recipe = {
			"dye:white",
			"lord_homedecor:skylight"
		},
})

minetest.register_craft({
        type = "cooking",
        output = "lord_homedecor:skylight",
        recipe = "lord_homedecor:skylight_frosted",
})
--

---- Various colors of shutters / окрашенные ставни
minetest.register_craft( {
        output = "lord_homedecor:shutter_oak 2",
        recipe = {
		{ "group:stick", "group:stick" },
		{ "group:stick", "group:stick" },
		{ "group:stick", "group:stick" },
        },
})

minetest.register_craft({
        type = "fuel",
        recipe = "lord_homedecor:shutter_oak",
        burntime = 30,
})

----

minetest.register_craft( {
	type = "shapeless",
        output = "lord_homedecor:shutter_black 4",
        recipe = {
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"dye:black"
        },
})

minetest.register_craft({
        type = "fuel",
        recipe = "lord_homedecor:shutter_black",
        burntime = 30,
})

----

minetest.register_craft( {
	type = "shapeless",
        output = "lord_homedecor:shutter_dark_grey 4",
        recipe = {
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"dye:dark_grey"
        },
})

minetest.register_craft({
        type = "fuel",
        recipe = "lord_homedecor:shutter_dark_grey",
        burntime = 30,
})

----

minetest.register_craft( {
	type = "shapeless",
        output = "lord_homedecor:shutter_grey 4",
        recipe = {
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"dye:grey"
        },
})

minetest.register_craft({
        type = "fuel",
        recipe = "lord_homedecor:shutter_grey",
        burntime = 30,
})

--

minetest.register_craft( {
	type = "shapeless",
        output = "lord_homedecor:shutter_white 4",
        recipe = {
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"dye:white"
        },
})

minetest.register_craft({
        type = "fuel",
        recipe = "lord_homedecor:shutter_white",
        burntime = 30,
})

--

minetest.register_craft( {
	type = "shapeless",
        output = "lord_homedecor:shutter_mahogany 4",
       	recipe = {
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"dye:brown"
	},
})

minetest.register_craft({
       	type = "fuel",
       	recipe = "lord_homedecor:shutter_mahogany",
       	burntime = 30,
})

----

minetest.register_craft( {
	type = "shapeless",
        output = "lord_homedecor:shutter_red 4",
       	recipe = {
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"dye:red"
	},
})

minetest.register_craft({
       	type = "fuel",
       	recipe = "lord_homedecor:shutter_red",
       	burntime = 30,
})

minetest.register_craft( {
	type = "shapeless",
        output = "lord_homedecor:shutter_yellow 4",
       	recipe = {
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"dye:yellow"
	},
})

minetest.register_craft({
       	type = "fuel",
       	recipe = "lord_homedecor:shutter_yellow",
       	burntime = 30,
})

--

minetest.register_craft( {
	type = "shapeless",
        output = "lord_homedecor:shutter_forest_green 4",
        recipe = {
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"dye:dark_green"
        },
})

minetest.register_craft({
        type = "fuel",
        recipe = "lord_homedecor:shutter_forest_green",
        burntime = 30,
})

--

minetest.register_craft( {
	type = "shapeless",
        output = "lord_homedecor:shutter_light_blue 4",
       	recipe = {
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"dye:blue"
	},
})

minetest.register_craft({
       	type = "fuel",
       	recipe = "lord_homedecor:shutter_light_blue",
       	burntime = 30,
})

----

minetest.register_craft( {
	type = "shapeless",
        output = "lord_homedecor:shutter_violet 4",
       	recipe = {
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"lord_homedecor:shutter_oak",
		"dye:violet"
	},
})

minetest.register_craft({
       	type = "fuel",
       	recipe = "lord_homedecor:shutter_violet",
       	burntime = 30,
})

----

--minetest.register_craft( {
        --output = "lord_homedecor:drawer_small",
        --recipe = {
                --{ "group:wood", "default:steel_ingot", "group:wood" },
        --},
--})

--minetest.register_craft({
        --type = "fuel",
        --recipe = "lord_homedecor:drawer_small",
        --burntime = 30,
--})

----

--minetest.register_craft( {
        --output = "lord_homedecor:nightstand_oak_one_drawer",
        --recipe = {
                --{ "lord_homedecor:drawer_small" },
                --{ "group:wood" },
        --},
--})

--minetest.register_craft({
        --type = "fuel",
        --recipe = "lord_homedecor:nightstand_oak_one_drawer",
        --burntime = 30,
--})

--minetest.register_craft( {
        --output = "lord_homedecor:nightstand_oak_two_drawers",
        --recipe = {
                --{ "lord_homedecor:drawer_small" },
                --{ "lord_homedecor:drawer_small" },
                --{ "group:wood" },
        --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:nightstand_oak_two_drawers",
        --recipe = {
                --{ "lord_homedecor:nightstand_oak_one_drawer" },
                --{ "lord_homedecor:drawer_small" },
        --},
--})

--minetest.register_craft({
        --type = "fuel",
        --recipe = "lord_homedecor:nightstand_oak_two_drawers",
        --burntime = 30,
--})

----

--minetest.register_craft( {
	--type = "shapeless",
        --output = "lord_homedecor:nightstand_mahogany_one_drawer",
        --recipe = {
                --"lord_homedecor:nightstand_oak_one_drawer",
                --"dye:brown",
        --},
--})

--minetest.register_craft({
        --type = "fuel",
        --recipe = "lord_homedecor:nightstand_mahogany_one_drawer",
        --burntime = 30,
--})

--minetest.register_craft( {
	--type = "shapeless",
        --output = "lord_homedecor:nightstand_mahogany_two_drawers",
        --recipe = {
                --"lord_homedecor:nightstand_oak_two_drawers",
                --"dye:brown",
        --},
--})

--minetest.register_craft({
        --type = "fuel",
        --recipe = "lord_homedecor:nightstand_mahogany_two_drawers",
        --burntime = 30,
--})

---- Table legs

--minetest.register_craft( {
        --output = "lord_homedecor:table_legs_wrought_iron 3",
        --recipe = {
                --{ "", "default:iron_lump", "" },
                --{ "", "default:iron_lump", "" },
                --{ "default:iron_lump", "default:iron_lump", "default:iron_lump" },
        --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:table_legs_brass 3",
	--recipe = {
		--{ "", "technic:brass_ingot", "" },
		--{ "", "technic:brass_ingot", "" },
		--{ "technic:brass_ingot", "technic:brass_ingot", "technic:brass_ingot" }
	--},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:utility_table_legs",
        --recipe = {
                --{ "group:stick", "group:stick", "group:stick" },
                --{ "group:stick", "", "group:stick" },
                --{ "group:stick", "", "group:stick" },
        --},
--})

--minetest.register_craft({
        --type = "fuel",
   --cipe = "lord_homedecor:shutter_violet",
       	--burntime = 30,
--})

----

--minetest.register_craft( {
        --output = "lord_homedecor:drawer_small",
        --recipe = {
                --{ "group:wood", "default:steel_ingot", "group:wood" },
        --},
--})

--minetest.register_craft({
        --type = "fuel",
        --recipe = "lord_homedecor:drawer_small",
        --burntime = 30,
--})

----

--minetest.register_craft( {
        --output = "lord_homedecor:nightstand_oak_one_drawer",
        --recipe = {
                --{ "lord_homedecor:drawer_small" },
                --{ "group:wood" },
        --},
--})

--minetest.register_craft({
        --type = "fuel",
        --recipe = "lord_homedecor:nightstand_oak_one_drawer",
        --burntime = 30,
--})

--minetest.register_craft( {
        --output = "lord_homedecor:nightstand_oak_two_drawers",
        --recipe = {
                --{ "lord_homedecor:drawer_small" },
                --{ "lord_homedecor:drawer_small" },
                --{ "group:wood" },
        --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:nightstand_oak_two_drawers",
        --recipe = {
                --{ "lord_homedecor:nightstand_oak_one_drawer" },
                --{ "lord_homedecor:drawer_small" },
        --},
--})

--minetest.register_craft({
        --type = "fuel",
        --recipe = "lord_homedecor:nightstand_oak_two_drawers",
        --burntime = 30,
--})

----

--minetest.register_craft( {
	--type = "shapeless",
        --output = "lord_homedecor:nightstand_mahogany_one_drawer",
        --recipe = {
                --"lord_homedecor:nightstand_oak_one_drawer",
                --"dye:brown",
        --},
--})

--minetest.register_craft({
        --type = "fuel",
        --recipe = "lord_homedecor:nightstand_mahogany_one_drawer",
        --burntime = 30,
--})

--minetest.register_craft( {
	--type = "shapeless",
        --output = "lord_homedecor:nightstand_mahogany_two_drawers",
        --recipe = {
                --"lord_homedecor:nightstand_oak_two_drawers",
                --"dye:brown",
        --},
--})

--minetest.register_craft({
        --type = "fuel",
        --recipe = "lord_homedecor:nightstand_mahogany_two_drawers",
        --burntime = 30,
--})

---- Table legs

--minetest.register_craft( {
        --output = "lord_homedecor:table_legs_wrought_iron 3",
        --recipe = {
                --{ "", "default:iron_lump", "" },
                --{ "", "default:iron_lump", "" },
                --{ "default:iron_lump", "default:iron_lump", "default:iron_lump" },
        --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:table_legs_brass 3",
	--recipe = {
		--{ "", "technic:brass_ingot", "" },
		--{ "", "technic:brass_ingot", "" },
		--{ "technic:brass_ingot", "technic:brass_ingot", "technic:brass_ingot" }
	--},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:utility_table_legs",
        --recipe = {
                --{ "group:stick", "group:stick", "group:stick" },
                --{ "group:stick", "", "group:stick" },
                --{ "group:stick", "", "group:stick" },
        --},
--})

--minetest.register_craft({
        --type = "fuel",
        --recipe = "lord_homedecor:utility_table_legs",
        --burntime = 30,
--})

---- vertical poles/lampposts

--minetest.register_craft( {
        --output = "lord_homedecor:pole_brass 4",
	--recipe = {
		--{ "", "technic:brass_ingot", "" },
		--{ "", "technic:brass_ingot", "" },
		--{ "", "technic:brass_ingot", "" }
	--},
--})

minetest.register_craft( {
        output = "lord_homedecor:pole_wrought_iron 6",
        recipe = {
                { "default:steel_ingot", },
                { "default:steel_ingot", },
                { "default:steel_ingot", },
        },
})

---- Home electronics

--minetest.register_craft( {
	--output = "lord_homedecor:ic 4",
	--recipe = {
		--{ "mesecons_materials:silicon", "mesecons_materials:silicon" },
		--{ "mesecons_materials:silicon", "default:copper_ingot" },
	--},
--})

--minetest.register_craft( {
	--output = "lord_homedecor:television",
	--recipe = {
		--{ "lord_homedecor:plastic_sheeting", "lord_homedecor:plastic_sheeting", "lord_homedecor:plastic_sheeting" },
		--{ "lord_homedecor:plastic_sheeting", "moreblocks:glow_glass", "lord_homedecor:plastic_sheeting" },
		--{ "lord_homedecor:ic", "lord_homedecor:ic", "lord_homedecor:ic" },
	--},
--})

--minetest.register_craft( {
	--output = "lord_homedecor:television",
	--recipe = {
		--{ "lord_homedecor:plastic_sheeting", "lord_homedecor:plastic_sheeting", "lord_homedecor:plastic_sheeting" },
		--{ "lord_homedecor:plastic_sheeting", "default:glass", "lord_homedecor:plastic_sheeting" },
		--{ "lord_homedecor:ic", "lord_homedecor:power_crystal", "lord_homedecor:ic" },
	--},
--})

--minetest.register_craft( {
	--output = "lord_homedecor:stereo",
	--recipe = {
		--{ "lord_homedecor:plastic_sheeting", "lord_homedecor:plastic_sheeting", "lord_homedecor:plastic_sheeting" },
		--{ "lord_homedecor:plastic_sheeting", "lord_homedecor:ic", "lord_homedecor:plastic_sheeting" },
		--{ "default:steel_ingot", "lord_homedecor:ic", "default:steel_ingot" },
	--},
--})

---- ===========================================================
---- Recipes that require materials from wool (cotton alternate)

--minetest.register_craft( {
	--type = "shapeless",
        --output = "lord_homedecor:rug_small 8",
       	--recipe = {
			--"wool:red",
			--"wool:yellow",
			--"wool:blue",
			--"wool:black"
	--},
--})

--minetest.register_craft( {
	--output = "lord_homedecor:rug_persian 8",
	--recipe = {
		--{ "", "wool:yellow", "" },
		--{ "wool:red", "wool:blue", "wool:red" },
		--{ "", "wool:yellow", "" }
	--},
--})

---- cotton versions:

--minetest.register_craft( {
	--type = "shapeless",
        --output = "lord_homedecor:rug_small 8",
       	--recipe = {
			--"cotton:red",
			--"cotton:yellow",
			--"cotton:blue",
			--"cotton:black"
	--},
--})

--minetest.register_craft( {
	--output = "lord_homedecor:rug_persian 8",
	--recipe = {
		--{ "", "cotton:yellow", "" },
		--{ "cotton:red", "cotton:blue", "cotton:red" },
		--{ "", "cotton:yellow", "" }
	--},
--})

---- fuel recipes for same

--minetest.register_craft({
       	--type = "fuel",
       	--recipe = "lord_homedecor:rug_small",
       	--burntime = 30,
--})

--minetest.register_craft( {
	--type = "shapeless",
        --output = "lord_homedecor:rug_large 2",
       	--recipe = {
		--"lord_homedecor:rug_small",
		--"lord_homedecor:rug_small",
	--},
--})

--minetest.register_craft({
       	--type = "fuel",
       	--recipe = "lord_homedecor:rug_large",
       	--burntime = 30,
--})

--minetest.register_craft({
       	--type = "fuel",
       	--recipe = "lord_homedecor:rug_persian",
       	--burntime = 30,
--})

---- Speakers

--minetest.register_craft( {
        --output = "lord_homedecor:speaker_driver 2",
      		--recipe = {
		--{ "", "default:steel_ingot", "" },
		--{ "default:paper", "lord_homedecor:copper_wire", "default:iron_lump" },
		--{ "", "default:steel_ingot", "" },
	--},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:speaker_small",
      		--recipe = {
		--{ "wool:black", "lord_homedecor:speaker_driver", "group:wood" },
	--},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:speaker",
      		--recipe = {
		--{ "wool:black", "lord_homedecor:speaker_driver", "group:wood" },
		--{ "wool:black", "lord_homedecor:speaker_driver", "group:wood" },
		--{ "wool:black", "group:wood", "group:wood" },
	--},
--})

---- cotton version

--minetest.register_craft( {
        --output = "lord_homedecor:speaker_small",
      		--recipe = {
		--{ "cotton:black", "lord_homedecor:speaker_driver", "group:wood" },
	--},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:speaker",
      		--recipe = {
		--{ "cotton:black", "lord_homedecor:speaker_driver", "group:wood" },
		--{ "cotton:black", "lord_homedecor:speaker_driver", "group:wood" },
		--{ "cotton:black", "group:wood", "group:wood" },
	--},
--})

---- Curtains

--local curtaincolors = {
	--"red",
	--"green",
	--"blue",
	--"white",
	--"pink",
	--"violet"
--}

--for c in ipairs(curtaincolors) do
	--local color = curtaincolors[c]
	--minetest.register_craft( {
		--output = "lord_homedecor:curtain_"..color.." 3",
	      		--recipe = {
			--{ "wool:"..color, "", ""},
			--{ "wool:"..color, "", ""},
			--{ "wool:"..color, "", ""},
		--},
	--})
--end

--local mats = {
	--{ "brass", "lord_homedecor:pole_brass" },
	--{ "wrought_iron", "lord_homedecor:pole_wrought_iron" },
	--{ "wood", "group:stick" }
--}

--for i in ipairs(mats) do
	--local material = mats[i][1]
	--local ingredient = mats[i][2]
	--minetest.register_craft( {
		--output = "lord_homedecor:curtainrod_"..material.." 3",
		--recipe = {
			--{ ingredient, ingredient, ingredient },
		--},
	--})
--end

---- Recycling recipes

---- Some glass objects recycle via the glass fragments item/recipe in the Vessels mod.

--minetest.register_craft({
        --type = "shapeless",
        --output = "vessels:glass_fragments",
        --recipe = {
		--"lord_homedecor:glass_table_small_round",
		--"lord_homedecor:glass_table_small_round",
		--"lord_homedecor:glass_table_small_round"
	--}
--})

--minetest.register_craft({
        --type = "shapeless",
        --output = "vessels:glass_fragments",
        --recipe = {
		--"lord_homedecor:glass_table_small_square",
		--"lord_homedecor:glass_table_small_square",
		--"lord_homedecor:glass_table_small_square"
	--}
--})

--minetest.register_craft({
        --type = "shapeless",
        --output = "vessels:glass_fragments",
        --recipe = {
		--"lord_homedecor:glass_table_large",
		--"lord_homedecor:glass_table_large",
		--"lord_homedecor:glass_table_large"
	--}
--})

--minetest.register_craft({
        --type = "shapeless",
        --output = "vessels:glass_fragments 2",
        --recipe = {
		--"lord_homedecor:skylight",
		--"lord_homedecor:skylight",
		--"lord_homedecor:skylight",
		--"lord_homedecor:skylight",
		--"lord_homedecor:skylight",
		--"lord_homedecor:skylight"
	--}
--})

---- Wooden tabletops can turn into sticks

--minetest.register_craft({
        --type = "shapeless",
        --output = "default:stick 4",
        --recipe = {
		--"lord_homedecor:wood_table_small_round",
		--"lord_homedecor:wood_table_small_round",
		--"lord_homedecor:wood_table_small_round"
	--}
--})

--minetest.register_craft({
        --type = "shapeless",
        --output = "default:stick 4",
        --recipe = {
		--"lord_homedecor:wood_table_small_square",
		--"lord_homedecor:wood_table_small_square",
		--"lord_homedecor:wood_table_small_square"
	--}
--})

--minetest.register_craft({
        --type = "shapeless",
        --output = "default:stick 4",
        --recipe = {
		--"lord_homedecor:wood_table_large",
		--"lord_homedecor:wood_table_large",
		--"lord_homedecor:wood_table_large"
	--}
--})

---- Kitchen stuff

--minetest.register_craft({
        --output = "lord_homedecor:oven_steel",
        --recipe = {
		--{"lord_homedecor:heating_element", "default:steel_ingot", "lord_homedecor:heating_element", },
		--{"default:steel_ingot", "moreblocks:iron_glass", "default:steel_ingot", },
		--{"default:steel_ingot", "lord_homedecor:heating_element", "default:steel_ingot", },
	--}
--})

--minetest.register_craft({
        --output = "lord_homedecor:oven_steel",
        --recipe = {
		--{"lord_homedecor:heating_element", "default:steel_ingot", "lord_homedecor:heating_element", },
		--{"default:steel_ingot", "default:glass", "default:steel_ingot", },
		--{"default:steel_ingot", "lord_homedecor:heating_element", "default:steel_ingot", },
	--}
--})

--minetest.register_craft({
	--type = "shapeless",
	--output = "lord_homedecor:oven",
	--recipe = {
		--"lord_homedecor:oven_steel",
		--"dye:white",
		--"dye:white",
	--}
--})

--minetest.register_craft({
        --output = "lord_homedecor:microwave_oven 2",
        --recipe = {
		--{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot", },
		--{"default:steel_ingot", "moreblocks:iron_glass", "lord_homedecor:ic", },
		--{"default:steel_ingot", "default:copper_ingot", "lord_homedecor:power_crystal", },
	--}
--})

--minetest.register_craft({
        --output = "lord_homedecor:microwave_oven 2",
        --recipe = {
		--{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot", },
		--{"default:steel_ingot", "default:glass", "lord_homedecor:ic", },
		--{"default:steel_ingot", "default:copper_ingot", "lord_homedecor:power_crystal", },
	--}
--})

--minetest.register_craft({
	--output = "lord_homedecor:refrigerator_steel",
	--recipe = {
		--{"default:steel_ingot", "lord_homedecor:glowlight_small_cube_white", "default:steel_ingot", },
		--{"default:steel_ingot", "default:copperblock", "default:steel_ingot", },
		--{"default:steel_ingot", "default:clay", "default:steel_ingot", },
	--}
--})

--minetest.register_craft({
	--type = "shapeless",
	--output = "lord_homedecor:refrigerator_white",
	--recipe = {
		--"lord_homedecor:refrigerator_steel",
		--"dye:white",
		--"dye:white",
		--"dye:white",
	--}
--})

--minetest.register_craft({
        --output = "lord_homedecor:kitchen_cabinet",
        --recipe = {
		--{"group:wood", "group:stick", "group:wood", },
		--{"group:wood", "group:stick", "group:wood", },
		--{"group:wood", "group:stick", "group:wood", },
	--}
--})

--minetest.register_craft({
        --output = "lord_homedecor:kitchen_cabinet_steel",
        --recipe = {
			--{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
			--{"", "lord_homedecor:kitchen_cabinet", ""},
	--}
--})

--minetest.register_craft({
        --output = "lord_homedecor:kitchen_cabinet_steel",
        --recipe = {
			--{"moreblocks:slab_steelblock_1"},
			--{ "lord_homedecor:kitchen_cabinet" },
	--}
--})

--minetest.register_craft({
        --output = "lord_homedecor:kitchen_cabinet_marble",
        --recipe = {
			--{"building_blocks:slab_marble"},
			--{"lord_homedecor:kitchen_cabinet"},
	--}
--})

--minetest.register_craft({
        --output = "lord_homedecor:kitchen_cabinet_marble",
        --recipe = {
			--{"technic:slab_marble_1"},
			--{"lord_homedecor:kitchen_cabinet"},
	--}
--})

--minetest.register_craft({
        --output = "lord_homedecor:kitchen_cabinet_granite",
        --recipe = {
			--{"technic:slab_granite_1"},
			--{"lord_homedecor:kitchen_cabinet"},
	--}
--})

--minetest.register_craft({
	--type = "shapeless",
        --output = "lord_homedecor:kitchen_cabinet_half 2",
        --recipe = { "lord_homedecor:kitchen_cabinet" }
--})

--minetest.register_craft({
        --output = "lord_homedecor:kitchen_cabinet_with_sink",
        --recipe = {
		--{"group:wood", "default:steel_ingot", "group:wood", },
		--{"group:wood", "default:steel_ingot", "group:wood", },
		--{"group:wood", "group:stick", "group:wood", },
	--}
--})

-- Lighting / Освещение

-- candles / свечи

minetest.register_craft({
	output = "lord_homedecor:candle_thin 4",
	recipe = {
		{"farming:string" },
		{"bees:wax" }
	}
})

minetest.register_craft({
	output = "lord_homedecor:candle 2",
	recipe = {
		{"farming:string" },
		{"bees:wax" },
		{"bees:wax" }
	}
})

minetest.register_craft({
	output = "lord_homedecor:wall_sconce 2",
	recipe = {
		{"default:iron_lump", "", ""},
		{"default:iron_lump", "lord_homedecor:candle", ""},
		{"default:iron_lump", "", ""},
	}
})

minetest.register_craft({
	output = "lord_homedecor:candlestick_wrought_iron",
	recipe = {
		{""},
		{"lord_homedecor:candle_thin"},
		{"default:iron_lump"},
	}
})

minetest.register_craft({
	output = "lord_homedecor:candlestick_brass",
	recipe = {
		{""},
		{"lord_homedecor:candle_thin"},
		{"default:bronze_ingot"},
	}
})

--minetest.register_craft({
	--output = "lord_homedecor:oil_lamp",
	--recipe = {
		--{ "", "vessels:glass_bottle", "" },
		--{ "", "farming:string", "" },
		--{ "default:steel_ingot", "lord_homedecor:oil_extract", "default:steel_ingot" }
	--}
--})

--minetest.register_craft({
	--output = "lord_homedecor:oil_lamp_tabletop",
	--recipe = {
		--{ "", "vessels:glass_bottle", "" },
		--{ "", "farming:string", "" },
		--{ "default:iron_lump", "lord_homedecor:oil_extract", "default:iron_lump" }
	--}
--})

---- Wrought-iron wall latern

--minetest.register_craft({
	--output = "lord_homedecor:ground_lantern",
	--recipe = {
		--{ "default:iron_lump", "default:iron_lump", "default:iron_lump" },
		--{ "default:iron_lump", "default:torch", "default:iron_lump" },
		--{ "", "default:iron_lump", "" }
	--}
--})

---- wood-lattice lamps

--minetest.register_craft( {
        --output = "lord_homedecor:lattice_lantern_large 2",
        --recipe = {
			--{ "dye:black", "dye:yellow", "dye:black" },
			--{ "group:stick", "building_blocks:woodglass", "group:stick" },
			--{ "group:stick", "default:torch", "group:stick" }
        --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:lattice_lantern_small 8",
        --recipe = {
			--{ "lord_homedecor:lattice_lantern_large" },
        --},
--})

---- yellow glowlights

--minetest.register_craft({
	--output = "lord_homedecor:glowlight_half_yellow 6",
	--recipe = {
		--{"default:glass", "lord_homedecor:power_crystal", "default:glass", },
	--}
--})

--minetest.register_craft({
	--output = "lord_homedecor:glowlight_half_yellow 6",
	--recipe = {
		--{"moreblocks:super_glow_glass", "moreblocks:glow_glass", "moreblocks:super_glow_glass", },
	--}
--})

--minetest.register_craft({
        --output = "lord_homedecor:glowlight_quarter_yellow 6",
        --recipe = {
		--{"lord_homedecor:glowlight_half_yellow", "lord_homedecor:glowlight_half_yellow", "lord_homedecor:glowlight_half_yellow", },
	--}
--})

--minetest.register_craft({
	--output = "lord_homedecor:glowlight_small_cube_yellow 16",
	--recipe = {
		--{"default:glass" },
		--{"lord_homedecor:power_crystal" },
	--}
--})

--minetest.register_craft({
        --output = "lord_homedecor:glowlight_small_cube_yellow 16",
        --recipe = {
		--{"moreblocks:glow_glass" },
		--{"moreblocks:super_glow_glass" },
	--}
--})

--minetest.register_craft({
        --output = "lord_homedecor:glowlight_small_cube_yellow 4",
        --recipe = {
		--{"lord_homedecor:glowlight_half_yellow" },
	--}
--})

--minetest.register_craft({
        --output = "lord_homedecor:glowlight_half_yellow",
        --recipe = {
		--{"lord_homedecor:glowlight_small_cube_yellow","lord_homedecor:glowlight_small_cube_yellow"},
		--{"lord_homedecor:glowlight_small_cube_yellow","lord_homedecor:glowlight_small_cube_yellow"}
	--}
--})

--minetest.register_craft({
		--output = "lord_homedecor:glowlight_half_yellow",
		--type = "shapeless",
		--recipe = {
		--"lord_homedecor:glowlight_quarter_yellow",
		--"lord_homedecor:glowlight_quarter_yellow"
	--}
--})

---- white

--minetest.register_craft({
	--output = "lord_homedecor:glowlight_half_white 6",
	--recipe = {
		--{ "dye:white", "dye:white", "dye:white" },
		--{ "default:glass", "lord_homedecor:power_crystal", "default:glass", },
	--}
--})

--minetest.register_craft({
        --output = "lord_homedecor:glowlight_half_white 6",
        --recipe = {
		--{ "dye:white", "dye:white", "dye:white" },
		--{"moreblocks:super_glow_glass", "moreblocks:glow_glass", "moreblocks:super_glow_glass", },
	--}
--})

--minetest.register_craft({
	--type = "shapeless",
        --output = "lord_homedecor:glowlight_half_white 2",
        --recipe = {
		--"dye:white",
		--"lord_homedecor:glowlight_half_yellow",
		--"lord_homedecor:glowlight_half_yellow",
	--}
--})

--minetest.register_craft({
        --output = "lord_homedecor:glowlight_quarter_white 6",
        --recipe = {
		--{"lord_homedecor:glowlight_half_white", "lord_homedecor:glowlight_half_white", "lord_homedecor:glowlight_half_white", },
	--}
--})

--minetest.register_craft({
	--output = "lord_homedecor:glowlight_small_cube_white 8",
	--recipe = {
		--{ "dye:white" },
		--{ "default:glass" },
		--{ "lord_homedecor:power_crystal" },
	--}
--})

--minetest.register_craft({
        --output = "lord_homedecor:glowlight_small_cube_white 8",
        --recipe = {
		--{"dye:white" },
		--{"moreblocks:super_glow_glass" },
	--}
--})

--minetest.register_craft({
        --output = "lord_homedecor:glowlight_small_cube_white 4",
        --recipe = {
		--{"lord_homedecor:glowlight_half_white" },
	--}
--})

--minetest.register_craft({
        --output = "lord_homedecor:glowlight_half_white",
        --recipe = {
		--{"lord_homedecor:glowlight_small_cube_white","lord_homedecor:glowlight_small_cube_white"},
		--{"lord_homedecor:glowlight_small_cube_white","lord_homedecor:glowlight_small_cube_white"}
	--}
--})

--minetest.register_craft({
		--output = "lord_homedecor:glowlight_half_white",
		--type = "shapeless",
		--recipe = {
		--"lord_homedecor:glowlight_quarter_white",
		--"lord_homedecor:glowlight_quarter_white"
	--}
--})

------

--minetest.register_craft({
    --output = "lord_homedecor:plasma_lamp",
    --recipe = {
		--{"", "default:glass", ""},
		--{"default:glass", "lord_homedecor:power_crystal", "default:glass"},
		--{"", "default:glass", ""}
	--}
--})

--minetest.register_craft({
    --output = "lord_homedecor:plasma_ball 2",
    --recipe = {
		--{"", "default:glass", ""},
		--{"default:glass", "default:copper_ingot", "default:glass"},
		--{"lord_homedecor:plastic_sheeting", "lord_homedecor:power_crystal", "lord_homedecor:plastic_sheeting"}
	--}
--})

---- Brass/wrought iron fences


--minetest.register_craft( {
        --output = "lord_homedecor:fence_brass 6",
	--recipe = {
		--{ "technic:brass_ingot", "technic:brass_ingot", "technic:brass_ingot" },
		--{ "technic:brass_ingot", "technic:brass_ingot", "technic:brass_ingot" },
	--},
--})

--minetest.register_craft( {
	--output = "lord_homedecor:fence_wrought_iron 6",
	--recipe = {
		--{ "default:iron_lump","default:iron_lump","default:iron_lump" },
		--{ "default:iron_lump","default:iron_lump","default:iron_lump" },
	--},
--})

---- other types of fences

--minetest.register_craft( {
	--output = "lord_homedecor:fence_wrought_iron_2 2",
	--recipe = {
		--{ "lord_homedecor:pole_wrought_iron", "default:iron_lump" },
		--{ "lord_homedecor:pole_wrought_iron", "default:iron_lump" },
	--},
--})

--minetest.register_craft( {
	--output = "lord_homedecor:fence_wrought_iron_2 2",
	--recipe = {
		--{ "lord_homedecor:pole_wrought_iron", "default:iron_lump" },
		--{ "lord_homedecor:pole_wrought_iron", "default:iron_lump" },
	--},
--})

--minetest.register_craft( {
	--type = "shapeless",
	--output = "lord_homedecor:fence_wrought_iron_2_corner",
	--recipe = {
		--"lord_homedecor:fence_wrought_iron_2",
		--"lord_homedecor:fence_wrought_iron_2"
	--},
--})

--minetest.register_craft( {
	--type = "shapeless",
	--output = "lord_homedecor:fence_wrought_iron_2 2",
	--recipe = {
		--"lord_homedecor:fence_wrought_iron_2_corner",
	--},
--})

----

--minetest.register_craft( {
	--output = "lord_homedecor:fence_picket 6",
	--recipe = {
		--{ "group:stick", "group:stick", "group:stick" },
		--{ "group:stick", "", "group:stick" },
		--{ "group:stick", "group:stick", "group:stick" }
	--},
--})

--minetest.register_craft( {
	--type = "shapeless",
	--output = "lord_homedecor:fence_picket_corner",
	--recipe = {
		--"lord_homedecor:fence_picket",
		--"lord_homedecor:fence_picket"
	--},
--})

--minetest.register_craft( {
	--type = "shapeless",
	--output = "lord_homedecor:fence_picket 2",
	--recipe = {
		--"lord_homedecor:fence_picket_corner"
	--},
--})

----


--minetest.register_craft( {
	--output = "lord_homedecor:fence_picket_white 6",
	--recipe = {
		--{ "group:stick", "group:stick", "group:stick" },
		--{ "group:stick", "dye:white", "group:stick" },
		--{ "group:stick", "group:stick", "group:stick" }
	--},
--})

--minetest.register_craft( {
	--type = "shapeless",
	--output = "lord_homedecor:fence_picket_corner_white",
	--recipe = {
		--"lord_homedecor:fence_picket_white",
		--"lord_homedecor:fence_picket_white"
	--},
--})

--minetest.register_craft( {
	--type = "shapeless",
	--output = "lord_homedecor:fence_picket_white 2",
	--recipe = {
		--"lord_homedecor:fence_picket_corner_white"
	--},
--})

----


--minetest.register_craft( {
	--output = "lord_homedecor:fence_privacy 6",
	--recipe = {
		--{ "group:wood", "group:stick", "group:wood" },
		--{ "group:wood", "", "group:wood" },
		--{ "group:wood", "group:stick", "group:wood" }
	--},
--})

--minetest.register_craft( {
	--type = "shapeless",
	--output = "lord_homedecor:fence_privacy_corner",
	--recipe = {
		--"lord_homedecor:fence_privacy",
		--"lord_homedecor:fence_privacy"
	--},
--})

--minetest.register_craft( {
	--type = "shapeless",
	--output = "lord_homedecor:fence_privacy 2",
	--recipe = {
		--"lord_homedecor:fence_privacy_corner"
	--},
--})

----


--minetest.register_craft( {
	--output = "lord_homedecor:fence_barbed_wire 6",
	--recipe = {
		--{ "group:stick", "lord_homedecor:steel_wire", "group:stick" },
		--{ "group:stick", "", "group:stick" },
		--{ "group:stick", "lord_homedecor:steel_wire", "group:stick" }
	--},
--})

--minetest.register_craft( {
	--type = "shapeless",
	--output = "lord_homedecor:fence_barbed_wire_corner",
	--recipe = { "lord_homedecor:fence_barbed_wire", "lord_homedecor:fence_barbed_wire" },
--})

--minetest.register_craft( {
	--type = "shapeless",
	--output = "lord_homedecor:fence_barbed_wire 2",
	--recipe = { "lord_homedecor:fence_barbed_wire_corner" },
--})

----


--minetest.register_craft( {
	--output = "lord_homedecor:fence_chainlink 9",
	--recipe = {
		--{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" },
		--{ "lord_homedecor:steel_wire", "lord_homedecor:steel_wire", "default:steel_ingot" },
		--{ "lord_homedecor:steel_wire", "lord_homedecor:steel_wire", "default:steel_ingot" }
	--},
--})

--minetest.register_craft( {
	--type = "shapeless",
	--output = "lord_homedecor:fence_chainlink_corner",
	--recipe = { "lord_homedecor:fence_chainlink", "lord_homedecor:fence_chainlink" },
--})

--minetest.register_craft( {
	--type = "shapeless",
	--output = "lord_homedecor:fence_chainlink 2",
	--recipe = { "lord_homedecor:fence_chainlink_corner" },
--})


---- Gates

--minetest.register_craft( {
	--type = "shapeless",
        --output = "lord_homedecor:gate_picket_white_closed",
        --recipe = {
			--"lord_homedecor:fence_picket_white"
        --},
--})

--minetest.register_craft( {
	--type = "shapeless",
        --output = "lord_homedecor:fence_picket_white",
        --recipe = {
			--"lord_homedecor:gate_picket_white_closed"
        --},
--})

--minetest.register_craft( {
	--type = "shapeless",
        --output = "lord_homedecor:gate_picket_closed",
        --recipe = {
			--"lord_homedecor:fence_picket"
        --},
--})

--minetest.register_craft( {
	--type = "shapeless",
        --output = "lord_homedecor:fence_picket",
        --recipe = {
			--"lord_homedecor:gate_picket_closed"
        --},
--})

--minetest.register_craft( {
	--type = "shapeless",
        --output = "lord_homedecor:gate_barbed_wire_closed",
        --recipe = {
			--"lord_homedecor:fence_barbed_wire"
        --},
--})

--minetest.register_craft( {
	--type = "shapeless",
        --output = "lord_homedecor:fence_barbed_wire",
        --recipe = {
			--"lord_homedecor:gate_barbed_wire_closed"
        --},
--})

--minetest.register_craft( {
	--type = "shapeless",
        --output = "lord_homedecor:gate_chainlink_closed",
        --recipe = {
			--"lord_homedecor:fence_chainlink"
        --},
--})

--minetest.register_craft( {
	--type = "shapeless",
        --output = "lord_homedecor:fence_chainlink",
        --recipe = {
			--"lord_homedecor:gate_chainlink_closed"
        --},
--})

-------- Doors

---- plain wood, non-windowed

--minetest.register_craft( {
        --output = "lord_homedecor:door_wood_plain_left 2",
        --recipe = {
			--{ "group:wood", "group:wood", "" },
			--{ "group:wood", "group:wood", "default:steel_ingot" },
			--{ "group:wood", "group:wood", "" },
        --},
--})

---- fancy exterior

--minetest.register_craft( {
        --output = "lord_homedecor:door_exterior_fancy_left 2",
        --recipe = {
			--{ "group:wood", "default:glass" },
			--{ "group:wood", "group:wood" },
			--{ "group:wood", "group:wood" },
        --},
--})

---- wood and glass (grid style)

---- bare

--minetest.register_craft( {
        --output = "lord_homedecor:door_wood_glass_oak_left 2",
        --recipe = {
			--{ "default:glass", "group:wood" },
			--{ "group:wood", "default:glass" },
			--{ "default:glass", "group:wood" },
        --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:door_wood_glass_oak_left 2",
        --recipe = {
			--{ "group:wood", "default:glass" },
			--{ "default:glass", "group:wood" },
			--{ "group:wood", "default:glass" },
        --},
--})

---- mahogany

--minetest.register_craft( {
	--type = "shapeless",
        --output = "lord_homedecor:door_wood_glass_mahogany_left 2",
        --recipe = {
			--"default:dirt",
			--"default:coal_lump",
			--"lord_homedecor:door_wood_glass_oak_left",
			--"lord_homedecor:door_wood_glass_oak_left"
        --},
--})

--minetest.register_craft( {
	--type = "shapeless",
        --output = "lord_homedecor:door_wood_glass_mahogany_left 2",
        --recipe = {
			--"dye:brown",
			--"lord_homedecor:door_wood_glass_oak_left",
			--"lord_homedecor:door_wood_glass_oak_left"
        --},
--})

---- white

--minetest.register_craft( {
	--type = "shapeless",
        --output = "lord_homedecor:door_wood_glass_white_left 2",
        --recipe = {
			--"dye:white",
			--"lord_homedecor:door_wood_glass_oak_left",
			--"lord_homedecor:door_wood_glass_oak_left"
        --},
--})

---- Solid glass with metal handle

--minetest.register_craft( {
        --output = "lord_homedecor:door_glass_left 2",
        --recipe = {
			--{ "default:glass", "default:glass" },
			--{ "default:glass", "default:steel_ingot" },
			--{ "default:glass", "default:glass" },
        --},
--})

---- Closet doors

---- oak

--minetest.register_craft( {
        --output = "lord_homedecor:door_closet_oak_left 2",
        --recipe = {
			--{ "", "group:stick", "group:stick" },
			--{ "default:steel_ingot", "group:stick", "group:stick" },
			--{ "", "group:stick", "group:stick" },
        --},
--})

---- mahogany

--minetest.register_craft( {
	--type = "shapeless",
        --output = "lord_homedecor:door_closet_mahogany_left 2",
        --recipe = {
			--"lord_homedecor:door_closet_oak_left",
			--"lord_homedecor:door_closet_oak_left",
			--"default:dirt",
			--"default:coal_lump",
        --},
--})

--minetest.register_craft( {
	--type = "shapeless",
        --output = "lord_homedecor:door_closet_mahogany_left 2",
        --recipe = {
			--"lord_homedecor:door_closet_oak_left",
			--"lord_homedecor:door_closet_oak_left",
			--"dye:brown"
        --},
--})

---- wrought fence-like door

--minetest.register_craft( {
        --output = "lord_homedecor:door_wrought_iron_left 2",
        --recipe = {
			--{ "lord_homedecor:pole_wrought_iron", "default:iron_lump" },
			--{ "lord_homedecor:pole_wrought_iron", "default:iron_lump" },
			--{ "lord_homedecor:pole_wrought_iron", "default:iron_lump" }
        --},
--})

---- bedroom door

--minetest.register_craft( {
	--output = "lord_homedecor:door_bedroom_left",
	--recipe = {
		--{ "dye:white", "dye:white", "" },
		--{ "lord_homedecor:door_wood_plain_left", "technic:brass_ingot", "" },
		--{ "", "", "" },
	--},
--})

---- woodglass door

--minetest.register_craft( {
	--output = "lord_homedecor:door_woodglass_left",
	--recipe = {
		--{ "group:wood", "default:glass", "" },
		--{ "group:wood", "default:glass", "technic:brass_ingot" },
		--{ "group:wood", "group:wood", "" },
	--},
--})

---- woodglass door type 2

--minetest.register_craft( {
	--output = "lord_homedecor:door_woodglass2_left",
	--recipe = {
		--{ "default:glass", "default:glass", "" },
		--{ "group:wood", "group:wood", "default:iron_lump" },
		--{ "group:wood", "group:wood", "" },
	--},
--})

---- laundry stuff

--minetest.register_craft( {
    --output = "lord_homedecor:washing_machine",
    --recipe = {
		--{ "default:steel_ingot", "default:steel_ingot", "lord_homedecor:ic" },
		--{ "default:steel_ingot", "bucket:bucket_water", "default:steel_ingot" },
		--{ "default:steel_ingot", "lord_homedecor:motor", "default:steel_ingot" }
    --},
--})

--minetest.register_craft( {
    --output = "lord_homedecor:washing_machine",
    --recipe = {
		--{ "default:steel_ingot", "default:steel_ingot", "lord_homedecor:ic" },
		--{ "default:steel_ingot", "bucket:bucket_water", "default:steel_ingot" },
		--{ "default:steel_ingot", "technic:motor", "default:steel_ingot" }
    --},
--})

--minetest.register_craft( {
    --output = "lord_homedecor:dryer",
    --recipe = {
		--{ "default:steel_ingot", "default:steel_ingot", "lord_homedecor:ic" },
		--{ "default:steel_ingot", "bucket:bucket_empty", "lord_homedecor:motor" },
		--{ "default:steel_ingot", "lord_homedecor:heating_element", "default:steel_ingot" }
    --},
--})

--minetest.register_craft( {
    --output = "lord_homedecor:dryer",
    --recipe = {
		--{ "default:steel_ingot", "default:steel_ingot", "lord_homedecor:ic" },
		--{ "default:steel_ingot", "bucket:bucket_empty", "technic:motor" },
		--{ "default:steel_ingot", "lord_homedecor:heating_element", "default:steel_ingot" }
    --},
--})

--minetest.register_craft( {
    --output = "lord_homedecor:ironing_board",
    --recipe = {
		--{ "wool:grey", "wool:grey", "wool:grey"},
		--{ "", "default:steel_ingot", "" },
		--{ "default:steel_ingot", "", "default:steel_ingot" }
    --},
--})

---- dishwashers

--minetest.register_craft( {
    --output = "lord_homedecor:dishwasher",
    --recipe = {
		--{ "lord_homedecor:ic", "lord_homedecor:fence_chainlink", "default:steel_ingot",  },
		--{ "default:steel_ingot", "lord_homedecor:shower_head", "lord_homedecor:motor" },
		--{ "default:steel_ingot", "lord_homedecor:heating_element", "bucket:bucket_water" }
    --},
--})

--minetest.register_craft( {
    --output = "lord_homedecor:dishwasher",
    --recipe = {
		--{ "lord_homedecor:ic", "lord_homedecor:fence_chainlink", "default:steel_ingot",  },
		--{ "default:steel_ingot", "lord_homedecor:shower_head", "technic:motor" },
		--{ "default:steel_ingot", "lord_homedecor:heating_element", "bucket:bucket_water" }
    --},
--})

--minetest.register_craft( {
    --output = "lord_homedecor:dishwasher_wood",
    --recipe = {
		--{ "stairs:slab_wood" },
		--{ "lord_homedecor:dishwasher" },
    --},
--})

--minetest.register_craft( {
    --output = "lord_homedecor:dishwasher_wood",
    --recipe = {
		--{ "moreblocks:slab_wood" },
		--{ "lord_homedecor:dishwasher" },
    --},
--})

--minetest.register_craft( {
    --output = "lord_homedecor:dishwasher_wood",
    --recipe = {
		--{ "moreblocks:slab_wood_1" },
		--{ "lord_homedecor:dishwasher" },
    --},
--})

--minetest.register_craft( {
    --output = "lord_homedecor:dishwasher_steel",
    --recipe = {
		--{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" },
		--{ "", "lord_homedecor:dishwasher", "" },
    --},
--})

--minetest.register_craft( {
    --output = "lord_homedecor:dishwasher_steel",
    --recipe = {
		--{ "moreblocks:slab_steelblock_1" },
		--{ "lord_homedecor:dishwasher" },
    --},
--})

--minetest.register_craft( {
    --output = "lord_homedecor:dishwasher_marble",
    --recipe = {
		--{ "building_blocks:slab_marble" },
		--{ "lord_homedecor:dishwasher" },
    --},
--})

--minetest.register_craft( {
    --output = "lord_homedecor:dishwasher_marble",
    --recipe = {
		--{ "technic:slab_marble_1" },
		--{ "lord_homedecor:dishwasher" },
    --},
--})

--minetest.register_craft( {
    --output = "lord_homedecor:dishwasher_granite",
    --recipe = {
		--{ "technic:slab_granite_1" },
		--{ "lord_homedecor:dishwasher" },
    --},
--})

---- paintings

--minetest.register_craft({
    --output = "lord_homedecor:blank_canvas",
    --recipe = {
		--{ "", "group:stick", "" },
		--{ "group:stick", "wool:white", "group:stick" },
		--{ "", "group:stick", "" },
    --}
--})

--local painting_patterns = {
	--[1] = {	{ "brown", "red", "brown" },
	 		--{ "dark_green", "red", "green" } },

	--[2] = {	{ "green", "yellow", "green" },
	 		--{ "green", "yellow", "green" } },

	--[3] = {	{ "green", "pink", "green" },
	 		--{ "brown", "pink", "brown" } },

	--[4] = {	{ "black", "orange", "grey" },
	 		--{ "dark_green", "orange", "orange" } },

	--[5] = {	{ "blue", "orange", "yellow" },
	 		--{ "green", "red", "brown" } },

	--[6] = {	{ "green", "red", "orange" },
	 		--{ "orange", "yellow", "green" } },

	--[7] = {	{ "blue", "dark_green", "dark_green" },
	 		--{ "green", "grey", "green" } },

	--[8] = {	{ "blue", "blue", "blue" },
	 		--{ "green", "green", "green" } },

	--[9] = {	{ "blue", "blue", "dark_green" },
	 		--{ "green", "grey", "dark_green" } },

	--[10] = { { "green", "white", "green" },
	 		 --{ "dark_green", "white", "dark_green" } },

	--[11] = { { "blue", "white", "blue" },
	 		 --{ "blue", "grey", "dark_green" } },

	--[12] = { { "green", "green", "green" },
	 		 --{ "grey", "grey", "green" } },

	--[13] = { { "blue", "blue", "grey" },
	 		 --{ "dark_green", "white", "white" } },

	--[14] = { { "red", "yellow", "blue" },
	 		 --{ "blue", "green", "violet" } },

	--[15] = { { "blue", "yellow", "blue" },
	 		 --{ "black", "black", "black" } },

	--[16] = { { "red", "orange", "blue" },
	 		 --{ "black", "dark_grey", "grey" } },

	--[17] = { { "orange", "yellow", "orange" },
	 		 --{ "black", "black", "black" } },

	--[18] = { { "grey", "dark_green", "grey" },
	 		 --{ "white", "white", "white" } },

	--[19] = { { "white", "brown", "green" },
	 		 --{ "green", "brown", "brown" } },

	--[20] = { { "blue", "blue", "blue" },
	 		 --{ "red", "brown", "grey" } }
--}

--for i,recipe in pairs(painting_patterns) do

	--local item1 = "dye:"..recipe[1][1]
	--local item2 = "dye:"..recipe[1][2]
	--local item3 = "dye:"..recipe[1][3]
	--local item4 = "dye:"..recipe[2][1]
	--local item5 = "dye:"..recipe[2][2]
	--local item6 = "dye:"..recipe[2][3]

	--minetest.register_craft({
		--output = "lord_homedecor:painting_"..i,
		--recipe = {
			--{ item1, item2, item3 },
			--{ item4, item5, item6 },
			--{"", "lord_homedecor:blank_canvas", "" }
		--}
	--})
--end

---- more misc stuff here

--minetest.register_craft({
        --output = "lord_homedecor:chimney 2",
        --recipe = {
			--{ "default:clay_brick", "", "default:clay_brick" },
			--{ "default:clay_brick", "", "default:clay_brick" },
			--{ "default:clay_brick", "", "default:clay_brick" },
        --},
--})

--minetest.register_craft({
        --output = "lord_homedecor:fishtank",
        --recipe = {
			--{ "lord_homedecor:plastic_sheeting", "lord_homedecor:glowlight_small_cube_white", "lord_homedecor:plastic_sheeting" },
			--{ "default:glass", "bucket:bucket_water", "default:glass" },
			--{ "default:glass", "building_blocks:gravel_spread", "default:glass" },
        --},
	--replacements = { {"bucket:bucket_water", "bucket:bucket_empty"} }
--})

--minetest.register_craft({
    --output = "lord_homedecor:towel_rod",
    --recipe = {
		--{ "group:wood", "group:stick", "group:wood" },
		--{ "", "building_blocks:terrycloth_towel", "" },
    --},
--})

--minetest.register_craft({
    --output = "lord_homedecor:toilet_paper",
    --recipe = {
		--{ "", "default:paper", "default:paper" },
		--{ "group:wood", "group:stick", "default:paper" },
		--{ "", "default:paper", "default:paper" },
    --},
--})

--minetest.register_craft({
    --output = "lord_homedecor:medicine_cabinet",
    --recipe = {
		--{ "group:stick", "default:glass", "group:stick" },
		--{ "group:stick", "default:glass", "group:stick" },
		--{ "group:stick", "default:glass", "group:stick" }
    --},
--})

--minetest.register_craft({
    --output = "lord_homedecor:cardboard_box 2",
    --recipe = {
		--{ "default:paper", "", "default:paper" },
		--{ "default:paper", "default:paper", "default:paper" },
    --},
--})

--minetest.register_craft({
    --output = "lord_homedecor:cardboard_box_big 2",
    --recipe = {
		--{ "default:paper", "", "default:paper" },
		--{ "default:paper", "", "default:paper" },
		--{ "default:paper", "default:paper", "default:paper" },
    --},
--})

--minetest.register_craft({
    --output = "lord_homedecor:desk",
    --recipe = {
		--{ "stairs:slab_wood", "stairs:slab_wood", "stairs:slab_wood" },
		--{ "lord_homedecor:drawer_small", "default:wood", "default:wood" },
		--{ "lord_homedecor:drawer_small", "", "default:wood" },
    --},
--})

--minetest.register_craft({
    --output = "lord_homedecor:desk",
    --recipe = {
		--{ "moreblocks:slab_wood", "moreblocks:slab_wood", "moreblocks:slab_wood" },
		--{ "lord_homedecor:drawer_small", "default:wood", "default:wood" },
		--{ "lord_homedecor:drawer_small", "", "default:wood" },
    --},
--})

--minetest.register_craft({
    --output = "lord_homedecor:filing_cabinet",
    --recipe = {
		--{ "", "default:wood", "" },
		--{ "default:wood", "lord_homedecor:drawer_small", "default:wood" },
		--{ "", "default:wood", "" },
    --},
--})

--minetest.register_craft({
    --output = "lord_homedecor:analog_clock_plastic 2",
    --recipe = {
		--{ "lord_homedecor:plastic_sheeting", "dye:black", "lord_homedecor:plastic_sheeting" },
		--{ "lord_homedecor:plastic_sheeting", "lord_homedecor:ic", "lord_homedecor:plastic_sheeting" },
		--{ "lord_homedecor:plastic_sheeting", "dye:black", "lord_homedecor:plastic_sheeting" },
    --},
--})

--minetest.register_craft({
    --output = "lord_homedecor:analog_clock_wood 2",
    --recipe = {
		--{ "group:stick", "dye:black", "group:stick" },
		--{ "group:stick", "lord_homedecor:ic", "group:stick" },
		--{ "group:stick", "dye:black", "group:stick" },
    --},
--})

--minetest.register_craft({
    --output = "lord_homedecor:digital_clock 2",
    --recipe = {
		--{ "lord_homedecor:plastic_sheeting", "default:paper", "lord_homedecor:plastic_sheeting" },
		--{ "lord_homedecor:plastic_sheeting", "lord_homedecor:ic", "lord_homedecor:plastic_sheeting" },
		--{ "lord_homedecor:plastic_sheeting", "lord_homedecor:power_crystal", "lord_homedecor:plastic_sheeting" },
    --},
--})

--minetest.register_craft({
    --output = "lord_homedecor:alarm_clock",
    --recipe = {
		--{ "lord_homedecor:plastic_sheeting", "lord_homedecor:speaker_driver", "lord_homedecor:plastic_sheeting" },
		--{ "lord_homedecor:plastic_sheeting", "lord_homedecor:digital_clock", "lord_homedecor:plastic_sheeting" },
		--{ "lord_homedecor:plastic_sheeting", "lord_homedecor:power_crystal", "lord_homedecor:plastic_sheeting" },
    --},
--})

--minetest.register_craft({
    --output = "lord_homedecor:air_conditioner",
    --recipe = {
		--{ "default:steel_ingot", "building_blocks:grate", "default:steel_ingot" },
		--{ "default:steel_ingot", "lord_homedecor:fan_blades", "lord_homedecor:motor" },
		--{ "default:steel_ingot", "lord_homedecor:motor", "default:steel_ingot" },
    --},
--})

--minetest.register_craft({
    --output = "lord_homedecor:air_conditioner",
    --recipe = {
		--{ "default:steel_ingot", "building_blocks:grate", "default:steel_ingot" },
		--{ "default:steel_ingot", "technic:motor", "default:steel_ingot" },
		--{ "default:steel_ingot", "technic:motor", "default:steel_ingot" },
    --},
--})

--minetest.register_craft({
    --output = "lord_homedecor:ceiling_fan",
    --recipe = {
		--{ "lord_homedecor:motor" },
		--{ "lord_homedecor:fan_blades" },
		--{ "lord_homedecor:glowlight_small_cube_white" }
	--}
--})

--minetest.register_craft({
    --output = "lord_homedecor:ceiling_fan",
    --recipe = {
		--{ "technic:motor" },
		--{ "lord_homedecor:fan_blades" },
		--{ "lord_homedecor:glowlight_small_cube_white" }
	--}
--})

--minetest.register_craft({
    --output = "lord_homedecor:welcome_mat_grey 2",
    --recipe = {
		--{ "", "dye:black", "" },
		--{ "wool:grey", "wool:grey", "wool:grey" },
    --},
--})

--minetest.register_craft({
    --output = "lord_homedecor:welcome_mat_brown 2",
    --recipe = {
		--{ "", "dye:black", "" },
		--{ "wool:brown", "wool:brown", "wool:brown" },
    --},
--})

--minetest.register_craft({
    --output = "lord_homedecor:welcome_mat_green 2",
    --recipe = {
		--{ "", "dye:white", "" },
		--{ "wool:dark_green", "wool:dark_green", "wool:dark_green" },
    --},
--})

--minetest.register_craft({
	--type = "shapeless",
    --output = "lord_homedecor:window_plain 8",
    --recipe = {
		--"dye:white",
		--"dye:white",
		--"dye:white",
		--"dye:white",
		--"building_blocks:woodglass"
    --}
--})

--minetest.register_craft({
	--type = "shapeless",
    --output = "lord_homedecor:window_quartered",
    --recipe = {
		--"dye:white",
		--"group:stick",
		--"group:stick",
		--"lord_homedecor:window_plain"
    --}
--})

--minetest.register_craft({
    --output = "lord_homedecor:vcr 2",
    --recipe = {
		--{ "lord_homedecor:ic", "default:steel_ingot", "lord_homedecor:plastic_sheeting" },
		--{ "default:iron_lump", "default:iron_lump", "default:iron_lump" },
		--{ "lord_homedecor:plastic_sheeting", "", "lord_homedecor:plastic_sheeting" },
    --},
--})

--minetest.register_craft({
    --output = "lord_homedecor:dvd_player 2",
    --recipe = {
		--{ "", "lord_homedecor:plastic_sheeting", "" },
		--{ "default:obsidian_glass", "lord_homedecor:motor", "lord_homedecor:motor" },
		--{ "default:mese_crystal_fragment", "lord_homedecor:ic", "lord_homedecor:power_crystal" },
    --},
--})

--minetest.register_craft({
    --output = "lord_homedecor:dvd_player 2",
    --recipe = {
		--{ "", "lord_homedecor:plastic_sheeting", "" },
		--{ "default:obsidian_glass", "technic:motor", "technic:motor" },
		--{ "default:mese_crystal_fragment", "lord_homedecor:ic", "lord_homedecor:power_crystal" },
    --},
--})

--minetest.register_craft({
	--type = "shapeless",
    --output = "lord_homedecor:dvd_vcr",
    --recipe = {
		--"lord_homedecor:vcr",
		--"lord_homedecor:dvd_player"
    --},
--})

--minetest.register_craft({
    --output = "lord_homedecor:blinds_thin",
    --recipe = {
		--{ "group:stick", "lord_homedecor:plastic_sheeting", "group:stick" },
		--{ "farming:string", "lord_homedecor:plastic_strips", "" },
		--{ "", "lord_homedecor:plastic_strips", "" },
    --},
--})

--minetest.register_craft({
    --output = "lord_homedecor:blinds_thick",
    --recipe = {
		--{ "group:stick", "lord_homedecor:plastic_sheeting", "group:stick" },
		--{ "farming:string", "lord_homedecor:plastic_strips", "lord_homedecor:plastic_strips" },
		--{ "", "lord_homedecor:plastic_strips", "lord_homedecor:plastic_strips" },
    --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:openframe_bookshelf",
        --recipe = {
			--{"group:wood", "", "group:wood"},
			--{"default:book", "default:book", "default:book"},
			--{"group:wood", "", "group:wood"},
        --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:desk_fan",
        --recipe = {
			--{"default:steel_ingot", "lord_homedecor:fan_blades", "lord_homedecor:motor"},
			--{"", "default:steel_ingot", ""}
        --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:space_heater",
        --recipe = {
			--{"lord_homedecor:plastic_sheeting", "lord_homedecor:heating_element", "lord_homedecor:plastic_sheeting"},
			--{"lord_homedecor:plastic_sheeting", "lord_homedecor:fan_blades", "lord_homedecor:motor"},
			--{"lord_homedecor:plastic_sheeting", "lord_homedecor:heating_element", "lord_homedecor:plastic_sheeting"}
        --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:radiator",
        --recipe = {
			--{ "default:steel_ingot", "lord_homedecor:heating_element", "default:steel_ingot" },
			--{ "lord_homedecor:ic", "lord_homedecor:heating_element", "" },
			--{ "default:steel_ingot", "lord_homedecor:heating_element", "default:steel_ingot" }
        --},
--})

---- bathroom/kitchen tiles

--local color_pairings = {
	--{ "grey",		"white",		"1" },
	--{ "dark_grey",	"white",		"2" },
	--{ "black",		"white",		"3" },
	--{ "black",		"dark_grey",	"4" },
	--{ "red",		"white",		"red" },
	--{ "green",		"white",		"green" },
	--{ "blue",		"white",		"blue" },
	--{ "yellow",		"white",		"yellow" },
	--{ "brown",		"white",		"tan" }
--}

--for i in ipairs(color_pairings) do
	--local dye1 = color_pairings[i][1]
	--local dye2 = color_pairings[i][2]
	--local result = color_pairings[i][3]
	--minetest.register_craft( {
		    --output = "lord_homedecor:tiles_"..result.." 2",
		    --recipe = {
				--{ "group:marble", "dye:"..dye1 },
				--{ "group:marble", "dye:"..dye2 }
		    --},
	--})
--end

---- misc electrical

--minetest.register_craft( {
        --output = "lord_homedecor:power_outlet",
        --recipe = {
			--{"lord_homedecor:plastic_sheeting", "lord_homedecor:copper_strip"},
			--{"lord_homedecor:plastic_sheeting", ""},
			--{"lord_homedecor:plastic_sheeting", "lord_homedecor:copper_strip"}
        --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:light_switch",
        --recipe = {
			--{"", "lord_homedecor:plastic_sheeting", "lord_homedecor:copper_strip"},
			--{"lord_homedecor:plastic_sheeting", "lord_homedecor:plastic_sheeting", "lord_homedecor:copper_strip"},
			--{"", "lord_homedecor:plastic_sheeting", "lord_homedecor:copper_strip"}
        --},
--})

---- doghouse

--minetest.register_craft( {
        --output = "lord_homedecor:doghouse",
        --recipe = {
			--{"lord_homedecor:shingles_terracotta", "lord_homedecor:shingles_terracotta", "lord_homedecor:shingles_terracotta"},
			--{"group:wood", "", "group:wood"},
			--{"group:wood", "building_blocks:terrycloth_towel", "group:wood"}
        --},
--})

---- japanese walls and mat

--minetest.register_craft( {
        --output = "lord_homedecor:japanese_wall_top",
        --recipe = {
			--{"group:stick", "default:paper"},
			--{"default:paper", "group:stick"},
			--{"group:stick", "default:paper"}
        --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:japanese_wall_top",
        --recipe = {
			--{"default:paper", "group:stick"},
			--{"group:stick", "default:paper"},
			--{"default:paper", "group:stick"}
        --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:japanese_wall_middle",
        --recipe = {
			--{"lord_homedecor:japanese_wall_top"}
        --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:japanese_wall_bottom",
        --recipe = {
			--{"lord_homedecor:japanese_wall_middle"}
        --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:japanese_wall_top",
        --recipe = {
			--{"lord_homedecor:japanese_wall_bottom"}
        --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:tatami_mat",
        --recipe = {
			--{"farming:sheaf_wheat", "farming:sheaf_wheat", "farming:sheaf_wheat"}
        --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:wardrobe",
        --recipe = {
			--{ "lord_homedecor:drawer_small", "lord_homedecor:kitchen_cabinet" },
			--{ "lord_homedecor:drawer_small", "default:wood" },
			--{ "lord_homedecor:drawer_small", "default:wood" }
        --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:pool_table",
        --recipe = {
			--{ "wool:dark_green", "wool:dark_green", "wool:dark_green" },
			--{ "building_blocks:hardwood", "building_blocks:hardwood", "building_blocks:hardwood" },
			--{ "building_blocks:slab_hardwood", "", "building_blocks:slab_hardwood" }
        --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:trash_can 3",
        --recipe = {
			--{ "lord_homedecor:steel_wire", "", "lord_homedecor:steel_wire" },
			--{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" }
        --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:telephone",
        --recipe = {
			--{ "lord_homedecor:speaker_driver", "lord_homedecor:copper_wire", "lord_homedecor:speaker_driver" },
			--{ "lord_homedecor:plastic_sheeting", "default:steel_ingot", "lord_homedecor:plastic_sheeting" },
			--{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" }
        --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:cobweb_corner 5",
        --recipe = {
			--{ "farming:string", "", "farming:string" },
			--{ "", "farming:string", "" },
			--{ "farming:string", "", "farming:string" }
        --},
--})

minetest.register_craft( {
        output = "lord_homedecor:well",
        recipe = {
			{ "lord_homedecor:shingles_wood", "lord_homedecor:shingles_wood", "lord_homedecor:shingles_wood" },
			{ "group:wood", "group:stick", "group:wood" },
			{ "default:cobble", "bucket:bucket_water", "default:cobble" }
        },
})

--minetest.register_craft( {
        --output = "lord_homedecor:coat_tree",
        --recipe = {
			--{ "group:stick", "group:stick", "group:stick" },
			--{ "", "group:stick", "" },
			--{ "", "group:wood", "" }
        --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:coatrack_wallmount",
        --recipe = {
			--{ "group:stick", "lord_homedecor:curtainrod_wood", "group:stick" },
        --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:doorbell",
        --recipe = {
			--{ "lord_homedecor:light_switch", "lord_homedecor:power_crystal", "lord_homedecor:speaker_driver" }
        --},
--})


minetest.register_craft( {
        output = "lord_homedecor:bench_large_1",
        recipe = {
			{ "group:wood", "group:wood", "group:wood" },
			{ "group:wood", "group:wood", "group:wood" },
			{ "lord_homedecor:pole_wrought_iron", "", "lord_homedecor:pole_wrought_iron" }
        },
})

minetest.register_craft( {
        output = "lord_homedecor:bench_large_2_left",
        recipe = {
			{ "lord_homedecor:shutter_oak", "lord_homedecor:shutter_oak", "lord_homedecor:shutter_oak" },
			{ "group:wood", "group:wood", "group:wood" },
			{ "stairs:slab_wood", "", "stairs:slab_wood" }
        },
})

minetest.register_craft( {
        output = "lord_homedecor:bench_large_2_left",
        recipe = {
			{ "lord_homedecor:shutter_oak", "lord_homedecor:shutter_oak", "lord_homedecor:shutter_oak" },
			{ "group:wood", "group:wood", "group:wood" },
			{ "stairs:slab_junglewood", "", "stairs:slab_junglewood" }
        },
})

--minetest.register_craft( {
        --output = "lord_homedecor:kitchen_faucet",
        --recipe = {
			--{ "", "default:steel_ingot" },
			--{ "default:steel_ingot", "" },
			--{ "lord_homedecor:taps", "" }
        --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:cutlery_set",
        --recipe = {
			--{ "", "vessels:drinking_glass", "" },
			--{ "lord_homedecor:steel_strip", "building_blocks:slab_marble", "lord_homedecor:steel_strip" },
        --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:cutlery_set",
        --recipe = {
			--{ "", "vessels:drinking_glass", "" },
			--{ "lord_homedecor:steel_strip", "building_blocks:micro_marble_1", "lord_homedecor:steel_strip" },
        --},
--})

minetest.register_craft( {
        output = "lord_homedecor:simple_bench",
        recipe = {
			{ "stairs:slab_wood", "stairs:slab_wood", "stairs:slab_wood" },
			{ "stairs:slab_wood", "", "stairs:slab_wood" }
        },
})

--minetest.register_craft( {
        --output = "lord_homedecor:simple_bench",
        --recipe = {
			--{ "moreblocks:slab_wood", "moreblocks:slab_wood", "moreblocks:slab_wood" },
			--{ "moreblocks:slab_wood", "", "moreblocks:slab_wood" }
        --},
--})

--local bedcolors = {
	--{ "red", "red"},
	--{ "orange", "orange" },
	--{ "yellow", "yellow"},
	--{ "green", "dark_green"},
	--{ "blue", "blue"},
	--{ "violet", "violet"},
	--{ "pink", "pink"},
	--{ "darkgrey", "dark_grey"},
	--{ "brown", "brown" },
--}

--for c in ipairs(bedcolors) do
	--local color = bedcolors[c][1]
	--local woolcolor = bedcolors[c][2]

	--minetest.register_craft( {
		--output = "lord_homedecor:bed_"..color.."_regular",
		--recipe = {
			--{ "group:stick", "", "group:stick" },
			--{ "wool:white", "wool:"..woolcolor, "wool:"..woolcolor },
			--{ "group:wood", "", "group:wood" },
		--},
	--})

	--minetest.register_craft( {
		--output = "lord_homedecor:bed_"..color.."_kingsize",
		--recipe = {
			--{ "lord_homedecor:bed_"..color.."_regular", "lord_homedecor:bed_"..color.."_regular" }
		--},
	--})

--end

--minetest.register_craft( {
        --output = "lord_homedecor:bottle_green",
        --recipe = {
			--{ "vessels:glass_bottle", "dye:green" }
        --},
--})

--minetest.register_craft( {
        --output = "lord_homedecor:bottle_brown",
        --recipe = {
			--{ "vessels:glass_bottle", "dye:brown" }
        --},
--})

--if not minetest.get_modpath("glooptest") then

	--minetest.register_craft({
		--output = "glooptest:chainlink 12",
		--recipe = {
		    --{"", "default:steel_ingot", "default:steel_ingot"},
		    --{ "default:steel_ingot", "", "default:steel_ingot" },
		    --{ "default:steel_ingot", "default:steel_ingot", "" },
		--},
	--})

--end

--minetest.register_alias("lord_homedecor:chainlink_steel", "glooptest:chainlink")

--minetest.register_craft({
	--output = "lord_homedecor:chains 4",
	--recipe = {
	    --{ "default:steel_ingot", "", "default:steel_ingot"},
	    --{ "glooptest:chainlink", "", "glooptest:chainlink" },
	    --{ "glooptest:chainlink", "", "glooptest:chainlink" },
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:chainlink_brass 12",
	--recipe = {
	    --{"", "technic:brass_ingot", "technic:brass_ingot"},
	    --{ "technic:brass_ingot", "", "technic:brass_ingot" },
	    --{ "technic:brass_ingot", "technic:brass_ingot", "" },
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:coffee_maker",
	--recipe = {
	    --{"lord_homedecor:plastic_sheeting", "bucket:bucket_water", "lord_homedecor:plastic_sheeting"},
	    --{"lord_homedecor:plastic_sheeting", "default:glass", "lord_homedecor:plastic_sheeting"},
	    --{"lord_homedecor:plastic_sheeting", "lord_homedecor:heating_element", "lord_homedecor:plastic_sheeting"}
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:dartboard",
	--recipe = {
	    --{"dye:black", "lord_homedecor:plastic_sheeting", "dye:white"},
	    --{"lord_homedecor:plastic_sheeting", "lord_homedecor:plastic_sheeting", "lord_homedecor:plastic_sheeting"},
	    --{"dye:dark_green", "lord_homedecor:plastic_sheeting", "dye:red"}
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:piano",
	--recipe = {
		--{ "", "lord_homedecor:steel_wire", "building_blocks:hardwood" },
		--{ "lord_homedecor:plastic_strips", "lord_homedecor:steel_wire", "building_blocks:hardwood" },
		--{ "technic:brass_ingot", "default:steelblock", "building_blocks:hardwood" }
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:toaster",
	--recipe = {
		--{ "default:steel_ingot", "lord_homedecor:heating_element", "default:steel_ingot" },
		--{ "default:steel_ingot", "lord_homedecor:heating_element", "default:steel_ingot" }
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:deckchair",
	--recipe = {
		--{ "group:stick", "building_blocks:terrycloth_towel", "group:stick" },
		--{ "group:stick", "building_blocks:terrycloth_towel", "group:stick" },
		--{ "group:stick", "building_blocks:terrycloth_towel", "group:stick" }
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:deckchair_striped_blue",
	--type = "shapeless",
	--recipe = {
		--"lord_homedecor:deckchair",
		--"dye:blue"
	--}
--})

--minetest.register_craft({
	--output = "lord_homedecor:office_chair_basic",
	--recipe = {
		--{ "", "", "wool:black" },
		--{ "", "wool:black", "default:steel_ingot" },
		--{ "group:stick", "lord_homedecor:pole_wrought_iron", "group:stick" }
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:office_chair_upscale",
	--recipe = {
		--{ "dye:black", "building_blocks:sticks", "group:wool" },
		--{ "lord_homedecor:plastic_sheeting", "group:wool", "default:steel_ingot" },
		--{ "building_blocks:sticks", "lord_homedecor:pole_wrought_iron", "building_blocks:sticks" }
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:wall_shelf 2",
	--recipe = {
		--{ "lord_homedecor:wood_table_small_square", "lord_homedecor:curtainrod_wood", "lord_homedecor:curtainrod_wood" },
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:trophy 3",
	--recipe = {
		--{ "default:gold_ingot","","default:gold_ingot" },
		--{ "","default:gold_ingot","" },
		--{ "group:wood","default:gold_ingot","group:wood" }
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:grandfather_clock",
	--recipe = {
		--{ "building_blocks:slab_hardwood","lord_homedecor:analog_clock_wood","building_blocks:slab_hardwood" },
		--{ "building_blocks:slab_hardwood","technic:brass_ingot","building_blocks:slab_hardwood" },
		--{ "building_blocks:slab_hardwood","technic:brass_ingot","building_blocks:slab_hardwood" }
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:sportbench",
	--recipe = {
		--{ "stairs:slab_steelblock","lord_homedecor:pole_wrought_iron","stairs:slab_steelblock" },
		--{ "default:steel_ingot","wool:black","default:steel_ingot" },
		--{ "default:steel_ingot","wool:black","default:steel_ingot" }
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:skateboard",
	--recipe = {
		--{ "dye:yellow","dye:green","dye:blue" },
		--{ "lord_homedecor:wood_table_small_square","lord_homedecor:wood_table_small_square","lord_homedecor:wood_table_small_square" },
		--{ "default:steel_ingot","","default:steel_ingot" }
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:copper_pans",
	--recipe = {
		--{ "lord_homedecor:copper_strip","","lord_homedecor:copper_strip" },
		--{ "default:copper_ingot","","default:copper_ingot" },
		--{ "default:copper_ingot","","default:copper_ingot" }
	--},
--})

minetest.register_craft( {
        output = "lord_homedecor:window_flowerbox",
        recipe = {
                { "lord_homedecor:roof_tile_terracotta", "default:dirt", "lord_homedecor:roof_tile_terracotta" },
                { "lord_homedecor:roof_tile_terracotta", "lord_homedecor:roof_tile_terracotta", "lord_homedecor:roof_tile_terracotta" },
        },
})

--minetest.register_craft({
    --output = "lord_homedecor:paper_towel",
    --recipe = {
		--{ "lord_homedecor:toilet_paper", "lord_homedecor:toilet_paper" }
    --},
--})

minetest.register_craft({
	output = "lord_homedecor:stonepath 16",
	recipe = {
		{ "stairs:slab_stone","","stairs:slab_stone" },
		{ "","stairs:slab_stone","" },
		{ "stairs:slab_stone","","stairs:slab_stone" }
	},
})

--minetest.register_craft({
	--output = "lord_homedecor:stonepath 16",
	--recipe = {
		--{ "lottblocks:slab_stone","","lottblocks:slab_stone" },
		--{ "","lottblocks:slab_stone","" },
		--{ "lottblocks:slab_stone","","lottblocks:slab_stone" }
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:stonepath 3",
	--recipe = {
		--{ "moreblocks:micro_stone_1","","moreblocks:micro_stone_1" },
		--{ "","moreblocks:micro_stone_1","" },
		--{ "moreblocks:micro_stone_1","","moreblocks:micro_stone_1" }
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:barbecue",
	--recipe = {
		--{ "","lord_homedecor:fence_chainlink","" },
		--{ "default:steel_ingot","fake_fire:embers","default:steel_ingot" },
		--{ "lord_homedecor:pole_wrought_iron","default:steel_ingot","lord_homedecor:pole_wrought_iron" }
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:beer_tap",
	--recipe = {
		--{ "group:stick","default:steel_ingot","group:stick" },
		--{ "lord_homedecor:kitchen_faucet","default:steel_ingot","lord_homedecor:kitchen_faucet" },
		--{ "default:steel_ingot","default:steel_ingot","default:steel_ingot" }
	--},
--})

minetest.register_craft({
	output = "lord_homedecor:swing",
	recipe = {
		{ "farming:string","","farming:string" },
		{ "farming:string","","farming:string" },
		{ "farming:string","stairs:slab_wood","farming:string" }
	},
})

--minetest.register_craft({
	--output = "lord_homedecor:swing",
	--recipe = {
		--{ "farming:string","","farming:string" },
		--{ "farming:string","","farming:string" },
		--{ "farming:string","moreblocks:slab_wood","farming:string" }
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:swing",
	--recipe = {
		--{ "farming:string","","farming:string" },
		--{ "farming:string","","farming:string" },
		--{ "farming:string","moreblocks:panel_wood_1","farming:string" }
	--},
--})

--local bookcolors = {
	--"red",
	--"green",
	--"blue",
	--"violet",
	--"grey",
	--"brown"
--}

--for _, color in ipairs(bookcolors) do
	--minetest.register_craft({
		--type = "shapeless",
		--output = "lord_homedecor:book_"..color,
		--recipe = {
			--"dye:"..color,
			--"default:book"
		--},
	--})
--end

--minetest.register_craft({
	--output = "lord_homedecor:door_japanese_closed",
	--recipe = {
		--{ "lord_homedecor:japanese_wall_top" },
		--{ "lord_homedecor:japanese_wall_bottom" }
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:calendar",
	--recipe = {
		--{ "","dye:red","" },
		--{ "","dye:black","" },
		--{ "","default:paper","" }
	--},
--})

--minetest.register_craft({
	--type = "shapeless",
	--output = "lord_homedecor:4_bottles_brown",
	--recipe = {
		--"lord_homedecor:bottle_brown",
		--"lord_homedecor:bottle_brown",
		--"lord_homedecor:bottle_brown",
		--"lord_homedecor:bottle_brown"
	--},
--})

--minetest.register_craft({
	--type = "shapeless",
	--output = "lord_homedecor:4_bottles_green",
	--recipe = {
		--"lord_homedecor:bottle_green",
		--"lord_homedecor:bottle_green",
		--"lord_homedecor:bottle_green",
		--"lord_homedecor:bottle_green"
	--},
--})

--minetest.register_craft({
	--type = "shapeless",
	--output = "lord_homedecor:4_bottles_multi",
	--recipe = {
		--"lord_homedecor:bottle_brown",
		--"lord_homedecor:bottle_brown",
		--"lord_homedecor:bottle_green",
		--"lord_homedecor:bottle_green",
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:wine_rack",
	--recipe = {
		--{ "lord_homedecor:4_bottles_brown", "group:wood", "lord_homedecor:4_bottles_brown" },
		--{ "lord_homedecor:4_bottles_brown", "group:wood", "lord_homedecor:4_bottles_brown" },
		--{ "lord_homedecor:4_bottles_brown", "group:wood", "lord_homedecor:4_bottles_brown" },
	--},
--})

--local picture_dyes = {
	--{"dye:brown", "dye:green"}, -- the figure sitting by the tree, wielding a pick
	--{"dye:green", "dye:blue"}	-- the "family photo"
--}

--for i in ipairs(picture_dyes) do
	--minetest.register_craft({
		--output = "lord_homedecor:picture_frame"..i,
		--recipe = {
			--{ picture_dyes[i][1], picture_dyes[i][2] },
			--{ "lord_homedecor:blank_canvas", "group:stick" },
		--},
	--})
--end

--local dlamp_colors = { "red","blue","green","violet" }

--for _, color in ipairs(dlamp_colors) do
	--minetest.register_craft({
		--output = "lord_homedecor:desk_lamp_"..color,
		--recipe = {
			--{ "", "lord_homedecor:steel_strip", "lord_homedecor:glowlight_small_cube_white" },
			--{ "", "lord_homedecor:copper_wire", "" },
			--{ "lord_homedecor:plastic_sheeting", "dye:"..color, "lord_homedecor:plastic_sheeting" },
		--},
	--})
--end

--minetest.register_craft({
	--output = "lord_homedecor:hanging_lantern 2",
	--recipe = {
		--{ "default:iron_lump", "default:iron_lump", "" },
		--{ "default:iron_lump", "lord_homedecor:lattice_lantern_large", "" },
		--{ "default:iron_lump", "", "" },
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:ceiling_lantern 2",
	--recipe = {
		--{ "default:iron_lump", "default:iron_lump", "default:iron_lump" },
		--{ "default:iron_lump", "lord_homedecor:lattice_lantern_large", "default:iron_lump" },
		--{ "", "default:iron_lump", "" },
	--},
--})

minetest.register_craft({
	output = "lord_homedecor:wall_lamp 2",
	recipe = {
		{ "default:glass", "default:torch", "default:glass" },
		{ "default:iron_lump", "group:stick", "" },
		{ "default:iron_lump", "group:stick", "" },
	},
})

--minetest.register_craft({
	--output = "lord_homedecor:desk_globe",
	--recipe = {
		--{ "group:stick", "lord_homedecor:plastic_sheeting", "dye:green" },
		--{ "group:stick", "lord_homedecor:plastic_sheeting", "lord_homedecor:plastic_sheeting" },
		--{ "group:stick", "stairs:slab_wood", "dye:blue" }
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:desk_globe",
	--recipe = {
		--{ "group:stick", "lord_homedecor:plastic_sheeting", "dye:green" },
		--{ "group:stick", "lord_homedecor:plastic_sheeting", "lord_homedecor:plastic_sheeting" },
		--{ "group:stick", "moreblocks:slab_wood", "dye:blue" }
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:tool_cabinet",
	--recipe = {
		--{ "lord_homedecor:motor", "default:axe_steel", "default:pick_steel" },
		--{ "default:steel_ingot", "lord_homedecor:drawer_small", "default:steel_ingot" },
		--{ "default:steel_ingot", "lord_homedecor:drawer_small", "default:steel_ingot" }
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:bathroom_set",
	--recipe = {
		--{ "", "lord_homedecor:glass_table_small_round", "" },
		--{ "lord_homedecor:plastic_sheeting", "lord_homedecor:glass_table_small_round", "lord_homedecor:plastic_sheeting" },
		--{ "group:stick", "lord_homedecor:plastic_sheeting", "group:stick" }
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:trash_can_green",
	--recipe = {
		--{ "lord_homedecor:plastic_sheeting", "", "lord_homedecor:plastic_sheeting" },
		--{ "lord_homedecor:plastic_sheeting", "dye:green", "lord_homedecor:plastic_sheeting" },
		--{ "lord_homedecor:plastic_sheeting", "lord_homedecor:plastic_sheeting", "lord_homedecor:plastic_sheeting" }
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:ceiling_lamp",
	--recipe = {
		--{ "", "technic:brass_ingot", ""},
		--{ "", "lord_homedecor:chainlink_brass", ""},
		--{ "default:glass", "lord_homedecor:glowlight_small_cube_white", "default:glass"}
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:ceiling_lamp",
	--recipe = {
		--{ "", "chains:chain_top_brass", ""},
		--{ "default:glass", "lord_homedecor:glowlight_small_cube_white", "default:glass"}
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:spiral_staircase",
	--recipe = {
		--{ "default:steelblock", "lord_homedecor:pole_wrought_iron", "" },
		--{ "", "lord_homedecor:pole_wrought_iron", "default:steelblock" },
		--{ "default:steelblock", "lord_homedecor:pole_wrought_iron", "" }
	--},
--})

--minetest.register_craft({
	--output = "lord_homedecor:soda_machine",
	--recipe = {
		--{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		--{"default:steel_ingot", "dye:red", "default:steel_ingot"},
		--{"default:steel_ingot", "default:copperblock", "default:steel_ingot"},
	--},
--})

--minetest.register_craft({
	--type = "shapeless",
	--output = "lord_homedecor:coin 5",
	--recipe = {"moreblocks:micro_goldblock_1", "default:sword_stone"}
--})

--minetest.register_craft({
	--type = "shapeless",
	--output = "lord_homedecor:coin 15",
	--recipe = {"default:gold_ingot", "default:sword_steel"}
--})

--minetest.register_craft({
	--type = "shapeless",
	--output = "lord_homedecor:coin 50",
	--recipe = {"default:goldblock", "default:sword_mese"}
--})

minetest.register_craft({
	output = "lord_homedecor:lattice_wood 8",
	recipe = {
		{"group:stick", "group:wood", "group:stick"},
		{"group:wood", "", "group:wood"},
		{"group:stick", "group:wood", "group:stick"},
	},
})

minetest.register_craft({
	output = "lord_homedecor:lattice_white_wood 8",
	recipe = {
		{"group:stick", "group:wood", "group:stick"},
		{"group:wood", "dye:white", "group:wood"},
		{"group:stick", "group:wood", "group:stick"},
	},
})

minetest.register_craft({
	output = "lord_homedecor:lattice_wood_vegetal 8",
	recipe = {
		{"group:stick", "group:wood", "group:stick"},
		{"group:wood", "lottplants:lebethronleaf", "group:wood"},
		{"group:stick", "group:wood", "group:stick"},
	},
})

minetest.register_craft({
	output = "lord_homedecor:lattice_white_wood_vegetal 8",
	recipe = {
		{"group:stick", "group:wood", "group:stick"},
		{"group:wood", "lottplants:lebethronleaf", "group:wood"},
		{"group:stick", "dye:white", "group:stick"},
	},
})

minetest.register_craft({
	output = "lord_homedecor:stained_glass 8",
	recipe = {
		{"", "dye:blue", ""},
		{"dye:red", "default:glass", "dye:green"},
		{"", "dye:yellow", ""},
	},
})

--minetest.register_craft({
	--output = "lord_homedecor:stained_glass",
	--recipe = {
		--{"", "dye:blue", ""},
		--{"dye:red", "xpanes:pane", "dye:green"},
		--{"", "dye:yellow", ""},
	--},
--})

minetest.register_craftitem("lord_homedecor:flower_pot_small", {
	description = S("Small Flower Pot"),
	inventory_image = "homedecor_flowerpot_small_inv.png"
})

minetest.register_craft( {
	output = "lord_homedecor:flower_pot_small",
	recipe = {
	        { "default:clay_brick", "", "default:clay_brick" },
	        { "", "default:clay_brick", "" }
	}
})

minetest.register_craft( {
	output = "lord_homedecor:flower_pot_small 3",
	recipe = { { "lord_homedecor:flower_pot_terracotta" } }
})

minetest.register_craft({
	output = "lord_homedecor:shrubbery_green 3",
	recipe = {
		{ "lottplants:lebethronleaf", "lottplants:lebethronleaf", "lottplants:lebethronleaf" },
		{ "lottplants:lebethronleaf", "lottplants:lebethronleaf", "lottplants:lebethronleaf" },
		{ "group:stick", "group:stick", "group:stick" }
	}
})

for _, color in ipairs(lord_homedecor.shrub_colors) do

	minetest.register_craft({
		type = "shapeless",
		output = "lord_homedecor:shrubbery_large_"..color,
		recipe = {
			"lord_homedecor:shrubbery_"..color
		}
	})

	minetest.register_craft({
		type = "shapeless",
		output = "lord_homedecor:shrubbery_"..color,
		recipe = {
			"lord_homedecor:shrubbery_large_"..color
		}
	})

	if color ~= "green" then
		minetest.register_craft({
			type = "shapeless",
			output = "lord_homedecor:shrubbery_large_"..color,
			recipe = {
				"lord_homedecor:shrubbery_large_green",
				"dye:"..color
			}
		})

		minetest.register_craft({
			type = "shapeless",
			output = "lord_homedecor:shrubbery_"..color,
			recipe = {
				"lord_homedecor:shrubbery_green",
				"dye:"..color
			}
		})

	end
end


-- перила
for i in ipairs(lord_homedecor.banister_materials) do

	local name    = lord_homedecor.banister_materials[i][1]
	local topmat  = lord_homedecor.banister_materials[i][5]
	local vertmat = lord_homedecor.banister_materials[i][6]
	local dye1    = lord_homedecor.banister_materials[i][7]
	local dye2    = lord_homedecor.banister_materials[i][8]

	minetest.register_craft({
		output = "lord_homedecor:banister_"..name.."_horizontal 2",
		recipe = {
			{ topmat,  "",      dye1   },
			{ vertmat, topmat,  ""     },
			{ dye2,    vertmat, topmat }
		},
	})
end

--if (minetest.get_modpath("technic") and minetest.get_modpath("dye") and minetest.get_modpath("bees")) then
	--technic.register_separating_recipe({ input = {"bees:wax 1"}, output = {"lord_homedecor:oil_extract 2","dye:yellow 1"} })
--end

