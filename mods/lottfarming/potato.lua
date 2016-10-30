local SL = lord.require_intllib()

minetest.register_craftitem("lottfarming:half_of_potatoe", {
	description = SL("Half of potatoe"),
	inventory_image = "lottfarming_half_of_potatoe.png",
	on_place = function(itemstack, placer, pointed_thing)
		local ptu = pointed_thing.under
		local nu = minetest.get_node(ptu)
		if minetest.registered_nodes[nu.name].on_rightclick then
			return minetest.registered_nodes[nu.name].on_rightclick(ptu, nu, placer, itemstack)
		end
		return place_seed(itemstack, placer, pointed_thing, "lottfarming:potato_1")
	end,
})

minetest.register_node("lottfarming:potato_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_potato_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+6/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:potato_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	waving = 1,
	tiles = {"lottfarming_potato_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+9/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("lottfarming:potato_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	waving = 1,
	tiles = {"lottfarming_potato_3.png"},
	drop = {
		max_items = 6,
		items = {
			{ items = {'lottfarming:potato'}, rarity = 1 },
			{ items = {'lottfarming:potato'}, rarity = 3 },
			{ items = {'lottfarming:potato'}, rarity = 6 }
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("lottfarming:potato", {
	description = SL("Potato"),
	inventory_image = "lottfarming_potato.png",
	on_use = minetest.item_eat(1),
})

farming:add_plant("lottfarming:potato_3", {"lottfarming:potato_1", "lottfarming:potato_2"}, 50, 20)

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "lottfarming:potato_cooked",
	recipe = "lottfarming:potato"
})

minetest.register_craftitem("lottfarming:potato_cooked", {
	description = SL("Cooked Potato"),
	inventory_image = "lottfarming_potato_cooked.png",
	on_use = minetest.item_eat(5),
})
