local SL = lord.require_intllib()

minetest.register_craftitem("lottfarming:blue_mushroom_spore", {
	description = SL("Blue Mushroom Spores"),
	inventory_image = "lottfarming_blue_mushroom_spore.png",
	on_place = function(itemstack, placer, pointed_thing)
		local ptu = pointed_thing.under
		local nu = minetest.get_node(ptu)
		if minetest.registered_nodes[nu.name].on_rightclick then
			return minetest.registered_nodes[nu.name].on_rightclick(ptu, nu, placer, itemstack)
		end
		return place_spore(itemstack, placer, pointed_thing, "lottfarming:blue_mushroom_1", 9)
	end,
})

minetest.register_node("lottfarming:blue_mushroom", {
	description = SL("Blue Mushroom"),
	paramtype = "light",
	paramtype2 = "meshoptions",
	place_param2 = 9,
	light_source = 2,
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_blue_mushroom_4.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, mushroom=1, flower=1, color_blue=1},
	sounds = default.node_sound_leaves_defaults(),
	inventory_image = "lottfarming_blue_mushroom.png",
	on_use = minetest.item_eat(2),
})
minetest.register_node("lottfarming:blue_mushroom_1", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	light_source = 2,
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_blue_mushroom_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:blue_mushroom_2", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	light_source = 2,
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_blue_mushroom_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:blue_mushroom_3", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	light_source = 2,
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"lottfarming_blue_mushroom_3.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})
minetest.register_node("lottfarming:blue_mushroom_4", {
	paramtype = "light",
	paramtype2 = "meshoptions",
	light_source = 2,
	walkable = false,
	drawtype = "plantlike",
	tiles = {"lottfarming_blue_mushroom_4.png"},
	after_dig_node = function(pos)
	end,
	drop = {
		max_items = 6,
		items = {
			{ items = {'lottfarming:blue_mushroom'} },
			{ items = {'lottfarming:blue_mushroom'}, rarity = 2},
			{ items = {'lottfarming:blue_mushroom'}, rarity = 5},
			{ items = {'lottfarming:blue_mushroom_spore'} },
			{ items = {'lottfarming:blue_mushroom_spore'}, rarity = 2},
			{ items = {'lottfarming:blue_mushroom_spore'}, rarity = 5},
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
})

local chance = 10
local interval = 30

minetest.register_abm({
	nodenames = "lottfarming:blue_mushroom_1",
	interval = interval,
	chance = chance,
	action = function(pos, node)
		pos.y = pos.y-1
		if minetest.get_node(pos).name ~= "lottfarming:decay_tree" then
			return
		end
		pos.y = pos.y+1
		if not minetest.get_node_light(pos) then
			return
		end
		if minetest.get_node_light(pos) > 8 then
			return
		end
		minetest.set_node(pos, {name='lottfarming:blue_mushroom_2', param2 = 9})
	end
})

minetest.register_abm({
	nodenames = "lottfarming:blue_mushroom_2",
	interval = interval,
	chance = chance,
	action = function(pos, node)
		pos.y = pos.y-1
		if minetest.get_node(pos).name ~= "lottfarming:decay_tree" then
			return
		end
		pos.y = pos.y+1
		if not minetest.get_node_light(pos) then
			return
		end
		if minetest.get_node_light(pos) > 8 then
			return
		end
		minetest.set_node(pos, {name='lottfarming:blue_mushroom_3', param2 = 9})
	end
})

minetest.register_abm({
	nodenames = "lottfarming:blue_mushroom_3",
	interval = interval,
	chance = chance,
	action = function(pos, node)
		pos.y = pos.y-1
		if
			minetest.get_node(pos).name ~= "lottfarming:decay_tree" and
			minetest.get_node(pos).name ~= "default:tree"
		then
			return
		end
		pos.y = pos.y+1
		if not minetest.get_node_light(pos) then
			return
		end
		if minetest.get_node_light(pos) > 8 then
			return
		end
		minetest.set_node(pos, {name='lottfarming:blue_mushroom_4', param2 = 9})
	end
})

num = PseudoRandom(111)

minetest.register_abm({
	nodenames = "lottfarming:blue_mushroom_3",
	interval = interval,
	chance = chance,
	action = function(pos, node)
		pos.x = pos.x + num:next(-1, 1)
		pos.z = pos.z + num:next(-1, 1)
		local name
		if minetest.get_node(pos).name=="air" then
			pos.y = pos.y-1
			name = minetest.get_node(pos).name
			if name=="default:tree" then
				pos.y=pos.y+1
				minetest.set_node(pos, {name='lottfarming:blue_mushroom_3', param2 = 9})
			end
			if name=="air" then
				pos.y=pos.y-1
				name = minetest.get_node(pos).name
				if name=="default:tree" then
					pos.y=pos.y+1
					minetest.set_node(pos, {name='lottfarming:blue_mushroom_3', param2 = 9})
				end
			end

		end
		pos.y=pos.y+1
		if minetest.get_node(pos).name=="air" then
			pos.y = pos.y-1
			name = minetest.get_node(pos).name
			if name=="default:tree" then
				pos.y=pos.y+1
				minetest.set_node(pos, {name='lottfarming:blue_mushroom_3', param2 = 9})
			end
		end
	end
})

minetest.register_craftitem("lottfarming:mushroom_soup", {
	description = SL("Cream of Mushroom Soup"),
	inventory_image = "lottfarming_mushroom_soup.png",
	on_use = minetest.item_eat(6),
})
