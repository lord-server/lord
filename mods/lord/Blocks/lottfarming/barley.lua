local S = minetest.get_translator("lottfarming")

minetest.register_craftitem("lottfarming:barley_seed", {
	description = S("Barley Seeds"),
	inventory_image = "lottfarming_barley_seed.png",
	on_place = function(itemstack, placer, pointed_thing)
		local ptu = pointed_thing.under
		local nu = minetest.get_node(ptu)
		if minetest.registered_nodes[nu.name].on_rightclick then
			return minetest.registered_nodes[nu.name].on_rightclick(ptu, nu, placer, itemstack)
		end
		return place_seed(itemstack, placer, pointed_thing, "lottfarming:barley_1", 3)
	end,
})

minetest.register_node("lottfarming:barley_1", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_barley_1.png"},
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+6/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:barley_2", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_barley_2.png"},
	waving = 1,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+9/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:barley_3", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"lottfarming_barley_3.png"},
	waving = 1,
	drop = {
		max_items = 6,
		items = {
			{ items = {'lottfarming:sheaf_barley'} },
			{ items = {'lottfarming:sheaf_barley'}, rarity = 2 },
			{ items = {'lottfarming:sheaf_barley'}, rarity = 5 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("lottfarming:sheaf_barley", {
	description = S("Sheaf barley"),
	inventory_image = "lottfarming_sheaf_barley.png",
})

farming:add_plant("lottfarming:barley_3", {"lottfarming:barley_1", "lottfarming:barley_2"}, 50, 20, 3)

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "lottfarming:barley_cooked",
	recipe = "lottfarming:sheaf_barley"
})

minetest.register_craftitem("lottfarming:barley_cooked", {
	description     = S("Cooked Barley"),
	inventory_image = "lottfarming_barley_cooked.png",
	-- removed while balancing food TODO: add to horse follow & tame #1583
	--on_use          = minetest.item_eat(2),
	----_tt_food_hp     = 2,
})
