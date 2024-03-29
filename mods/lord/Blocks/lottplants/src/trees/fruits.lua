local S = minetest.get_translator("lottplants")


minetest.register_node("lottplants:plum", {
	description         = S("Plum"),
	drawtype            = "plantlike",
	visual_scale        = 1.0,
	tiles               = { "lottplants_plum.png" },
	inventory_image     = "lottplants_plum.png",
	paramtype           = "light",
	sunlight_propagates = true,
	walkable            = false,
	selection_box       = {
		type  = "fixed",
		fixed = { -0.2, -0.5, -0.2, 0.2, 0, 0.2 }
	},
	groups              = {
		fleshy = 3, dig_immediate = 3, flammable = 2, leafdecay = 3, leafdecay_drop = 1, color_violet = 1
	},
	on_use              = minetest.item_eat(2),
	sounds              = default.node_sound_leaves_defaults(),
	after_place_node    = function(pos, placer, itemstack)
		if placer:is_player() then
			minetest.set_node(pos, { name = "lottplants:plum", param2 = 1 })
		end
	end,
})

minetest.register_node("lottplants:yavannamirefruit", {
	description         = S("Yavannamire Fruit"),
	drawtype            = "plantlike",
	visual_scale        = 1.0,
	tiles               = { "lottplants_yavannamirefruit.png" },
	inventory_image     = "lottplants_yavannamirefruit.png",
	paramtype           = "light",
	sunlight_propagates = true,
	walkable            = false,
	selection_box       = {
		type  = "fixed",
		fixed = { -0.2, -0.5, -0.2, 0.2, 0, 0.2 }
	},
	groups              = { fleshy = 3, dig_immediate = 3, flammable = 2, leafdecay = 3, leafdecay_drop = 1 },
	on_use              = minetest.item_eat(4),
	sounds              = default.node_sound_leaves_defaults(),
	after_place_node    = function(pos, placer, itemstack)
		if placer:is_player() then
			minetest.set_node(pos, { name = "lottplants:yavannamirefruit", param2 = 1 })
		end
	end,
})
