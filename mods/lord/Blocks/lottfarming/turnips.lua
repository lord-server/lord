local S = minetest.get_translator("lottfarming")

minetest.register_craftitem("lottfarming:turnips_seed", {
	description     = S("Turnip Seeds"),
	inventory_image = "lottfarming_turnips_seed.png",
	on_place        = function(itemstack, placer, pointed_thing)
		local ptu = pointed_thing.under
		local nu  = minetest.get_node(ptu)
		if minetest.registered_nodes[nu.name].on_rightclick then
			return minetest.registered_nodes[nu.name].on_rightclick(ptu, nu, placer, itemstack)
		end
		return place_seed(itemstack, placer, pointed_thing, "lottfarming:turnips_1", 40)
	end,
})

minetest.register_node("lottfarming:turnips_1", {
	paramtype     = "light",
	paramtype2    = "meshoptions",
	walkable      = false,
	drawtype      = "plantlike",
	drop          = "",
	tiles         = { "lottfarming_turnips_1.png" },
	waving        = 1,
	selection_box = {
		type  = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, -0.5 + 3 / 16, 0.5 }
		},
	},
	groups        = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds        = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:turnips_2", {
	paramtype     = "light",
	paramtype2    = "meshoptions",
	walkable      = false,
	drawtype      = "plantlike",
	drop          = "",
	tiles         = { "lottfarming_turnips_2.png" },
	waving        = 1,
	selection_box = {
		type  = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, -0.5 + 5 / 16, 0.5 }
		},
	},
	groups        = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds        = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:turnips_3", {
	paramtype     = "light",
	paramtype2    = "meshoptions",
	walkable      = false,
	drawtype      = "plantlike",
	drop          = "",
	tiles         = { "lottfarming_turnips_3.png" },
	waving        = 1,
	selection_box = {
		type  = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, -0.5 + 12 / 16, 0.5 }
		},
	},
	groups        = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds        = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:turnips_4", {
	paramtype  = "light",
	paramtype2 = "meshoptions",
	walkable   = false,
	drawtype   = "plantlike",
	tiles      = { "lottfarming_turnips_4.png" },
	waving     = 1,
	drop       = {
		max_items = 6,
		items     = {
			{ items = { 'lottfarming:turnips_seed' } },
			{ items = { 'lottfarming:turnips_seed' }, rarity = 2 },
			{ items = { 'lottfarming:turnips_seed' }, rarity = 5 },
			{ items = { 'lottfarming:turnips' } },
			{ items = { 'lottfarming:turnips' }, rarity = 2 },
			{ items = { 'lottfarming:turnips' }, rarity = 5 }
		}
	},
	groups     = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds     = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("lottfarming:turnips", {
	description     = S("Turnips"),
	inventory_image = "lottfarming_turnips.png",
	on_use          = minetest.item_eat(4),
	_tt_food_hp     = 4,
})

farming:add_plant(
	"lottfarming:turnips_4",
	{ "lottfarming:turnips_1", "lottfarming:turnips_2", "lottfarming:turnips_3" },
	50,
	20,
	40
)

minetest.register_craftitem("lottfarming:turnips_cooked", {
	description     = S("Cooked Turnips"),
	inventory_image = "lottfarming_turnips_cooked.png",
	on_use          = minetest.item_eat(7),
	_tt_food_hp     = 7,
})
