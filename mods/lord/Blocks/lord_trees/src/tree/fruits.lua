local S = minetest.get_mod_translator()


minetest.register_node("lord_trees:plum", {
	description         = S("Plum"),
	drawtype            = "plantlike",
	visual_scale        = 1.0,
	tiles               = { "lord_trees_plum.png" },
	inventory_image     = "lord_trees_plum.png",
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
	on_use              = minetest.item_eat(4),
	_tt_food_hp         = 4,
	sounds              = default.node_sound_leaves_defaults(),
	after_place_node    = function(pos, placer, itemstack)
		if placer:is_player() then
			minetest.set_node(pos, { name = "lord_trees:plum", param2 = 1 })
		end
	end,
})

minetest.register_node("lord_trees:yavannamire_fruit", {
	description         = S("Yavannamire Fruit"),
	drawtype            = "plantlike",
	visual_scale        = 1.0,
	tiles               = { "lord_trees_yavannamire_fruit.png" },
	inventory_image     = "lord_trees_yavannamire_fruit.png",
	paramtype           = "light",
	sunlight_propagates = true,
	walkable            = false,
	selection_box       = {
		type  = "fixed",
		fixed = { -0.2, -0.5, -0.2, 0.2, 0, 0.2 }
	},
	groups              = { fleshy = 3, dig_immediate = 3, flammable = 2, leafdecay = 3, leafdecay_drop = 1 },
	on_use              = minetest.item_eat(10),
	_tt_food_hp         = 10,
	sounds              = default.node_sound_leaves_defaults(),
	after_place_node    = function(pos, placer, itemstack)
		if placer:is_player() then
			minetest.set_node(pos, { name = "lord_trees:yavannamire_fruit", param2 = 1 })
		end
	end,
})
