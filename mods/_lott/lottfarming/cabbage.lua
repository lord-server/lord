local S = lottfarming.get_translator

minetest.register_node("lottfarming:cabbage_1", {
	paramtype = "light",
	sunlight_propagates = true,
	drawtype = "nodebox",
	drop = "",
	tiles = {"lottfarming_cabbage_top.png", "lottfarming_cabbage_top.png", "lottfarming_cabbage_side.png",
	"lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png"},
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
	next_plant = {{node = "lottfarming:cabbage_2"}},
	on_timer = farming.grow_plant,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, not_in_creative_inventory = 1, plant = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("lottfarming:cabbage_2", {
	paramtype = "light",
	sunlight_propagates = true,
	drawtype = "nodebox",
	drop = "",
	tiles = {"lottfarming_cabbage_top.png", "lottfarming_cabbage_top.png", "lottfarming_cabbage_side.png",
	"lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png"},
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
	next_plant = {{node = "lottfarming:cabbage_3"}},
	on_timer = farming.grow_plant,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, not_in_creative_inventory = 1, plant = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("lottfarming:cabbage_3", {
	description = S("Cabbage"),
	paramtype2 = "facedir",
	tiles = {"lottfarming_cabbage_top.png", "lottfarming_cabbage_top.png", "lottfarming_cabbage_side.png",
	"lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'lottfarming:cabbage_seed'} },
			{ items = {'lottfarming:cabbage_seed'}, rarity = 2},
			{ items = {'lottfarming:cabbage_seed'}, rarity = 5},
			{ items = {'lottfarming:cabbage'} }
		}
	},
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, plant = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("lottfarming:cabbage", {
	description = S("Cabbage"),
	paramtype2 = "facedir",
	tiles = {"lottfarming_cabbage_top.png", "lottfarming_cabbage_top.png", "lottfarming_cabbage_side.png",
	"lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png", "lottfarming_cabbage_side.png"},
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, plant = 1, salad = 1},
	sounds = default.node_sound_wood_defaults(),
    on_use = minetest.item_eat(4)
})

farming.register_plant("lottfarming:cabbage", {
	description = S("Cabbage Seed"),
	harvest_name = "lottfarming:cabbage",
	seed_inv_img = "lottfarming_seed_cabbage.png",
	planttype = 3,
	paramtype2 = "meshoptions",
	minlight = 11,
	maxlight = 15,
	fertility = {"soil"},
	place_param2 = 1,
})

minetest.register_craft({
	output = 'lottfarming:salad',
	recipe = {
		{'group:salad', 'group:salad', 'group:salad'},
		{'', 'lottfarming:bowl', ''},
	}
})

minetest.register_craftitem("lottfarming:salad", {
	description = S("Salad"),
	inventory_image = "lottfarming_salad.png",
	on_use = minetest.item_eat(10),
})
