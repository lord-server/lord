local S = minetest.get_mod_translator()

--elf
minetest.register_craftitem(":lottother:blue_torch", {
	description = S("Elven Torch"),
	inventory_image = "lottother_blue_torch_floor.png",
	groups = {wooden = 1},
	wield_image = "lottother_blue_torch_floor.png",
	wield_scale = {x = 1, y = 1, z = 1 + 1/16},
	liquids_pointable = false,
	light_source = 14,
	on_place = function(itemstack, placer, pointed_thing)
		local above = pointed_thing.above
		local under = pointed_thing.under
		local nu = minetest.get_node(under)
		if minetest.registered_nodes[nu.name].on_rightclick then
			return minetest.registered_nodes[nu.name].on_rightclick(under, nu, placer, itemstack)
		end
		local wdir = minetest.dir_to_wallmounted({x = under.x - above.x, y = under.y - above.y, z = under.z - above.z})
		if wdir < 1 and not torches.enable_ceiling then
			return itemstack
		end
		local fakestack = itemstack
		local retval
		if wdir <= 1 then
			retval = fakestack:set_name("torches:blue_floor")
		else
			retval = fakestack:set_name("torches:blue_wall")
		end
		if not retval then
			return itemstack
		end
		-- Использовалась пер. dir, но она не объявлена
		itemstack = minetest.item_place(fakestack, placer, pointed_thing, nil --[[dir]])
		itemstack:set_name("lottother:blue_torch")

		return itemstack
	end
})

minetest.register_node("torches:blue_floor", {
	drawtype = "mesh",
	mesh = "torch_floor.obj",
	tiles = {
		{
		    name = "lottother_blue_torch_floor_animated.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
		}
	},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	floodable = true,
	on_flood = function(pos, oldnode, newnode) -- Взято из default/torch.lua
		minetest.add_item(pos, ItemStack("lottother:blue_torch 1"))
		-- Play flame-extinguish sound if liquid is not an 'igniter'
		local nodedef = minetest.registered_items[newnode.name]
		if not (nodedef and nodedef.groups and
				nodedef.groups.igniter and nodedef.groups.igniter > 0) then
			minetest.sound_play(
				"default_cool_lava",
				{pos = pos, max_hear_distance = 16, gain = 0.1},
				true
			)
		end
		-- Remove the torch node
		return false
	end,
	light_source = 14,
	groups = {choppy=2, dig_immediate=3, flammable=1, not_in_creative_inventory=1, attached_node=1, torch=1},
	drop = "lottother:blue_torch",
	selection_box = {
		type = "wallmounted",
		wall_top = {-1/16, -2/16, -1/16, 1/16, 0.5, 1/16},
		wall_bottom = {-1/16, -0.5, -1/16, 1/16, 2/16, 1/16},
	},
})

minetest.register_node("torches:blue_wall", {
	drawtype = "mesh",
	mesh = "torch_wall.obj",
	tiles = {
		{
		    name = "lottother_blue_torch_floor_animated.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
		}
	},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	floodable = true,
	on_flood = function(pos, oldnode, newnode) -- Взято из default/torch.lua
		minetest.add_item(pos, ItemStack("lottother:blue_torch 1"))
		-- Play flame-extinguish sound if liquid is not an 'igniter'
		local nodedef = minetest.registered_items[newnode.name]
		if not (nodedef and nodedef.groups and
				nodedef.groups.igniter and nodedef.groups.igniter > 0) then
			minetest.sound_play(
				"default_cool_lava",
				{pos = pos, max_hear_distance = 16, gain = 0.1},
				true
			)
		end
		-- Remove the torch node
		return false
	end,
	light_source = 14,
	groups = {choppy=2, dig_immediate=3, flammable=1, not_in_creative_inventory=1, attached_node=1, torch=1},
	drop = "lottother:blue_torch",
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, -0.1, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, 0.1, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.2, 0.3, 0.1},
	},
})

-- convert old torches and remove ceiling placed
minetest.register_abm({
	nodenames = {"lottother:blue_torch"},
	interval = 1,
	chance = 1,
	action = function(pos)
		local n = minetest.get_node(pos)
		local def = minetest.registered_nodes[n.name]
		if n and def then
			local wdir = n.param2
			local node_name = "torches:blue_wall"
			if wdir < 1 and not torches.enable_ceiling then
				minetest.remove_node(pos)
				return
			elseif wdir <= 1 then
				node_name = "torches:blue_floor"
			end
			minetest.set_node(pos, {name = node_name, param2 = wdir})
		end
	end
})


