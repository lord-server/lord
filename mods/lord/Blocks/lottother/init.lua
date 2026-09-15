local S = core.get_mod_translator()

dofile(core.get_modpath("lottother") .. "/rings.lua")
dofile(core.get_modpath("lottother") .. "/ms.lua")
dofile(core.get_modpath("lottother") .. "/flags.lua")

core.register_node("lottother:blue_torch", {
	description         = S("Blue Torch"),
	drawtype            = "torchlike",
	tiles               = {
		{
			name      = "lottother_blue_torch_floor_animated.png",
			animation = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.0 }
		},
		{
			name      = "lottother_blue_torch_ceiling_animated.png",
			animation = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.0 }
		},
		{
			name      = "lottother_blue_torch_animated.png",
			animation = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.0 }
		}
	},
	inventory_image     = "lottother_blue_torch_floor.png",
	wield_image         = "lottother_blue_torch_floor.png",
	paramtype           = "light",
	paramtype2          = "wallmounted",
	sunlight_propagates = true,
	is_ground_content   = false,
	walkable            = false,
	floodable           = true,
	on_flood = function(pos, oldnode, newnode) -- Взято из default/torch.lua
		core.add_item(pos, ItemStack("lottother:blue_torch 1"))
		-- Play flame-extinguish sound if liquid is not an 'igniter'
		local nodedef = core.registered_items[newnode.name]
		if not (nodedef and nodedef.groups and
				nodedef.groups.igniter and nodedef.groups.igniter > 0) then
			core.sound_play(
				"default_cool_lava",
				{pos = pos, max_hear_distance = 16, gain = 0.1},
				true
			)
		end
		-- Remove the torch node
		return false
	end,
	light_source        = default.LIGHT_MAX - 1,
	selection_box       = {
		type        = "wallmounted",
		wall_top    = { -0.1, 0.5 - 0.6, -0.1, 0.1, 0.5, 0.1 },
		wall_bottom = { -0.1, -0.5, -0.1, 0.1, -0.5 + 0.6, 0.1 },
		wall_side   = { -0.5, -0.3, -0.1, -0.5 + 0.3, 0.3, 0.1 },
	},
	groups              = { choppy = 2, dig_immediate = 3, flammable = 1, attached_node = 1, hot = 2, forbidden = 1 },
	legacy_wallmounted  = true,
	sounds              = default.node_sound_defaults(),
})
core.register_node("lottother:orc_torch", {
	description         = S("Orc Torch"),
	drawtype            = "torchlike",
	tiles               = {
		{
			name = "lottother_orc_torch_floor_animated.png",
			animation = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.0 }
		},
		{
			name = "lottother_orc_torch_ceiling_animated.png",
			animation = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.0 }
		},
		{
			name = "lottother_orc_torch_animated.png",
			animation = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.0 }
		},
	},
	inventory_image     = "lottother_orc_torch_floor.png",
	wield_image         = "lottother_orc_torch_floor.png",
	paramtype           = "light",
	paramtype2          = "wallmounted",
	sunlight_propagates = true,
	is_ground_content   = false,
	walkable            = false,
	floodable           = true,
	on_flood = function(pos, oldnode, newnode) -- Взято из default/torch.lua
		core.add_item(pos, ItemStack("lottother:orc_torch 1"))
		-- Play flame-extinguish sound if liquid is not an 'igniter'
		local nodedef = core.registered_items[newnode.name]
		if not (nodedef and nodedef.groups and
				nodedef.groups.igniter and nodedef.groups.igniter > 0) then
			core.sound_play(
				"default_cool_lava",
				{pos = pos, max_hear_distance = 16, gain = 0.1},
				true
			)
		end
		-- Remove the torch node
		return false
	end,
	light_source        = default.LIGHT_MAX - 3,
	selection_box       = {
		type        = "wallmounted",
		wall_top    = { -0.1, 0.5 - 0.6, -0.1, 0.1, 0.5, 0.1 },
		wall_bottom = { -0.1, -0.5, -0.1, 0.1, -0.5 + 0.6, 0.1 },
		wall_side   = { -0.5, -0.3, -0.1, -0.5 + 0.3, 0.3, 0.1 },
	},
	groups              = { choppy = 2, dig_immediate = 3, flammable = 1, attached_node = 1, hot = 2 },
	legacy_wallmounted  = true,
	sounds              = default.node_sound_defaults(),
})

