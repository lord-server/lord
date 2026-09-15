local S = core.get_mod_translator()

--
-- crafting
--

core.clear_craft({output = "carts:brakerail"})
core.clear_craft({output = "carts:powerrail"})
core.clear_craft({output = "carts:rail"})

core.register_craft({
	output = "carts:cart",
	recipe = {
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"group:wood", "", "group:wood"},
		{"default:steel_ingot", "group:wood", "default:steel_ingot"},
	},
})

core.register_craftitem(":carts:gear", {
	description = S("Gear"),
	inventory_image = "carts_gear.png",
})

core.register_craft({
	output = "carts:gear 4",
	recipe = {
		{"", "default:steel_ingot", ""},
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"", "default:steel_ingot", ""},
	}
})

core.register_node(":carts:steam_mechanism", {
	description = S("Steam mechanism"),
	tiles = {"carts_steam_mechanismv.png", "carts_steam_mechanismn.png",
		"carts_steam_mechanism1.png", "carts_steam_mechanism3.png",
		"carts_steam_mechanism2.png", "carts_steam_mechanism4.png"},
	is_ground_content = false,
	groups = {crumbly=2, cracky=3, accelerator=1},
	sounds = default.node_sound_stone_defaults(),
})

core.register_craft({
	output = "carts:steam_mechanism",
	recipe = {
		{"default:steel_ingot", "group:stick", "default:steel_ingot"},
		{"carts:gear", "cauldron:cauldron_3_3", "default:torch"},
		{"default:steel_ingot", "default:coalblock", "default:steel_ingot"},
	}
})

local function register_rail_craft(item, special)
	core.register_craft({
		output = item .. " 6",
		recipe = {
			{"default:steel_ingot", special, "default:steel_ingot"},
			{"default:steel_ingot", "group:stick", "default:steel_ingot"},
			{"default:steel_ingot", "", "default:steel_ingot"},
		}
	})
	core.register_craft({
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

core.register_craft({
	type = "cooking",
	output = "default:steel_ingot",
	recipe = "carts:brakerail",
})

core.register_craft({
	type = "cooking",
	output = "default:steel_ingot",
	recipe = "carts:powerrail",
})

core.register_craft({
	type = "cooking",
	output = "default:steel_ingot",
	recipe = "carts:rail",
})
