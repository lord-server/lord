local SL = lord.require_intllib()

minetest.register_craftitem("lottfarming:corn_seed", {
	description     = SL("Corn"),
	inventory_image = "lottfarming_corn_seed.png",
	on_place        = function(itemstack, placer, pointed_thing)
		local ptu = pointed_thing.under
		local nu  = minetest.get_node(ptu)
		if minetest.registered_nodes[nu.name].on_rightclick then
			return minetest.registered_nodes[nu.name].on_rightclick(ptu, nu, placer, itemstack)
		end
		return place_seed(itemstack, placer, pointed_thing, "lottfarming:corn_1", 3)
	end,
})
minetest.register_craftitem("lottfarming:ear_of_corn", {
	description     = SL("Ear of corn"),
	inventory_image = "lottfarming_ear_of_corn.png",
	groups          = { salad = 1 },
	on_use          = minetest.item_eat(4),
})
minetest.register_node("lottfarming:corn_1", {
	paramtype     = "light",
	paramtype2    = "meshoptions",
	walkable      = false,
	drawtype      = "plantlike",
	drop          = "",
	tiles         = { "lottfarming_corn_1.png" },
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
minetest.register_node("lottfarming:corn_2", {
	paramtype     = "light",
	paramtype2    = "meshoptions",
	walkable      = false,
	drawtype      = "plantlike",
	drop          = "",
	tiles         = { "lottfarming_corn_2.png" },
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
minetest.register_node("lottfarming:corn_3", {
	paramtype  = "light",
	paramtype2 = "meshoptions",
	walkable   = false,
	drawtype   = "plantlike",
	drop       = "",
	tiles      = { "lottfarming_corn_3.png" },
	waving     = 1,
	groups     = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds     = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:corn_4", {
	paramtype  = "light",
	paramtype2 = "meshoptions",
	walkable   = false,
	drawtype   = "plantlike",
	drop       = "",
	tiles      = { "lottfarming_corn_4.png" },
	waving     = 1,
	groups     = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds     = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:corn_21", {
	paramtype  = "light",
	paramtype2 = "meshoptions",
	walkable   = false,
	drawtype   = "plantlike",
	drop       = "",
	tiles      = { "lottfarming_corn_21.png" },
	waving     = 1,
	groups     = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds     = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:corn_22", {
	paramtype  = "light",
	paramtype2 = "meshoptions",
	walkable   = false,
	drawtype   = "plantlike",
	drop       = "",
	tiles      = { "lottfarming_corn_22.png" },
	waving     = 1,
	groups     = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds     = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:corn_23", {
	paramtype  = "light",
	paramtype2 = "meshoptions",
	walkable   = false,
	drawtype   = "plantlike",
	tiles      = { "lottfarming_corn_23.png" },
	waving     = 1,
	drop       = {
		max_items = 6,
		items     = {
			{ items = { 'lottfarming:ear_of_corn' } },
			{ items = { 'lottfarming:ear_of_corn' }, rarity = 2 },
			{ items = { 'lottfarming:ear_of_corn' }, rarity = 5 },
		}
	},
	groups     = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds     = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:corn_31", {
	paramtype  = "light",
	paramtype2 = "meshoptions",
	walkable   = false,
	drawtype   = "plantlike",
	drop       = "",
	tiles      = { "lottfarming_corn_31.png" },
	waving     = 1,
	groups     = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds     = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:corn_32", {
	paramtype  = "light",
	paramtype2 = "meshoptions",
	walkable   = false,
	drawtype   = "plantlike",
	tiles      = { "lottfarming_corn_32.png" },
	waving     = 1,
	drop       = {
		max_items = 6,
		items     = {
			{ items = { 'lottfarming:ear_of_corn' } },
			{ items = { 'lottfarming:ear_of_corn' }, rarity = 2 },
			{ items = { 'lottfarming:ear_of_corn' }, rarity = 5 },
		}
	},
	groups     = { snappy = 3, flammable = 2, not_in_creative_inventory = 1, plant = 1 },
	sounds     = default.node_sound_leaves_defaults(),
})

local chance   = 10
local interval = 45

minetest.register_abm({
	nodenames = "lottfarming:corn_1",
	interval  = interval,
	chance    = chance,
	action    = function(pos, node)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name ~= "farming:soil_wet" then
			return
		end
		pos.y = pos.y + 1
		if not minetest.get_node_light(pos) then
			return
		end
		if minetest.get_node_light(pos) < 8 then
			return
		end
		pos.y = pos.y + 1
		if minetest.get_node(pos).name ~= "air" then
			return
		end
		pos.y = pos.y - 1

		minetest.set_node(pos, { name = 'lottfarming:corn_2', param2 = 3 })
	end
})
minetest.register_abm({
	nodenames = "lottfarming:corn_2",
	interval  = interval,
	chance    = chance,
	action    = function(pos, node)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name ~= "farming:soil_wet" then
			return
		end
		pos.y = pos.y + 1
		if not minetest.get_node_light(pos) then
			return
		end
		if minetest.get_node_light(pos) < 8 then
			return
		end
		pos.y = pos.y + 1
		minetest.set_node(pos, { name = 'lottfarming:corn_21', param2 = 3 })
		pos.y = pos.y - 1
		minetest.set_node(pos, { name = 'lottfarming:corn_3', param2 = 3 })

	end
})
minetest.register_abm({
	nodenames = "lottfarming:corn_3",
	interval  = interval,
	chance    = chance,
	action    = function(pos, node)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name ~= "farming:soil_wet" then
			return
		end
		pos.y = pos.y + 1
		if not minetest.get_node_light(pos) then
			return
		end
		if minetest.get_node_light(pos) < 8 then
			return
		end
		pos.y = pos.y + 1
		pos.y = pos.y + 1
		minetest.set_node(pos, { name = 'lottfarming:corn_31', param2 = 3 })
		pos.y = pos.y - 1

		minetest.set_node(pos, { name = 'lottfarming:corn_22', param2 = 3 })
		pos.y = pos.y - 1
		minetest.set_node(pos, { name = 'lottfarming:corn_4', param2 = 3 })

	end
})
minetest.register_abm({
	nodenames = "lottfarming:corn_22",
	interval  = interval,
	chance    = chance,
	action    = function(pos, node)
		if not minetest.get_node_light(pos) then
			return
		end
		if minetest.get_node_light(pos) < 8 then
			return
		end
		pos.y = pos.y + 1
		minetest.set_node(pos, { name = 'lottfarming:corn_32', param2 = 3 })
		pos.y = pos.y - 1
		minetest.set_node(pos, { name = 'lottfarming:corn_23', param2 = 3 })

	end
})
