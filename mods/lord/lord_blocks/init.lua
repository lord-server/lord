local S = minetest.get_translator("lord_blocks")

minetest.register_node("lord_blocks:blackout", {
	description = S("Blackout"),
	tiles = {"default_blackout.png"},
	drawtype = "glasslike",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
    walkable = false,
    buildable_to = true,
    pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
	--post_effect_color = {a = 10, r = 0, g = 0, b = 0},
})

minetest.register_alias("default:blackout", "lord_blocks:blackout")
