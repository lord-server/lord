-- main `S` code in init.lua
local SL = minetest.get_translator("lottfarming")

minetest.register_craftitem("lottfarming:carrot_seed", {
	description     = SL("Carrot Seeds"),
	inventory_image = "farming_carrot_seed.png",
	on_place        = function(itemstack, placer, pointed_thing)
		local ptu = pointed_thing.under
		local nu  = minetest.get_node(ptu)
		if minetest.registered_nodes[nu.name].on_rightclick then
			return minetest.registered_nodes[nu.name].on_rightclick(ptu, nu, placer, itemstack)
		end
		return place_seed(itemstack, placer, pointed_thing, "lottfarming:carrot_1")
	end
})

minetest.register_node("lottfarming:carrot_1", {
	paramtype     = "light",
	walkable      = false,
	drawtype      = "plantlike",
	drop          = "",
	tiles         = { "farming_carrot_1.png" },
	selection_box = {
		type  = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, -0.5 + 3 / 16, 0.5 }
		},
	},
	groups        = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds        = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:carrot_2", {
	paramtype     = "light",
	walkable      = false,
	drawtype      = "plantlike",
	drop          = "",
	tiles         = { "farming_carrot_2.png" },
	selection_box = {
		type  = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, -0.5 + 5 / 16, 0.5 }
		},
	},
	groups        = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds        = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:carrot_3", {
	paramtype     = "light",
	walkable      = false,
	drawtype      = "plantlike",
	drop          = "",
	tiles         = { "farming_carrot_3.png" },
	selection_box = {
		type  = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, -0.5 + 12 / 16, 0.5 }
		},
	},
	groups        = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds        = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:carrot", {
	paramtype = "light",
	walkable  = false,
	drawtype  = "plantlike",
	tiles     = { "farming_carrot_4.png" },
	drop      = {
		max_items = 6,
		items     = {
			{ items = { 'lottfarming:carrot_seed' } },
			{ items = { 'lottfarming:carrot_seed' }, rarity = 2 },
			{ items = { 'lottfarming:carrot_seed' }, rarity = 35 },
			{ items = { 'lottfarming:carrot_item' } },
			{ items = { 'lottfarming:carrot_item' }, rarity = 2 },
			{ items = { 'lottfarming:carrot_item' }, rarity = 35 }
		}
	},
	groups    = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds    = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("lottfarming:carrot_item", {
	description     = SL("Carrot"),
	inventory_image = "farming_carrot.png",
	on_use          = minetest.item_eat(2),
	_tt_food        = true,
	_tt_food_hp     = 2,
})

farming:add_plant(
	"lottfarming:carrot",
	{ "lottfarming:carrot_1", "lottfarming:carrot_2", "lottfarming:carrot_3" },
	50,
	20
)
