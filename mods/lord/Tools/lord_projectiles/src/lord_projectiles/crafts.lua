minetest.register_mirrored_crafts({
    output = "lord_projectiles:flint_arrow 4",
    recipe = {
        { "group:stick", "group:stick", "default:flint", },
    }
})

minetest.register_mirrored_crafts({
    output = "lord_projectiles:steel_arrow 4",
    recipe = {
        { "group:stick", "group:stick", "default:steel_ingot", },
    }
})

minetest.register_mirrored_crafts({
    output = "lord_projectiles:bronze_arrow 4",
    recipe = {
        { "group:stick", "group:stick", "default:bronze_ingot", },
    }
})

minetest.register_mirrored_crafts({
    output = "lord_projectiles:galvorn_arrow 4",
    recipe = {
        { "group:stick", "group:stick", "lottores:galvorn_ingot", },
    }
})

minetest.register_mirrored_crafts({
    output = "lord_projectiles:mithril_arrow 4",
    recipe = {
        { "group:stick", "group:stick", "lottores:mithril_ingot", },
    }
})


minetest.register_craft({
    output = "lord_projectiles:steel_bolt 4",
    recipe = {
        { "default:steel_ingot", "group:stick", "default:steel_ingot", },
    }
})

minetest.register_craft({
    output = "lord_projectiles:bronze_bolt 4",
    recipe = {
        { "default:bronze_ingot", "group:stick", "default:bronze_ingot", },
    }
})

minetest.register_craft({
    output = "lord_projectiles:galvorn_bolt 4",
    recipe = {
        { "lottores:galvorn_ingot", "group:stick", "lottores:galvorn_ingot", },
    }
})

minetest.register_craft({
    output = "lord_projectiles:mithril_bolt 4",
    recipe = {
        { "lottores:mithril_ingot", "group:stick", "lottores:mithril_ingot", },
    }
})