core.register_node("lottother:blue_flame", {
	description       = S("Blue Flame"),
	drawtype          = "firelike",
	paramtype         = "light",
	tiles             = { {
							  name      = "lottother_blue_flame_animated.png",
							  animation = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1 },
						  } },
	inventory_image   = "lottother_blue_flame.png",
	light_source      = 14,
	groups            = { igniterblue = 2, dig_immediate = 3, hot = 3 },
	drop              = '',
	walkable          = false,
	buildable_to      = true,
	damage_per_second = 4,
	damage_groups     = { fire = true, },
	after_place_node  = function(pos, placer)
		-- Removed in new MTG/fire : issue 479
		--fire.on_flame_add_at(pos)
	end,

	after_dig_node    = function(pos, oldnode, oldmetadata, digger)
		-- Removed in new MTG/fire : issue 479
		--fire.on_flame_remove_at(pos)
	end,
})

lottother        = {}
lottother.D      = 6
lottother.sounds = {}

function lottother.get_area_p0p1(pos)
	local p0 = {
		x = math.floor(pos.x / lottother.D) * lottother.D,
		y = math.floor(pos.y / lottother.D) * lottother.D,
		z = math.floor(pos.z / lottother.D) * lottother.D,
	}
	local p1 = {
		x = p0.x + lottother.D - 1,
		y = p0.y + lottother.D - 1,
		z = p0.z + lottother.D - 1
	}
	return p0, p1
end

