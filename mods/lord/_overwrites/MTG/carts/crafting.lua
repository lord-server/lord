local S = minetest.get_translator("lord_overwrites_mtg_carts")

--
-- crafting
--

minetest.clear_craft({output = "carts:brakerail"})
minetest.clear_craft({output = "carts:powerrail"})
minetest.clear_craft({output = "carts:rail"})

minetest.register_craft({
	output = "carts:cart",
	recipe = {
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"group:wood", "", "group:wood"},
		{"default:steel_ingot", "group:wood", "default:steel_ingot"},
	},
})

minetest.register_craftitem(":carts:gear", {
	description = S("Gear"),
	inventory_image = "carts_gear.png",
})

minetest.register_craft({
	output = "carts:gear 4",
	recipe = {
		{"", "default:steel_ingot", ""},
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"", "default:steel_ingot", ""},
	}
})

minetest.register_node(":carts:steam_mechanism", {
	description = S("Steam mechanism"),
	tiles = {"carts_steam_mechanismv.png", "carts_steam_mechanismn.png",
		"carts_steam_mechanism1.png", "carts_steam_mechanism3.png",
		"carts_steam_mechanism2.png", "carts_steam_mechanism4.png"},
	is_ground_content = false,
	groups = {crumbly=2, cracky=3, accelerator=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "carts:steam_mechanism",
	recipe = {
		{"default:steel_ingot", "group:stick", "default:steel_ingot"},
		{"carts:gear", "lottpotion:cauldron_full", "default:torch"},
		{"default:steel_ingot", "default:coalblock", "default:steel_ingot"},
	}
})

local function register_rail_craft(item, special)
	minetest.register_craft({
		output = item .. " 6",
		recipe = {
			{"default:steel_ingot", special, "default:steel_ingot"},
			{"default:steel_ingot", "group:stick", "default:steel_ingot"},
			{"default:steel_ingot", "", "default:steel_ingot"},
		}
	})
	minetest.register_craft({
		output = item .. " 6",
		recipe = {
			{"default:steel_ingot", "", "default:steel_ingot"},
			{"default:steel_ingot", "group:stick", "default:steel_ingot"},
			{"default:steel_ingot", special, "default:steel_ingot"},
		}
	})
end

register_rail_craft("carts:brakerail", "default:coal_lump")
register_rail_craft("carts:powerrail", "carts:gear")
register_rail_craft("carts:rail", "")

--**************************************************************************
-- cooking
--**************************************************************************

minetest.register_craft({
	type = "cooking",
	output = "default:steel_ingot",
	recipe = "carts:brakerail",
})

minetest.register_craft({
	type = "cooking",
	output = "default:steel_ingot",
	recipe = "carts:powerrail",
})

minetest.register_craft({
	type = "cooking",
	output = "default:steel_ingot",
	recipe = "carts:rail",
})
