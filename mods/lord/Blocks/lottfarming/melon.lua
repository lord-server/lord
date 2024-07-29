local S = minetest.get_translator("lottfarming")

minetest.register_craftitem("lottfarming:melon_seed", {
	description     = S("Melon Seed"),
	inventory_image = "lottfarming_melon_seed.png",
	on_place        = function(itemstack, placer, pointed_thing)
		local ptu = pointed_thing.under
		local nu  = minetest.get_node(ptu)
		if minetest.registered_nodes[nu.name].on_rightclick then
			return minetest.registered_nodes[nu.name].on_rightclick(ptu, nu, placer, itemstack)
		end
		return place_seed(itemstack, placer, pointed_thing, "lottfarming:melon_1")
	end,
})

minetest.register_node("lottfarming:melon_1", {
	paramtype           = "light",
	sunlight_propagates = true,
	drawtype            = "nodebox",
	drop                = "",
	tiles               = {
		"lottfarming_melon_top.png",
		"lottfarming_melon_top.png",
		"lottfarming_melon_side.png",
		"lottfarming_melon_side.png",
		"lottfarming_melon_side.png",
		"lottfarming_melon_side.png",
	},
	node_box            = {
		type  = "fixed",
		fixed = {
			{ -0.2, -0.5, -0.2, 0.2, -0.1, 0.2 }
		},
	},
	selection_box       = {
		type  = "fixed",
		fixed = {
			{ -0.2, -0.5, -0.2, 0.2, -0.1, 0.2 }
		},
	},
	groups              = {
		choppy                    = 2,
		oddly_breakable_by_hand   = 2,
		flammable                 = 2,
		not_in_creative_inventory = 1,
		plant                     = 1,
	},
	sounds              = default.node_sound_wood_defaults(),
})

minetest.register_node("lottfarming:melon_2", {
	paramtype           = "light",
	sunlight_propagates = true,
	drawtype            = "nodebox",
	drop                = "",
	tiles               = {
		"lottfarming_melon_top.png",
		"lottfarming_melon_top.png",
		"lottfarming_melon_side.png",
		"lottfarming_melon_side.png",
		"lottfarming_melon_side.png",
		"lottfarming_melon_side.png",
	},
	node_box            = {
		type  = "fixed",
		fixed = {
			{ -0.35, -0.5, -0.35, 0.35, 0.2, 0.35 }
		},
	},
	selection_box       = {
		type  = "fixed",
		fixed = {
			{ -0.35, -0.5, -0.35, 0.35, 0.2, 0.35 }
		},
	},
	groups              = {
		choppy                    = 2,
		oddly_breakable_by_hand   = 2,
		flammable                 = 2,
		not_in_creative_inventory = 1,
		plant                     = 1,
	},
	sounds              = default.node_sound_wood_defaults(),
})

minetest.register_node("lottfarming:melon_3", {
	description = S("Melon"),
	paramtype2  = "facedir",
	tiles       = {
		"lottfarming_melon_top.png",
		"lottfarming_melon_top.png",
		"lottfarming_melon_side.png",
		"lottfarming_melon_side.png",
		"lottfarming_melon_side.png",
		"lottfarming_melon_side.png",
	},
	drop        = "lottfarming:melon_3",
	groups      = { choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, plant = 1 },
	sounds      = default.node_sound_wood_defaults(),
})

minetest.register_alias("lottfarming:melon_slice", "lottfarming:melon")
minetest.register_craftitem("lottfarming:melon", {
	description     = S("Melon"),
	inventory_image = "lottfarming_melon.png",
	on_use          = minetest.item_eat(4),
	_tt_food        = true,
	_tt_food_hp     = 4,
})

farming:add_plant("lottfarming:melon_3", { "lottfarming:melon_1", "lottfarming:melon_2" }, 80, 20)
