minetest.register_craft({
    output = "lord_archery:steel_throwing_axe",
    recipe = {
        { "default:steel_ingot", "", "default:steel_ingot", },
        { "default:steel_ingot", "group:stick", "default:steel_ingot", },
        { "", "group:stick", "", },
    }
})

minetest.register_craft({
    output = "lord_archery:bronze_throwing_axe",
    recipe = {
        { "default:bronze_ingot", "", "default:bronze_ingot", },
        { "default:bronze_ingot", "group:stick", "default:bronze_ingot", },
        { "", "group:stick", "", },
    }
})

minetest.register_craft({
    output = "lord_archery:galvorn_throwing_axe",
    recipe = {
        { "lottores:galvorn_ingot", "", "lottores:galvorn_ingot", },
        { "lottores:galvorn_ingot", "group:stick", "lottores:galvorn_ingot", },
        { "", "group:stick", "", },
    }
})

minetest.register_craft({
    output = "lord_archery:mithril_throwing_axe",
    recipe = {
        { "lottores:mithril_ingot", "", "lottores:mithril_ingot", },
        { "lottores:mithril_ingot", "group:stick", "lottores:mithril_ingot", },
        { "", "group:stick", "", },
    }
})

