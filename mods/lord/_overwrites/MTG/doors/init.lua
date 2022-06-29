minetest.unregister_item("doors:trapdoor_steel")
minetest.unregister_item("doors:trapdoor_steel_open")
minetest.unregister_item("doors:gate_acacia_wood_closed")
minetest.unregister_item("doors:gate_acacia_wood_open")
minetest.unregister_item("doors:gate_aspen_wood_closed")
minetest.unregister_item("doors:gate_aspen_wood_open")
minetest.unregister_item("doors:gate_junglewood_closed")
minetest.unregister_item("doors:gate_junglewood_open")
minetest.unregister_item("doors:gate_pine_wood_closed")
minetest.unregister_item("doors:gate_pine_wood_open")
minetest.unregister_item("doors:gate_wood_closed")
minetest.unregister_item("doors:gate_wood_open")

minetest.clear_craft({recipe = {
	{"default:steel_ingot", "default:steel_ingot"},
	{"default:steel_ingot", "default:steel_ingot"},
}})

minetest.clear_craft({recipe = {
    {"group:stick", "default:aspen_wood", "group:stick"},
    {"group:stick", "default:aspen_wood", "group:stick"}
}})

minetest.clear_craft({recipe = {
    {"group:stick", "default:acacia_wood", "group:stick"},
    {"group:stick", "default:acacia_wood", "group:stick"}
}})

minetest.clear_craft({recipe = {
    {"group:stick", "default:junglewood", "group:stick"},
    {"group:stick", "default:junglewood", "group:stick"}
}})

minetest.clear_craft({recipe = {
    {"group:stick", "default:pine_wood", "group:stick"},
    {"group:stick", "default:pine_wood", "group:stick"}
}})

minetest.clear_craft({recipe = {
    {"group:stick", "default:wood", "group:stick"},
    {"group:stick", "default:wood", "group:stick"}
}})

minetest.clear_craft({type = "fuel", recipe = "doors:gate_wood_closed"})
minetest.clear_craft({type = "fuel", recipe = "doors:gate_acacia_wood_closed"})
minetest.clear_craft({type = "fuel", recipe = "doors:gate_junglewood_closed"})
minetest.clear_craft({type = "fuel", recipe = "doors:gate_pine_wood_closed"})
minetest.clear_craft({type = "fuel", recipe = "doors:gate_aspen_wood_closed"})