--orc
minetest.register_craftitem(":lottother:orc_torch", {
	description       = S("Orcish Torch"),
	inventory_image   = "lottother_orc_torch_floor.png",
	wield_image       = "lottother_orc_torch_floor.png",
	wield_scale       = { x = 1, y = 1, z = 1 + 1 / 16 },
	groups            = { wooden = 1 },
	liquids_pointable = false,
	light_source      = 8,
	on_place          = function(itemstack, placer, pointed_thing)
		local above = pointed_thing.above
		local under = pointed_thing.under
		local nu    = minetest.get_node(under)
		if minetest.registered_nodes[nu.name].on_rightclick then
			return minetest.registered_nodes[nu.name].on_rightclick(under, nu, placer, itemstack)
		end
		local wdir = minetest.dir_to_wallmounted({ x = under.x - above.x, y = under.y - above.y, z = under.z - above.z })
		if wdir < 1 and not torches.enable_ceiling then
			return itemstack
		end
		local fakestack = itemstack
		local retval
		if wdir <= 1 then
			retval = fakestack:set_name("torches:orc_floor")
		else
			retval = fakestack:set_name("torches:orc_wall")
		end
		if not retval then
			return itemstack
		end
		-- Использовалась пер. dir, но она не объявлена
		itemstack = minetest.item_place(fakestack, placer, pointed_thing, nil --[[dir]])
		itemstack:set_name("lottother:orc_torch")
		return itemstack
	end
})

minetest.register_node("torches:orc_floor", {
	drawtype = "mesh",
	mesh = "torch_floor.obj",
	tiles = {
		{
		    name = "lottother_orc_torch_floor_animated.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
		}
	},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	floodable = true,
	on_flood = function(pos, oldnode, newnode) -- Взято из default/torch.lua
		minetest.add_item(pos, ItemStack("lottother:orc_torch 1"))
		-- Play flame-extinguish sound if liquid is not an 'igniter'
		local nodedef = minetest.registered_items[newnode.name]
		if not (nodedef and nodedef.groups and
				nodedef.groups.igniter and nodedef.groups.igniter > 0) then
			minetest.sound_play(
				"default_cool_lava",
				{pos = pos, max_hear_distance = 16, gain = 0.1},
				true
			)
		end
		-- Remove the torch node
		return false
	end,
	light_source = 8,
	groups = {choppy=2, dig_immediate=3, flammable=1, not_in_creative_inventory=1, attached_node=1, torch=1},
	drop = "lottother:orc_torch",
	selection_box = {
		type = "wallmounted",
		wall_top = {-1/16, -2/16, -1/16, 1/16, 0.5, 1/16},
		wall_bottom = {-1/16, -0.5, -1/16, 1/16, 2/16, 1/16},
	},
})

minetest.register_node("torches:orc_wall", {
	drawtype = "mesh",
	mesh = "torch_wall.obj",
	tiles = {
		{
		    name = "lottother_orc_torch_floor_animated.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3}
		}
	},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	floodable = true,
	on_flood = function(pos, oldnode, newnode) -- Взято из default/torch.lua
		minetest.add_item(pos, ItemStack("lottother:orc_torch 1"))
		-- Play flame-extinguish sound if liquid is not an 'igniter'
		local nodedef = minetest.registered_items[newnode.name]
		if not (nodedef and nodedef.groups and
				nodedef.groups.igniter and nodedef.groups.igniter > 0) then
			minetest.sound_play(
				"default_cool_lava",
				{pos = pos, max_hear_distance = 16, gain = 0.1},
				true
			)
		end
		-- Remove the torch node
		return false
	end,
	light_source = 8,
	groups = {choppy=2, dig_immediate=3, flammable=1, not_in_creative_inventory=1, attached_node=1, torch=1},
	drop = "lottother:orc_torch",
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, -0.1, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, 0.1, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.2, 0.3, 0.1},
	},
})

-- convert old torches and remove ceiling placed
minetest.register_abm({
	nodenames = {"lottother:orc_torch"},
	interval = 1,
	chance = 1,
	action = function(pos)
		local n = minetest.get_node(pos)
		local def = minetest.registered_nodes[n.name]
		if n and def then
			local wdir = n.param2
			local node_name = "torches:orc_wall"
			if wdir < 1 and not torches.enable_ceiling then
				minetest.remove_node(pos)
				return
			elseif wdir <= 1 then
				node_name = "torches:orc_floor"
			end
			minetest.set_node(pos, {name = node_name, param2 = wdir})
		end
	end
})