function lottother.update_sounds_around(pos)
	local p0, p1            = lottother.get_area_p0p1(pos)
	local cp                = { x = (p0.x + p1.x) / 2, y = (p0.y + p1.y) / 2, z = (p0.z + p1.z) / 2 }
	local flames_p          = core.find_nodes_in_area(p0, p1, { "lottother:blue_flame" })
	local should_have_sound = (#flames_p > 0)
	local wanted_sound      = nil
	if #flames_p >= 9 then
		wanted_sound = { name = "fire_large", gain = 1.5 }
	elseif #flames_p > 0 then
		wanted_sound = { name = "fire_small", gain = 1.5 }
	end
	local p0_hash = core.hash_node_position(p0)
	local sound   = lottother.sounds[p0_hash]
	if not sound then
		if should_have_sound then
			lottother.sounds[p0_hash] = {
				handle = core.sound_play(wanted_sound, { pos = cp, loop = true }),
				name   = wanted_sound.name,
			}
		end
	else
		if not wanted_sound then
			core.sound_stop(sound.handle)
			lottother.sounds[p0_hash] = nil
		elseif sound.name ~= wanted_sound.name then
			core.sound_stop(sound.handle)
			lottother.sounds[p0_hash] = {
				handle = core.sound_play(wanted_sound, { pos = cp, loop = true }),
				name   = wanted_sound.name,
			}
		end
	end
end

function lottother.on_flame_add_at(pos)
	lottother.update_sounds_around(pos)
end

function lottother.on_flame_remove_at(pos)
	lottother.update_sounds_around(pos)
end

function lottother.find_pos_for_flame_around(pos)
	return core.find_node_near(pos, 1, { "air" })
end

function lottother.flame_should_extinguish(pos)
	if core.settings:get_bool("disable_lottother") then return true end
	local p0 = { x = pos.x - 2, y = pos.y, z = pos.z - 2 }
	local p1 = { x = pos.x + 2, y = pos.y, z = pos.z + 2 }
	local ps = core.find_nodes_in_area(p0, p1, { "group:puts_out_lottother" })
	return (#ps ~= 0)
end

core.register_abm({
	nodenames = { "group:flammableblue" },
	neighbors = { "group:igniterblue" },
	interval  = 1,
	chance    = 2,
	action    = function(p0, node, _, _)
		if lottother.flame_should_extinguish(p0) then
			return
		end
		local p = lottother.find_pos_for_flame_around(p0)
		if p then
			core.set_node(p, { name = "lottother:blue_flame" })
			lottother.on_flame_add_at(p)
		end
	end,
})

core.register_abm({
	nodenames = { "group:igniterblue" },
	neighbors = { "air" },
	interval  = 2,
	chance    = 10,
	action    = function(p0, node, _, _)
		local reg = core.registered_nodes[node.name]
		if not reg or not reg.groups.igniterblue or reg.groups.igniterblue < 2 then
			return
		end
		local d = reg.groups.igniterblue
		local p = core.find_node_near(p0, d, { "group:flammableblue" })
		if p then
			if lottother.flame_should_extinguish(p) then
				return
			end
			local p2 = lottother.find_pos_for_flame_around(p)
			if p2 then
				core.set_node(p2, { name = "lottother:blue_flame" })
				lottother.on_flame_add_at(p2)
			end
		end
	end,
})

core.register_abm({
	nodenames = { "lottother:blue_flame" },
	interval  = 1,
	chance    = 2,
	action    = function(p0, node, _, _)
		if lottother.flame_should_extinguish(p0) then
			core.remove_node(p0)
			lottother.on_flame_remove_at(p0)
			return
		end
		if math.random(1, 3) == 1 then
			return
		end
		if not core.find_node_near(p0, 1, { "group:flammableblue" }) then
			core.remove_node(p0)
			lottother.on_flame_remove_at(p0)
			return
		end
		if math.random(1, 4) == 1 then
			local p = core.find_node_near(p0, 1, { "group:flammableblue" })
			if p then
				if lottother.flame_should_extinguish(p0) then
					return
				end
				core.remove_node(p)
				core.check_for_falling(p)
			end
		else
			core.remove_node(p0)
			lottother.on_flame_remove_at(p0)
		end
	end,
})

core.register_craft({
	output = 'lottother:blue_torch 2',
	recipe = {
		{ 'lottores:rough_rock_lump' },
		{ 'group:stick' },
	}
})
core.register_craft({
	output = 'lottother:orc_torch 2',
	recipe = {
		{ 'bones:bone' },
		{ 'group:stick' },
	}
})

core.register_node("lottother:dirt", {
	description       = S("Dirt Substitute"),
	tiles             = { "default_dirt.png" },
	is_ground_content = true,
	drop              = 'default:dirt',
	groups            = { crumbly = 3, soil = 1, not_in_creative_inventory = 1 },
	sounds            = default.node_sound_dirt_defaults(),
})

core.register_node("lottother:snow", {
	description       = S("Snow Substitute"),
	tiles             = { "default_snow.png" },
	is_ground_content = true,
	drop              = 'default:snowblock',
	freezemelt        = "default:water_source",
	groups            = { crumbly = 3, melts = 1, not_in_creative_inventory = 1 },
	sounds            = default.node_sound_dirt_defaults({
		footstep = { name = "default_snow_footstep", gain = 0.25 },
		dug      = { name = "default_snow_footstep", gain = 0.75 },
	}),
})

core.register_node("lottother:mordor_stone", {
	description       = S("Mordor Stone Substitute"),
	tiles             = { "lord_rocks_mordor_stone.png" },
	is_ground_content = true,
	drop              = 'lord_rocks:mordor_stone',
	groups            = { cracky = 3, stone = 1, not_in_creative_inventory = 1 },
	sounds            = default.node_sound_stone_defaults(),
})

core.register_node("lottother:air", {
	description         = S("Air Substitute"),
	drawtype            = "glasslike",
	tiles               = { "lottother_air.png" },
	paramtype           = "light",
	sunlight_propagates = true,
	is_ground_content   = false,
	walkable            = false,
	buildable_to        = true,
	pointable           = false,
	groups              = { not_in_creative_inventory = 1, dig_immediate = 3 },
	sounds              = default.node_sound_glass_defaults(),
})

core.register_abm({
	nodenames = { "lottother:dirt" },
	neighbors = { "air" },
	interval  = 5,
	chance    = 1,
	action    = function(pos, node, active_object_count, active_object_count_wider)
		local x     = pos.x
		local y     = pos.y
		local z     = pos.z
		local down  = { x = x, y = y - 1, z = z }
		local down2 = { x = x, y = y - 2, z = z }
		local down3 = { x = x, y = y - 3, z = z }
		local down4 = { x = x, y = y - 4, z = z }
		local down5 = { x = x, y = y - 5, z = z }
		local down6 = { x = x, y = y - 6, z = z }
		local down7 = { x = x, y = y - 7, z = z }
		if core.get_node(down).name == "air" then
			core.set_node(down, { name = "default:dirt" })
			core.set_node(down2, { name = "default:dirt" })
			core.set_node(down3, { name = "default:dirt" })
			core.set_node(down4, { name = "default:dirt" })
			core.set_node(down5, { name = "default:dirt" })
			core.set_node(down6, { name = "default:dirt" })
			core.set_node(down7, { name = "lottother:dirt" })
		end
	end,
})

core.register_abm({
	nodenames = { "lottother:snow" },
	neighbors = { "air" },
	interval  = 5,
	chance    = 1,
	action    = function(pos, node, active_object_count, active_object_count_wider)
		local x     = pos.x
		local y     = pos.y
		local z     = pos.z
		local down  = { x = x, y = y - 1, z = z }
		local down2 = { x = x, y = y - 2, z = z }
		local down3 = { x = x, y = y - 3, z = z }
		local down4 = { x = x, y = y - 4, z = z }
		local down5 = { x = x, y = y - 5, z = z }
		local down6 = { x = x, y = y - 6, z = z }
		local down7 = { x = x, y = y - 7, z = z }
		if core.get_node(down).name == "air" then
			core.set_node(down, { name = "default:snowblock" })
			core.set_node(down2, { name = "default:snowblock" })
			core.set_node(down3, { name = "default:snowblock" })
			core.set_node(down4, { name = "default:snowblock" })
			core.set_node(down5, { name = "default:snowblock" })
			core.set_node(down6, { name = "default:snowblock" })
			core.set_node(down7, { name = "lottother:snow" })
		end
	end,
})

core.register_abm({
	nodenames = { "lottother:mordor_stone" },
	neighbors = { "air" },
	interval  = 5,
	chance    = 1,
	action    = function(pos, node, active_object_count, active_object_count_wider)
		local x     = pos.x
		local y     = pos.y
		local z     = pos.z
		local down  = { x = x, y = y - 1, z = z }
		local down2 = { x = x, y = y - 2, z = z }
		local down3 = { x = x, y = y - 3, z = z }
		local down4 = { x = x, y = y - 4, z = z }
		local down5 = { x = x, y = y - 5, z = z }
		local down6 = { x = x, y = y - 6, z = z }
		local down7 = { x = x, y = y - 7, z = z }
		if core.get_node(down).name == "air" then
			core.set_node(down, { name = "lord_rocks:mordor_stone" })
			core.set_node(down2, { name = "lord_rocks:mordor_stone" })
			core.set_node(down3, { name = "lord_rocks:mordor_stone" })
			core.set_node(down4, { name = "lord_rocks:mordor_stone" })
			core.set_node(down5, { name = "lord_rocks:mordor_stone" })
			core.set_node(down6, { name = "lord_rocks:mordor_stone" })
			core.set_node(down7, { name = "lottother:mordor_stone" })
		end
	end,
})

core.register_abm({
	nodenames = { "lottother:dirt" },
	neighbors = { "default:dirt" },
	interval  = 150,
	chance    = 1,
	action    = function(pos, node, active_object_count, active_object_count_wider)
		local x    = pos.x
		local y    = pos.y
		local z    = pos.z
		local here = { x = x, y = y, z = z }
		core.set_node(here, { name = "default:dirt" })
	end,
})

core.register_abm({
	nodenames = { "lottother:snow" },
	neighbors = { "default:snowblock" },
	interval  = 150,
	chance    = 1,
	action    = function(pos, node, active_object_count, active_object_count_wider)
		local x    = pos.x
		local y    = pos.y
		local z    = pos.z
		local here = { x = x, y = y, z = z }
		core.set_node(here, { name = "default:snowblock" })
	end,
})

core.register_abm({
	nodenames = { "lottother:mordor_stone" },
	neighbors = { "lord_rocks:mordor_stone" },
	interval  = 150,
	chance    = 1,
	action    = function(pos, node, active_object_count, active_object_count_wider)
		local x    = pos.x
		local y    = pos.y
		local z    = pos.z
		local here = { x = x, y = y, z = z }
		core.set_node(here, { name = "lord_rocks:mordor_stone" })
	end,
})

core.register_abm({
	nodenames = { "lottother:air" },
	interval  = 7,
	chance    = 1,
	action    = function(pos, node, active_object_count, active_object_count_wider)
		core.remove_node(pos)
	end,
})
