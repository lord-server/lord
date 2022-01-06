-- screwdriver/init.lua

-- у нас свои отвертки в `lord/lord_screwdriver`
minetest.clear_craft({output = "screwdriver:screwdriver"})
minetest.unregister_item("screwdriver:screwdriver")

-- для совместимости с другими модами
minetest.register_alias("screwdriver:screwdriver", "lord_screwdriver:screwdriver")
