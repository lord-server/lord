local SL = lord.require_intllib()

minetest.register_node("carts:steam_mechanism", {
        description = SL("Steam mechanism"),
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

