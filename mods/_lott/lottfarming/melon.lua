local S = lottfarming.get_translator

minetest.register_alias("lottfarming:melon_slice", "lottfarming:melon")

minetest.register_craftitem("lottfarming:melon", {
	description = S("Melon Slice"),
	inventory_image = "lottfarming_melon.png",
	on_use = minetest.item_eat(2),
})

minetest.register_node("lottfarming:melon_1", {
	paramtype = "light",
	sunlight_propagates = true,
	drawtype = "nodebox",
	drop = "",
	tiles = {"lottfarming_melon_top.png", "lottfarming_melon_top.png", "lottfarming_melon_side.png",
	"lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png"},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.5, -0.2, 0.2, -0.1, 0.2}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.2, -0.5, -0.2, 0.2, -0.1, 0.2}
		},
	},
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
	next_plant = {{node = "lottfarming:melon_2"}},
	on_timer = farming.grow_plant,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, not_in_creative_inventory = 1, plant = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("lottfarming:melon_2", {
	paramtype = "light",
	sunlight_propagates = true,
	drawtype = "nodebox",
	drop = "",
	tiles = {"lottfarming_melon_top.png", "lottfarming_melon_top.png", "lottfarming_melon_side.png",
	"lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png"},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.35, -0.5, -0.35, 0.35, 0.2, 0.35}
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.35, -0.5, -0.35, 0.35, 0.2, 0.35}
		},
	},
	minlight = 11,
	maxlight = lottfarming.MAX_LIGHT,
	next_plant = {{node = "lottfarming:melon_3"}},
	on_timer = farming.grow_plant,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, not_in_creative_inventory = 1, plant = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("lottfarming:melon_3", {
	description = S("Melon"),
	paramtype2 = "facedir",
	tiles = {"lottfarming_melon_top.png", "lottfarming_melon_top.png", "lottfarming_melon_side.png",
	"lottfarming_melon_side.png", "lottfarming_melon_side.png", "lottfarming_melon_side.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'lottfarming:melon_seed'} },
			{ items = {'lottfarming:melon_seed'}, rarity = 2},
			{ items = {'lottfarming:melon_seed'}, rarity = 5},
			{ items = {'lottfarming:melon_3'} }
		}
	},
	groups = {choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, plant = 1},
	sounds = default.node_sound_wood_defaults(),
})

farming.register_plant("lottfarming:melon", {
	description = S("Melon Seed"),
	harvest_name = "lottfarming:melon_3",
	seed_inv_img = "lottfarming_seed_melon.png",
	planttype = 3,
	paramtype2 = "meshoptions",
	minlight = 11,
	maxlight = 15,
	fertility = {"soil"},
	place_param2 = 1,
})
