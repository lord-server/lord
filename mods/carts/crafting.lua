
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

register_rail_craft("carts:rail", "")
register_rail_craft("carts:accelerating_rail", "carts:gear")
register_rail_craft("carts:stoppingrail", "default:coal_lump")

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

minetest.register_craft({
        output = "carts:steam_mechanism",
        recipe = {
                {"default:steel_ingot", "group:stick", "default:steel_ingot"},
                {"carts:gear", "lottpotion:cauldron_full", "default:torch"},
                {"default:steel_ingot", "default:coalblock", "default:steel_ingot"},
        }
})

minetest.register_craft({
	output = "carts:cart",
	recipe = {
		{"default:steel_ingot", "", "default:steel_ingot"},
                {"group:wood", "", "group:wood"},
                {"default:steel_ingot", "group:wood", "default:steel_ingot"},
	},
})

minetest.register_craft({
	output = "carts:gear 4",
	recipe = {
		{"", "default:steel_ingot", ""},
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"", "default:steel_ingot", ""},
	}
})

