local SL = lord.require_intllib()

minetest.register_craftitem("lottfarming:berries_seed", {
	description     = SL("Berries Seeds"),
	inventory_image = "lottfarming_berries_seed.png",
	on_place        = function(itemstack, placer, pointed_thing)
		local ptu = pointed_thing.under
		local nu  = minetest.get_node(ptu)
		if minetest.registered_nodes[nu.name].on_rightclick then
			return minetest.registered_nodes[nu.name].on_rightclick(ptu, nu, placer, itemstack)
		end
		return place_seed(itemstack, placer, pointed_thing, "lottfarming:berries_1")
	end,
})

minetest.register_node("lottfarming:berries_1", {
	paramtype     = "light",
	walkable      = false,
	drawtype      = "plantlike",
	drop          = "",
	tiles         = { "lottfarming_berries_1.png" },
	selection_box = {
		type  = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, -0.5 + 5 / 16, 0.5 }
		},
	},
	groups        = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds        = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:berries_2", {
	paramtype     = "light",
	walkable      = false,
	drawtype      = "plantlike",
	drop          = "",
	waving        = 1,
	tiles         = { "lottfarming_berries_2.png" },
	selection_box = {
		type  = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, -0.5 + 8 / 16, 0.5 }
		},
	},
	groups        = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds        = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:berries_3", {
	paramtype     = "light",
	walkable      = false,
	drawtype      = "plantlike",
	drop          = "",
	waving        = 1,
	tiles         = { "lottfarming_berries_3.png" },
	selection_box = {
		type  = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, -0.5 + 13 / 16, 0.5 }
		},
	},
	groups        = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds        = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:berries_4", {
	paramtype = "light",
	walkable  = false,
	drawtype  = "plantlike",
	waving    = 1,
	tiles     = { "lottfarming_berries_4.png" },
	drop      = {
		max_items = 6,
		items     = {
			{ items = { 'lottfarming:berries_seed' } },
			{ items = { 'lottfarming:berries_seed' }, rarity = 2 },
			{ items = { 'lottfarming:berries_seed' }, rarity = 5 },
			{ items = { 'lottfarming:berries' } },
			{ items = { 'lottfarming:berries' }, rarity = 2 },
			{ items = { 'lottfarming:berries' }, rarity = 5 }
		}
	},
	groups    = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds    = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("lottfarming:berries", {
	description     = SL("Berries"),
	inventory_image = "lottfarming_berries.png",
	on_use          = minetest.item_eat(1),
})

farming:add_plant(
	"lottfarming:berries_4",
	{ "lottfarming:berries_1", "lottfarming:berries_2", "lottfarming:berries_3" },
	50,
	20
)
