local S = default.get_translator
-- mods/default/nodes.lua


-- Stone / Камень
minetest.register_node("default:stone", {
	description       = S("Stone"),
	tiles             = { "default_stone.png" },
	is_ground_content = true,
	groups            = { cracky = 3, stone = 1 },
	drop              = 'default:cobble',
	legacy_mineral    = true,
	sounds            = default.node_sound_stone_defaults(),
})

minetest.register_node("default:desert_stone", {
	description       = S("Desert Stone"),
	tiles             = { "default_desert_stone.png" },
	is_ground_content = true,
	groups            = { cracky = 3, stone = 1 },
	drop              = 'default:desert_cobble',
	legacy_mineral    = true,
	sounds            = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_with_coal", {
	description       = S("Coal Ore"),
	tiles             = { "default_stone.png^default_mineral_coal.png" },
	is_ground_content = true,
	groups            = { cracky = 3 },
	drop              = 'default:coal_lump',
	sounds            = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_with_iron", {
	description       = S("Iron Ore"),
	tiles             = { "default_stone.png^default_mineral_iron.png" },
	is_ground_content = true,
	groups            = { cracky = 2 },
	drop              = 'default:iron_lump',
	sounds            = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_with_copper", {
	description       = S("Copper Ore"),
	tiles             = { "default_stone.png^default_mineral_copper.png" },
	is_ground_content = true,
	groups            = { cracky = 2 },
	drop              = 'default:copper_lump',
	sounds            = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_with_mese", {
	description       = S("Mese Ore"),
	tiles             = { "default_stone.png^default_mineral_mese.png" },
	is_ground_content = true,
	groups            = { cracky = 1 },
	drop              = "default:mese_crystal",
	sounds            = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_with_gold", {
	description       = S("Gold Ore"),
	tiles             = { "default_stone.png^default_mineral_gold.png" },
	is_ground_content = true,
	groups            = { cracky = 2 },
	drop              = "default:gold_lump",
	sounds            = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_with_diamond", {
	description       = S("Diamond Ore"),
	tiles             = { "default_stone.png^default_mineral_diamond.png" },
	is_ground_content = true,
	groups            = { cracky = 1 },
	drop              = "default:diamond",
	sounds            = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stonebrick", {
	description = S("Stone Brick"),
	tiles       = { "default_stone_brick.png" },
	groups      = { cracky = 2, stone = 1 },
	sounds      = default.node_sound_stone_defaults(),
})

minetest.register_node("default:stone_block", {
	description = S("Stone Block"),
	tiles = {"default_stone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:desert_stonebrick", {
	description = S("Desert Brick"),
	tiles       = { "default_desert_stone_brick.png" },
	groups      = { cracky = 2, stone = 1 },
	sounds      = default.node_sound_stone_defaults(),
})

minetest.register_node("default:desert_stone_block", {
	description = S("Desert Stone Block"),
	tiles = {"default_desert_stone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2, stone = 1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("default:desert_sandstone", {
	description = S("Desert Sandstone"),
	tiles = {"default_desert_sandstone.png"},
	groups = {crumbly = 1, cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:desert_sandstone_brick", {
	description = S("Desert Sandstone Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"default_desert_sandstone_brick.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:desert_sandstone_block", {
	description = S("Desert Sandstone Block"),
	tiles = {"default_desert_sandstone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})


-- Dirt / Земля (мягкие породы)
minetest.register_node("default:dirt_with_grass", {
	description       = S("Dirt with Grass"),
	tiles             = {
		"default_grass.png",
		"default_dirt.png",
		{ name = "default_dirt.png^default_grass_side.png", tileable_vertical = false }
	},
	is_ground_content = true,
	groups            = { crumbly = 3, soil = 1 },
	drop              = 'default:dirt',
	sounds            = default.node_sound_dirt_defaults({
		footstep = { name = "default_grass_footstep", gain = 0.25 },
	}),
})

minetest.register_node("default:dirt_with_grass_footsteps", {
	description       = S("Dirt with Grass and Footsteps"),
	tiles             = {
		"default_grass_footsteps.png",
		"default_dirt.png",
		{ name = "default_dirt.png^default_grass_side.png", tileable_vertical = false }
	},
	is_ground_content = true,
	groups            = { crumbly = 3, soil = 1, not_in_creative_inventory = 1 },
	drop              = 'default:dirt',
	sounds            = default.node_sound_dirt_defaults({
		footstep = { name = "default_grass_footstep", gain = 0.25 },
	}),
})

minetest.register_node("default:dirt_with_snow", {
	description       = S("Dirt with Snow"),
	tiles             = {
		"default_snow.png",
		"default_dirt.png",
		{ name = "default_dirt.png^default_snow_side.png", tileable_vertical = false }
	},
	is_ground_content = true,
	groups            = { crumbly = 3 },
	drop              = 'default:dirt',
	sounds            = default.node_sound_dirt_defaults({
		footstep = { name = "default_snow_footstep", gain = 0.15 },
	}),
})

minetest.register_node("default:dirt", {
	description       = S("Dirt"),
	tiles             = { "default_dirt.png" },
	is_ground_content = true,
	groups            = { crumbly = 3, soil = 1 },
	sounds            = default.node_sound_dirt_defaults(),
})

local function set_grass(pos)
	local count_grasses = {};
	local curr_max      = 0;
	local curr_type     = "lottmapgen:default_grass";

	local positions     = minetest.find_nodes_in_area({ x = (pos.x - 2), y = (pos.y - 2), z = (pos.z - 2) },
		{ x = (pos.x + 2), y = (pos.y + 2), z = (pos.z + 2) }, "group:lottmapgen_grass");
	for _, p in ipairs(positions) do
		local n = minetest.get_node(p);
		if (n and n.name) then
			if (not (count_grasses[n.name])) then
				count_grasses[n.name] = 1;
			else
				count_grasses[n.name] = count_grasses[n.name] + 1;
			end
			if (count_grasses[n.name] > curr_max) then
				curr_max  = count_grasses[n.name];
				curr_type = n.name;
			end
		end
	end
	minetest.set_node(pos, { name = curr_type })
end

minetest.register_abm({
	nodenames = { "default:dirt" },
	interval  = 2,
	chance    = 200,
	action    = function(pos, node)
		local above   = { x = pos.x, y = pos.y + 1, z = pos.z }
		local name    = minetest.get_node(above).name
		local nodedef = minetest.registered_nodes[name]
		if nodedef and (nodedef.sunlight_propagates or nodedef.paramtype == "light")
			and nodedef.liquidtype == "none"
			and (minetest.get_node_light(above) or 0) >= 13 then
			if name == "default:snow" or name == "default:snowblock" then
				minetest.set_node(pos, { name = "default:dirt_with_snow" })
			else
				set_grass(pos)
			end
		end
	end
})

minetest.register_abm({
	nodenames = { "default:dirt_with_grass" },
	interval  = 2,
	chance    = 20,
	action    = function(pos, node)
		local above   = { x = pos.x, y = pos.y + 1, z = pos.z }
		local name    = minetest.get_node(above).name
		local nodedef = minetest.registered_nodes[name]
		if name ~= "ignore" and nodedef
			and not ((nodedef.sunlight_propagates or nodedef.paramtype == "light")
			and nodedef.liquidtype == "none") then
			minetest.set_node(pos, { name = "default:dirt" })
		end
	end
})

minetest.register_node("default:sand", {
	description       = S("Sand"),
	tiles             = { "default_sand.png" },
	is_ground_content = true,
	groups            = { crumbly = 3, falling_node = 1, sand = 1 },
	sounds            = default.node_sound_sand_defaults(),
})

minetest.register_node("default:desert_sand", {
	description       = S("Desert Sand"),
	tiles             = { "default_desert_sand.png" },
	is_ground_content = true,
	groups            = { crumbly = 3, falling_node = 1, sand = 1 },
	sounds            = default.node_sound_sand_defaults(),
})

minetest.register_node("default:gravel", {
	description       = S("Gravel"),
	tiles             = { "default_gravel.png" },
	is_ground_content = true,
	groups            = { crumbly = 2, falling_node = 1 },
	sounds            = default.node_sound_gravel_defaults(),
})

minetest.register_node("default:sandstone", {
	description       = S("Sandstone"),
	tiles             = { "default_sandstone.png" },
	is_ground_content = true,
	groups            = { crumbly = 2, cracky = 3 },
	sounds            = default.node_sound_stone_defaults(),
})

minetest.register_node("default:sandstonebrick", {
	description       = S("Sandstone Brick"),
	tiles             = { "default_sandstone_brick.png" },
	is_ground_content = true,
	groups            = { cracky = 2 },
	sounds            = default.node_sound_stone_defaults(),
})

minetest.register_node("default:sandstone_block", {
	description = S("Sandstone Block"),
	tiles = {"default_sandstone_block.png"},
	is_ground_content = false,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("default:clay", {
	description       = S("Clay"),
	tiles             = { "default_clay.png" },
	is_ground_content = true,
	groups            = { crumbly = 3 },
	drop              = 'default:clay_lump 4',
	sounds            = default.node_sound_dirt_defaults(),
})

minetest.register_node("default:brick", {
	description       = S("Brick Block"),
	tiles             = { "default_brick.png" },
	is_ground_content = false,
	groups            = { cracky = 3 },
	sounds            = default.node_sound_stone_defaults(),
})


-- Wood / Дерево

-- яблоня
minetest.register_node("default:tree_trunk", {
	description       = S("Tree Тrunk"),
	tiles             = { "default_tree_top.png", "default_tree_top.png", "default_tree.png" },
	paramtype2        = "facedir",
	is_ground_content = false,
	drop              = "default:tree",
	groups            = { tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2 },
	sounds            = default.node_sound_wood_defaults(),
	on_place          = minetest.rotate_node,
})

minetest.register_node("default:tree", {
	description       = S("Tree"),
	tiles             = { "default_tree_top.png", "default_tree_top.png", "default_tree.png" },
	paramtype2        = "facedir",
	is_ground_content = false,
	groups            = { tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2 },
	sounds            = default.node_sound_wood_defaults(),
	on_place          = function(itemstack, placer, pointed_thing)
		if pointed_thing.type == "node" and
			minetest.registered_nodes[minetest.get_node(pointed_thing.above).name].buildable_to == true then

			local p0     = pointed_thing.under  -- куда смотрим
			local p1     = pointed_thing.above  -- куда ставим
			local param2 = 0
			local p3     = { x = p1.x, y = p1.y, z = p1.z }
			p3.y         = p3.y + 1

			if minetest.is_protected(p1, placer:get_player_name()) or
				minetest.is_protected(p3, placer:get_player_name()) then
				minetest.record_protection_violation(p1, placer:get_player_name())
				return itemstack
			end

			local placer_pos = placer:getpos()
			if placer_pos then
				local x = math.abs(p0.x - p1.x)
				--local y = math.abs(p0.y - p1.y)
				local z = math.abs(p0.z - p1.z)

				-- установка по вектору на игрока
				--if z>x then param2 = 6 else param2 = 13 end
				-- единичку добавляем что бы получить смещение относительно головы игрока (более реально)
				--if y+1>math.max(x,z) then param2 = 0 end

				-- установка по грани узла
				if z ~= 0 then param2 = 6
				elseif x ~= 0 then param2 = 13
				else param2 = 0 end

			end
			minetest.set_node(p1, { name = "default:tree_trunk", param2 = param2 })
			if not default.creative then
				itemstack:take_item()
			end
			return itemstack
		end
	end,
	on_dig            = function(pos, node, digger)
		default.dig_tree(pos, node, "default:tree", digger, 20, 2, "default:tree")
	end,
})

minetest.register_node("default:wood", {
	description = S("Wooden Planks"),
	tiles       = { "default_wood.png" },
	groups      = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, wood = 1 },
	sounds      = default.node_sound_wood_defaults(),
	paramtype2  = "facedir",
})

-- эвкалипт
minetest.register_node("default:jungletree_trunk", {
	description       = S("Jungle Tree Trunk"),
	tiles             = { "default_jungletree_top.png", "default_jungletree_top.png", "default_jungletree.png" },
	paramtype2        = "facedir",
	is_ground_content = false,
	drop              = "default:jungletree",
	groups            = { tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2 },
	sounds            = default.node_sound_wood_defaults(),
	on_place          = minetest.rotate_node,
})

minetest.register_node("default:jungletree", {
	description       = S("Jungle Tree"),
	tiles             = { "default_jungletree_top.png", "default_jungletree_top.png", "default_jungletree.png" },
	paramtype2        = "facedir",
	is_ground_content = false,
	groups            = { tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2 },
	sounds            = default.node_sound_wood_defaults(),
	on_place          = function(itemstack, placer, pointed_thing)
		if pointed_thing.type == "node" and
			minetest.registered_nodes[minetest.get_node(pointed_thing.above).name].buildable_to == true then

			local p0     = pointed_thing.under
			local p1     = pointed_thing.above
			local param2 = 0
			local p3     = { x = p1.x, y = p1.y, z = p1.z }
			p3.y         = p3.y + 1

			if minetest.is_protected(p1, placer:get_player_name()) or
				minetest.is_protected(p3, placer:get_player_name()) then
				minetest.record_protection_violation(p1, placer:get_player_name())
				return itemstack
			end

			local placer_pos = placer:getpos()
			if placer_pos then
				local x = math.abs(p0.x - p1.x)
				--local y = math.abs(p0.y - p1.y)
				local z = math.abs(p0.z - p1.z)

				-- установка по вектору на игрока
				--if z>x then param2 = 6 else param2 = 13 end
				-- единичку добавляем что бы получить смещение относительно головы игрока (более реально)
				--if y+1>math.max(x,z) then param2 = 0 end

				-- установка по грани узла
				if z ~= 0 then param2 = 6
				elseif x ~= 0 then param2 = 13
				else param2 = 0 end

			end
			minetest.set_node(p1, { name = "default:jungletree_trunk", param2 = param2 })
			if not default.creative then
				itemstack:take_item()
			end
			return itemstack
		end
	end,
	on_dig            = function(pos, node, digger)
		default.dig_tree(pos, node, "default:jungletree", digger, 12, 5, "default:jungletree")
	end,
})

minetest.register_node("default:junglewood", {
	description = S("Junglewood Planks"),
	tiles       = { "default_junglewood.png" },
	groups      = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, wood = 1 },
	sounds      = default.node_sound_wood_defaults(),
	paramtype2  = "facedir",
})

minetest.register_node("default:jungleleaves", {
	description       = S("Jungle Leaves"),
	drawtype          = "mesh",
	mesh              = "leaves_model.obj",
	tiles             = { "default_jungleleaves.png" },
	inventory_image   = "default_jungleleaves_inv.png",
	paramtype         = "light",
	is_ground_content = false,
	walkable          = false,
	climbable         = true,
	groups            = { snappy = 3, leafdecay = 3, flammable = 2, leaves = 1 },
	drop              = {
		max_items = 1,
		items     = {
			{
				-- player will get sapling with 1/20 chance
				items  = { 'default:junglesapling' },
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = { 'default:jungleleaves' },
			}
		}
	},
	sounds            = default.node_sound_leaves_defaults(),
})

minetest.register_node("default:junglesapling", {
	description     = S("Jungle Sapling"),
	drawtype        = "plantlike",
	visual_scale    = 1.0,
	tiles           = { "default_junglesapling.png" },
	inventory_image = "default_junglesapling.png",
	wield_image     = "default_junglesapling.png",
	paramtype       = "light",
	walkable        = false,
	selection_box   = {
		type  = "fixed",
		fixed = { -0.3, -0.5, -0.3, 0.3, 0.35, 0.3 }
	},
	groups          = { snappy = 2, dig_immediate = 3, flammable = 2, attached_node = 1, sapling = 1 },
	sounds          = default.node_sound_leaves_defaults(),
})

minetest.register_node("default:junglegrass", {
	description       = S("Jungle Grass"),
	drawtype          = "plantlike",
	visual_scale      = 1.3,
	tiles             = { "default_junglegrass.png" },
	inventory_image   = "default_junglegrass.png",
	wield_image       = "default_junglegrass.png",
	paramtype         = "light",
	walkable          = false,
	buildable_to      = true,
	is_ground_content = true,
	groups            = { snappy = 3, flammable = 2, flora = 1, attached_node = 1, grass = 1 },
	sounds            = default.node_sound_leaves_defaults(),
	selection_box     = {
		type  = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -5 / 16, 0.5 },
	},
})

minetest.register_node("default:leaves", {
	description                = S("Leaves"),
	drawtype                   = "mesh",
	mesh                       = "leaves_model.obj",
	tiles                      = { "default_leaves.png" },
	inventory_image            = "default_leaves_inv.png",
	paramtype                  = "light",
	walkable                   = false,
	--climbable=true,
	liquid_viscosity           = 8,
	liquidtype                 = "source",
	liquid_alternative_flowing = "default:leaves",
	liquid_alternative_source  = "default:leaves",
	liquid_renewable           = false,
	liquid_range               = 0,

	is_ground_content          = false,
	groups                     = { snappy = 3, leafdecay = 3, flammable = 2, leaves = 1 },
	drop                       = {
		max_items = 1,
		items     = {
			{
				-- player will get sapling with 1/20 chance
				items  = { 'default:sapling' },
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = { 'default:leaves' },
			}
		}
	},
	sounds                     = default.node_sound_leaves_defaults(),
})

--
-- Plantlife (non-cubic)
--

minetest.register_node("default:cactus", {
	description = S("Cactus"),
	drawtype = "nodebox",
	tiles = {"default_cactus_top.png", "default_cactus_bottom.png", "default_cactus_side.png",
	"default_cactus_side.png","default_cactus_side.png","default_cactus_side.png"},
	is_ground_content = true,
	groups = {snappy=1, choppy=3, flammable=2, plant=1, oddly_breakable_by_hand=1},
	sounds = default.node_sound_leaves_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	drop = "flowers:cactus_decor",
	node_placement_prediction = "",
	node_box = {
		type = "fixed",
		fixed = {
			{-7/16, -8/16, -7/16,  7/16, 8/16,  7/16}, -- Main body
			{-8/16, -8/16, -7/16,  8/16, 8/16, -7/16}, -- Spikes
			{-8/16, -8/16,  7/16,  8/16, 8/16,  7/16}, -- Spikes
			{-7/16, -8/16, -8/16, -7/16, 8/16,  8/16}, -- Spikes
			{7/16,  -8/16,  8/16,  7/16, 8/16, -8/16}, -- Spikes
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {-7/16, -8/16, -7/16,  7/16, 7/16,  7/16}, -- Main body
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-7/16, -8/16, -7/16, 7/16, 8/16, 7/16},
		},
	},
	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end,
})

minetest.register_node("default:large_cactus_seedling", {
	description = S("Large Cactus Seedling"),
	drawtype = "plantlike",
	tiles = {"default_large_cactus_seedling.png"},
	inventory_image = "default_large_cactus_seedling.png",
	wield_image = "default_large_cactus_seedling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {
			-5 / 16, -0.5, -5 / 16,
			5 / 16, 0.5, 5 / 16
		}
	},
	groups = {choppy = 3, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_wood_defaults(),

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
			"default:large_cactus_seedling",
			{x = -2, y = -1, z = -2},
			{x = 2, y = 5, z = 2},
			4)

		return itemstack
	end,

	on_construct = function(pos)
		-- Normal cactus farming adds 1 cactus node by ABM,
		-- interval 12s, chance 83.
		-- Consider starting with 5 cactus nodes. We make sure that growing a
		-- large cactus is not a faster way to produce new cactus nodes.
		-- Confirmed by experiment, when farming 5 cacti, on average 1 new
		-- cactus node is added on average every
		-- 83 / 5 = 16.6 intervals = 16.6 * 12 = 199.2s.
		-- Large cactus contains on average 14 cactus nodes.
		-- 14 * 199.2 = 2788.8s.
		-- Set random range to average to 2789s.
		minetest.get_node_timer(pos):start(math.random(1859, 3719))
	end,

	on_timer = function(pos)
		local node_under = minetest.get_node_or_nil(
			{x = pos.x, y = pos.y - 1, z = pos.z})
		if not node_under then
			-- Node under not yet loaded, try later
			minetest.get_node_timer(pos):start(300)
			return
		end

		if minetest.get_item_group(node_under.name, "sand") == 0 then
			-- Seedling dies
			minetest.remove_node(pos)
			return
		end

		local light_level = minetest.get_node_light(pos)
		if not light_level or light_level < 13 then
			-- Too dark for growth, try later in case it's night
			minetest.get_node_timer(pos):start(300)
			return
		end

		minetest.log("action", "A large cactus seedling grows into a large" ..
			"cactus at ".. minetest.pos_to_string(pos))
		default.grow_large_cactus(pos)
	end,
})

minetest.register_node("default:papyrus", {
	description       = S("Papyrus"),
	drawtype          = "plantlike",
	tiles             = { "default_papyrus.png" },
	inventory_image   = "default_papyrus.png",
	wield_image       = "default_papyrus.png",
	paramtype         = "light",
	walkable          = false,
	is_ground_content = true,
	selection_box     = {
		type  = "fixed",
		fixed = { -0.3, -0.5, -0.3, 0.3, 0.5, 0.3 }
	},
	groups            = { snappy = 3, flammable = 2, grass = 1 },
	sounds            = default.node_sound_leaves_defaults(),
	after_dig_node = function(pos, node, metadata, digger)
		default.dig_up(pos, node, digger)
	end,
})

default.bookshelf_formspec = --[[
	"size[8,7;]"..
	"list[context;books;0,0.3;8,2;]"..
	"list[current_player;main;0,2.85;8,1;]"..
	"list[current_player;main;0,4.08;8,3;8]"
]]--
"size[8,9]" ..
	"list[context;books;0,0;8,2;]" ..
	"list[current_player;main;0,5;8,4;]" ..
	"listring[context;books]" ..
	"listring[current_player;main]" ..
	"background[-0.5,-0.65;9,10.35;gui_chestbg.png]" ..
	"listcolors[#606060AA;#888;#141318;#30434C;#FFF]"

minetest.register_node("default:bookshelf", {
	description                   = S("Bookshelf"),
	drawtype                      = "mesh",
	mesh                          = "3dbookshelf.obj",
	tiles                         = {
		"default_wood.png",
		"default_wood.png^3dbookshelf_inside_back.png",
		"3dbookshelf_books.png",
	},
	paramtype                     = "light",
	paramtype2                    = "facedir",
	is_ground_content             = false,
	groups                        = { choppy = 3, oddly_breakable_by_hand = 2, flammable = 3, wooden = 1 },
	sounds                        = default.node_sound_wood_defaults(),
	on_construct                  = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", S("Bookshelf"))
		meta:set_string("formspec", default.bookshelf_formspec)
		local inv = meta:get_inventory()
		inv:set_size("books", 8 * 2)
	end,
	can_dig                       = function(pos, player)
		local meta = minetest.get_meta(pos);
		local inv  = meta:get_inventory()
		return inv:is_empty("books")
	end,
	allow_metadata_inventory_put  = function(pos, listname, index, stack, player)
		if listname == "books" then
			if stack:get_definition().groups["book"] == 1 then
				return 1
			else
				return 0
			end
		end
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta     = minetest.get_meta(pos)
		local inv      = meta:get_inventory()
		local stack    = inv:get_stack(from_list, from_index)
		local to_stack = inv:get_stack(to_list, to_index)
		if to_list == "books" then
			if stack:get_definition().groups["book"] == 1 and to_stack:is_empty() then
				return 1
			else
				return 0
			end
		end
	end,
	on_metadata_inventory_move    = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff in bookshelf at " .. minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_put     = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff to bookshelf at " .. minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_take    = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" takes stuff from bookshelf at " .. minetest.pos_to_string(pos))
	end,
})

minetest.register_node("default:glass", {
	description         = S("Glass"),
	drawtype            = "glasslike_framed_optional",
	tiles               = { "default_glass.png", "default_glass_detail.png" },
	inventory_image     = minetest.inventorycube("default_glass.png"),
	paramtype           = "light",
	sunlight_propagates = true,
	is_ground_content   = false,
	groups              = { cracky = 3, oddly_breakable_by_hand = 3 },
	sounds              = default.node_sound_glass_defaults(),
})

minetest.register_node("default:fence_wood", {
	description       = S("Wooden Fence"),
	drawtype          = "fencelike",
	tiles             = { "default_wood.png" },
	inventory_image   = "default_fence.png",
	wield_image       = "default_fence.png",
	paramtype         = "light",
	is_ground_content = false,
	selection_box     = {
		type  = "fixed",
		fixed = { -1 / 7, -1 / 2, -1 / 7, 1 / 7, 1 / 2, 1 / 7 },
	},
	collision_box     = {
		type  = "fixed",
		fixed = { -1 / 2, -1 / 2, -1 / 2, 1 / 2, 1, 1 / 2 },
	},
	groups            = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wooden = 1 },
	sounds            = default.node_sound_wood_defaults(),
})
-- временно перенесено сюда при обновлении `crafting.lua`.
-- в `nodes.lua` находится примерно тут
minetest.register_craft({
	output = "default:fence_wood 6",
	recipe = {
		{"default:wood", "default:wood", "default:wood"},
		{"default:wood", "default:wood", "default:wood"},
	}
})


minetest.register_node("default:ladder_wood", {
	description        = S("Ladder"),
	drawtype           = "signlike",
	tiles              = { "default_ladder_wood.png" },
	inventory_image    = "default_ladder_wood.png",
	wield_image        = "default_ladder_wood.png",
	paramtype          = "light",
	paramtype2         = "wallmounted",
	walkable           = false,
	climbable          = true,
	is_ground_content  = false,
	selection_box      = {
		type = "wallmounted",
		--wall_top = = <default>
		--wall_bottom = = <default>
		--wall_side = = <default>
	},
	groups             = { choppy = 2, oddly_breakable_by_hand = 3, flammable = 2, wooden = 1 },
	legacy_wallmounted = true,
	sounds             = default.node_sound_wood_defaults(),
})

minetest.register_node("default:cloud", {
	description = S("Cloud"),
	tiles       = { "default_cloud.png" },
	sounds      = default.node_sound_defaults(),
	groups      = { not_in_creative_inventory = 1 },
})

minetest.register_node("default:water_flowing", {
	description                = S("Flowing Water"),
	inventory_image            = minetest.inventorycube("default_water.png"),
	drawtype                   = "flowingliquid",
	tiles                      = { "default_water.png" },
	special_tiles              = {
		{
			image            = "default_water_flowing_animated.png",
			backface_culling = false,
			animation        = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 0.8 }
		},
		{
			image            = "default_water_flowing_animated.png",
			backface_culling = true,
			animation        = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 0.8 }
		},
	},
	alpha                      = WATER_ALPHA,
	paramtype                  = "light",
	paramtype2                 = "flowingliquid",
	walkable                   = false,
	pointable                  = false,
	diggable                   = false,
	buildable_to               = true,
	drop                       = "",
	drowning                   = 1,
	liquidtype                 = "flowing",
	liquid_alternative_flowing = "default:water_flowing",
	liquid_alternative_source  = "default:water_source",
	liquid_viscosity           = WATER_VISC,
	freezemelt                 = "default:snow",
	post_effect_color          = { a = 64, r = 100, g = 100, b = 200 },
	groups                     = {
		water                     = 3,
		liquid                    = 3,
		puts_out_fire             = 1,
		not_in_creative_inventory = 1,
		freezes                   = 1,
		melt_around               = 1
	},
})

minetest.register_node("default:water_source", {
	description                = S("Water Source"),
	inventory_image            = minetest.inventorycube("default_water.png"),
	drawtype                   = "liquid",
	tiles                      = {
		{
			name      = "default_water_source_animated.png",
			animation = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0 }
		}
	},
	special_tiles              = {
		-- New-style water source material (mostly unused)
		{
			name             = "default_water_source_animated.png",
			animation        = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0 },
			backface_culling = false,
		}
	},
	alpha                      = WATER_ALPHA,
	paramtype                  = "light",
	walkable                   = false,
	pointable                  = false,
	diggable                   = false,
	buildable_to               = true,
	drop                       = "",
	drowning                   = 1,
	liquidtype                 = "source",
	liquid_alternative_flowing = "default:water_flowing",
	liquid_alternative_source  = "default:water_source",
	liquid_viscosity           = WATER_VISC,
	freezemelt                 = "default:ice",
	post_effect_color          = { a = 64, r = 100, g = 100, b = 200 },
	groups                     = { water = 3, liquid = 3, puts_out_fire = 1, freezes = 1 },
})

minetest.register_node("default:river_water_source", {
	description                = S("River Water Source"),
	inventory_image            = minetest.inventorycube("default_river_water.png"),
	drawtype                   = "liquid",
	tiles                      = {
		{
			name      = "default_river_water_source_animated.png",
			animation = {
				type     = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length   = 2.0,
			},
		},
	},
	special_tiles              = {
		{
			name             = "default_river_water_source_animated.png",
			animation        = {
				type     = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length   = 2.0,
			},
			backface_culling = false,
		},
	},
	alpha                      = 160,
	paramtype                  = "light",
	walkable                   = false,
	pointable                  = false,
	diggable                   = false,
	buildable_to               = true,
	is_ground_content          = false,
	drop                       = "",
	drowning                   = 1,
	liquidtype                 = "source",
	liquid_alternative_flowing = "default:river_water_flowing",
	liquid_alternative_source  = "default:river_water_source",
	liquid_viscosity           = 1,
	liquid_renewable           = false,
	liquid_range               = 2,
	post_effect_color          = { a = 120, r = 30, g = 76, b = 90 },
	groups                     = { water = 3, liquid = 3, puts_out_fire = 1 },
})

minetest.register_node("default:river_water_flowing", {
	description                = S("Flowing River Water"),
	inventory_image            = minetest.inventorycube("default_river_water.png"),
	drawtype                   = "flowingliquid",
	tiles                      = { "default_river_water.png" },
	special_tiles              = {
		{
			name             = "default_river_water_flowing_animated.png",
			backface_culling = false,
			animation        = {
				type     = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length   = 0.8,
			},
		},
		{
			name             = "default_river_water_flowing_animated.png",
			backface_culling = true,
			animation        = {
				type     = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length   = 0.8,
			},
		},
	},
	alpha                      = 160,
	paramtype                  = "light",
	paramtype2                 = "flowingliquid",
	walkable                   = false,
	pointable                  = false,
	diggable                   = false,
	buildable_to               = true,
	is_ground_content          = false,
	drop                       = "",
	drowning                   = 1,
	liquidtype                 = "flowing",
	liquid_alternative_flowing = "default:river_water_flowing",
	liquid_alternative_source  = "default:river_water_source",
	liquid_viscosity           = 1,
	liquid_renewable           = false,
	liquid_range               = 2,
	post_effect_color          = { a = 120, r = 30, g = 76, b = 90 },
	groups                     = { water                     = 3, liquid = 3, puts_out_fire = 1,
								   not_in_creative_inventory = 1 },
})

minetest.register_node("default:lava_flowing", {
	description                = S("Flowing Lava"),
	inventory_image            = minetest.inventorycube("default_lava.png"),
	drawtype                   = "flowingliquid",
	tiles                      = { "default_lava.png" },
	special_tiles              = {
		{
			image            = "default_lava_flowing_animated.png",
			backface_culling = false,
			animation        = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3 }
		},
		{
			image            = "default_lava_flowing_animated.png",
			backface_culling = true,
			animation        = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.3 }
		},
	},
	paramtype                  = "light",
	paramtype2                 = "flowingliquid",
	light_source               = LIGHT_MAX - 1,
	walkable                   = false,
	pointable                  = false,
	diggable                   = false,
	buildable_to               = true,
	drop                       = "",
	drowning                   = 1,
	liquidtype                 = "flowing",
	liquid_alternative_flowing = "default:lava_flowing",
	liquid_alternative_source  = "default:lava_source",
	liquid_viscosity           = LAVA_VISC,
	liquid_renewable           = false,
	damage_per_second          = 4 * 2,
	post_effect_color          = { a = 192, r = 255, g = 64, b = 0 },
	groups                     = { lava = 3, liquid = 2, hot = 3, igniter = 1, not_in_creative_inventory = 1 },
})

minetest.register_node("default:lava_source", {
	description                = S("Lava Source"),
	inventory_image            = minetest.inventorycube("default_lava.png"),
	drawtype                   = "liquid",
	tiles                      = {
		{
			name      = "default_lava_source_animated.png",
			animation = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.0 }
		}
	},
	special_tiles              = {
		-- New-style lava source material (mostly unused)
		{
			name             = "default_lava_source_animated.png",
			animation        = { type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 3.0 },
			backface_culling = false,
		}
	},
	paramtype                  = "light",
	light_source               = LIGHT_MAX - 1,
	walkable                   = false,
	pointable                  = false,
	diggable                   = false,
	buildable_to               = true,
	drop                       = "",
	drowning                   = 1,
	liquidtype                 = "source",
	liquid_alternative_flowing = "default:lava_flowing",
	liquid_alternative_source  = "default:lava_source",
	liquid_viscosity           = LAVA_VISC,
	liquid_renewable           = false,
	damage_per_second          = 4 * 2,
	post_effect_color          = { a = 192, r = 255, g = 64, b = 0 },
	groups                     = { lava = 3, liquid = 2, hot = 3, igniter = 1 },
})


minetest.register_node("default:sign_wall", {
	description         = S("Sign"),
	drawtype            = "signlike",
	tiles               = { "default_sign_wall.png" },
	inventory_image     = "default_sign_wall.png",
	wield_image         = "default_sign_wall.png",
	paramtype           = "light",
	paramtype2          = "wallmounted",
	sunlight_propagates = true,
	is_ground_content   = false,
	walkable            = false,
	selection_box       = {
		type = "wallmounted",
		--wall_top = <default>
		--wall_bottom = <default>
		--wall_side = <default>
	},
	groups              = { choppy = 2, dig_immediate = 2, attached_node = 1, wooden = 1 },
	legacy_wallmounted  = true,
	sounds              = default.node_sound_defaults(),
	on_construct        = function(pos)
		--local n = minetest.get_node(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[text;;${text}]")
		meta:set_string("infotext", "\"\"")
	end,
	on_receive_fields   = function(pos, formname, fields, sender)
		--print("Sign at "..minetest.pos_to_string(pos).." got "..dump(fields))
		if minetest.is_protected(pos, sender:get_player_name()) then
			minetest.record_protection_violation(pos, sender:get_player_name())
			return
		end
		local meta  = minetest.get_meta(pos)
		fields.text = fields.text or ""
		minetest.log("action", (sender:get_player_name() or "") .. " wrote \"" .. fields.text ..
			"\" to sign at " .. minetest.pos_to_string(pos))
		meta:set_string("text", fields.text)
		meta:set_string("infotext", '"' .. fields.text .. '"')
	end,
})

default.chest_formspec = "size[8,9]" ..
	"list[current_name;main;0,0;8,4;]" ..
	"list[current_player;main;0,5;8,4;]" ..
	"listring[current_name;main]" ..
	"listring[current_player;main]" ..
	"background[-0.5,-0.65;9,10.35;gui_chestbg.png]" ..
	"listcolors[#606060AA;#888;#141318;#30434C;#FFF]"

-- кандидат на выпиливание (на данный момент используется только в `lottblocks/chests.lua`)
-- использовать взамен `default.chest.get_chest_formspec()`,
--     переопределённый в `mods/lord/_overwrites/MTG/default/init.lua`
function default.get_chest_formspec(pos, image)
	local spos     = pos.x .. "," .. pos.y .. "," .. pos.z
	local formspec = "size[8,9]" ..
		"list[nodemeta:" .. spos .. ";main;0,0;8,4;]" ..
		"list[current_player;main;0,5;8,4;]" ..
		"listring[nodemeta:" .. spos .. ";main]" ..
		"listring[current_player;main]" ..
		"background[-0.5,-0.65;9,10.35;" .. image .. "]" ..
		"listcolors[#606060AA;#888;#141318;#30434C;#FFF]"
	return formspec
end


minetest.register_node("default:cobble", {
	description       = S("Cobblestone"),
	tiles             = { "default_cobble.png" },
	is_ground_content = true,
	groups            = { cracky = 3, stone = 2 },
	sounds            = default.node_sound_stone_defaults(),
})

minetest.register_node("default:desert_cobble", {
	description       = S("Desert Cobble"),
	tiles             = { "default_desert_cobble.png" },
	is_ground_content = true,
	groups            = { cracky = 3, stone = 2 },
	sounds            = default.node_sound_stone_defaults(),
})

minetest.register_node("default:mossycobble", {
	description       = S("Mossy Cobblestone"),
	tiles             = { "default_mossycobble.png" },
	is_ground_content = true,
	groups            = { cracky = 3 },
	sounds            = default.node_sound_stone_defaults(),
})

minetest.register_node("default:coalblock", {
	description       = S("Coal Block"),
	tiles             = { "default_coal_block.png" },
	is_ground_content = true,
	groups            = { cracky = 3, flammable = 10 },
	sounds            = default.node_sound_stone_defaults(),
	on_punch          = function(pos, node, puncher)
		if puncher:get_wielded_item():get_name() == "default:torch" then
			local pos_above = { x = pos.x, y = pos.y + 1, z = pos.z }
			if minetest.get_node(pos_above).name == "air" then
				minetest.set_node(pos_above, { name = "fire:basic_flame" })
			end
		end
	end,
})

minetest.register_node("default:steelblock", {
	description       = S("Steel Block"),
	tiles             = { "default_steel_block.png" },
	is_ground_content = true,
	groups            = { cracky = 1, level = 2 },
	sounds            = default.node_sound_metal_defaults(),
})

minetest.register_node("default:copperblock", {
	description       = S("Copper Block"),
	tiles             = { "default_copper_block.png" },
	is_ground_content = true,
	groups            = { cracky = 1, level = 2 },
	sounds            = default.node_sound_metal_defaults(),
})

minetest.register_node("default:bronzeblock", {
	description       = S("Bronze Block"),
	tiles             = { "default_bronze_block.png" },
	is_ground_content = true,
	groups            = { cracky = 1, level = 2 },
	sounds            = default.node_sound_metal_defaults(),
})

minetest.register_node("default:mese", {
	description       = S("Mese Block"),
	tiles             = { "default_mese_block.png" },
	is_ground_content = true,
	groups            = { cracky = 1, level = 2 },
	sounds            = default.node_sound_glass_defaults(),
})
minetest.register_alias("default:mese_block", "default:mese")

minetest.register_node("default:goldblock", {
	description       = S("Gold Block"),
	tiles             = { "default_gold_block.png" },
	is_ground_content = true,
	groups            = { cracky = 1 },
	sounds            = default.node_sound_metal_defaults(),
})

minetest.register_node("default:diamondblock", {
	description       = S("Diamond Block"),
	tiles             = { "default_diamond_block.png" },
	is_ground_content = true,
	groups            = { cracky = 1, level = 3 },
	sounds            = default.node_sound_glass_defaults(),
})

minetest.register_node("default:obsidian_glass", {
	description         = S("Obsidian Glass"),
	drawtype            = "glasslike_framed_optional",
	tiles               = { "default_obsidian_glass.png", "default_obsidian_glass_detail.png" },
	paramtype           = "light",
	is_ground_content   = false,
	sunlight_propagates = true,
	sounds              = default.node_sound_glass_defaults(),
	groups              = { cracky = 3, oddly_breakable_by_hand = 3 },
})

minetest.register_node("default:obsidian", {
	description       = S("Obsidian"),
	tiles             = { "default_obsidian.png" },
	is_ground_content = true,
	sounds            = default.node_sound_stone_defaults(),
	groups            = { cracky = 1, level = 2 },
})

minetest.register_node("default:obsidianbrick", {
	description = S("Obsidian Brick"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"default_obsidian_brick.png"},
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky = 1, level = 2},
})

minetest.register_node("default:obsidian_block", {
	description = S("Obsidian Block"),
	tiles = {"default_obsidian_block.png"},
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	groups = {cracky = 1, level = 2},
})

minetest.register_node("default:nyancat", {
	description           = S("Nyan Cat"),
	tiles                 = { "default_nc_side.png", "default_nc_side.png", "default_nc_side.png",
							  "default_nc_side.png", "default_nc_back.png", "default_nc_front.png" },
	paramtype2            = "facedir",
	groups                = { cracky = 2 },
	is_ground_content     = false,
	legacy_facedir_simple = true,
	sounds                = default.node_sound_defaults(),
})

minetest.register_node("default:nyancat_rainbow", {
	description       = S("Nyan Cat Rainbow"),
	tiles             = { "default_nc_rb.png^[transformR90", "default_nc_rb.png^[transformR90",
						  "default_nc_rb.png", "default_nc_rb.png" },
	paramtype2        = "facedir",
	groups            = { cracky = 2 },
	is_ground_content = false,
	sounds            = default.node_sound_defaults(),
})

minetest.register_node("default:sapling", {
	description       = S("Sapling"),
	drawtype          = "plantlike",
	visual_scale      = 1.0,
	tiles             = { "default_sapling.png" },
	inventory_image   = "default_sapling.png",
	wield_image       = "default_sapling.png",
	paramtype         = "light",
	walkable          = false,
	is_ground_content = true,
	selection_box     = {
		type  = "fixed",
		fixed = { -0.3, -0.5, -0.3, 0.3, 0.35, 0.3 }
	},
	groups            = { snappy = 2, dig_immediate = 3, flammable = 2, attached_node = 1, sapling = 1 },
	sounds            = default.node_sound_leaves_defaults(),
})

minetest.register_node("default:apple", {
	description         = S("Apple"),
	drawtype            = "plantlike",
	visual_scale        = 1.0,
	tiles               = { "default_apple.png" },
	inventory_image     = "default_apple.png",
	paramtype           = "light",
	sunlight_propagates = true,
	walkable            = false,
	is_ground_content   = true,
	selection_box       = {
		type  = "fixed",
		fixed = { -0.2, -0.5, -0.2, 0.2, 0, 0.2 }
	},
	groups              = { fleshy = 3, dig_immediate = 3, flammable = 2, leafdecay = 3, leafdecay_drop = 1 },
	on_use              = minetest.item_eat(1),
	sounds              = default.node_sound_leaves_defaults(),
	after_place_node    = function(pos, placer, itemstack)
		if placer:is_player() then
			minetest.set_node(pos, { name = "default:apple", param2 = 1 })
		end
	end,
})

minetest.register_node("default:dry_shrub", {
	description       = S("Dry Shrub"),
	drawtype          = "plantlike",
	visual_scale      = 1.0,
	tiles             = { "default_dry_shrub.png" },
	inventory_image   = "default_dry_shrub.png",
	wield_image       = "default_dry_shrub.png",
	paramtype         = "light",
	waving            = 1,
	walkable          = false,
	is_ground_content = true,
	buildable_to      = true,
	groups            = { snappy = 3, flammable = 3, attached_node = 1, grass = 1 },
	sounds            = default.node_sound_leaves_defaults(),
	selection_box     = {
		type  = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -5 / 16, 0.5 },
	},
})

minetest.register_node("default:grass_1", {
	description       = S("Grass"),
	drawtype          = "plantlike",
	tiles             = { "default_grass_1.png" },
	-- use a bigger inventory image
	inventory_image   = "default_grass_3.png",
	wield_image       = "default_grass_3.png",
	paramtype         = "light",
	walkable          = false,
	is_ground_content = true,
	buildable_to      = true,
	groups            = { snappy = 3, flammable = 3, flora = 1, attached_node = 1, grass = 1, color_green = 1 },
	sounds            = default.node_sound_leaves_defaults(),
	selection_box     = {
		type  = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -5 / 16, 0.5 },
	},
	on_place          = function(itemstack, placer, pointed_thing)
		-- place a random grass node
		local stack = ItemStack("default:grass_" .. math.random(1, 5))
		local ret   = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("default:grass_1 " .. itemstack:get_count() - (1 - ret:get_count()))
	end,
})
minetest.register_node("default:grass_2", {
	description       = S("Grass"),
	drawtype          = "plantlike",
	tiles             = { "default_grass_2.png" },
	inventory_image   = "default_grass_2.png",
	wield_image       = "default_grass_2.png",
	paramtype         = "light",
	walkable          = false,
	buildable_to      = true,
	is_ground_content = true,
	drop              = "default:grass_1",
	groups            = {
		snappy                    = 3,
		flammable                 = 3,
		flora                     = 1,
		attached_node             = 1,
		not_in_creative_inventory = 1,
		grass                     = 1
	},
	sounds            = default.node_sound_leaves_defaults(),
	selection_box     = {
		type  = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -5 / 16, 0.5 },
	},
})
minetest.register_node("default:grass_3", {
	description       = S("Grass"),
	drawtype          = "plantlike",
	tiles             = { "default_grass_3.png" },
	inventory_image   = "default_grass_3.png",
	wield_image       = "default_grass_3.png",
	paramtype         = "light",
	walkable          = false,
	buildable_to      = true,
	is_ground_content = true,
	drop              = "default:grass_1",
	groups            = {
		snappy                    = 3,
		flammable                 = 3,
		flora                     = 1,
		attached_node             = 1,
		not_in_creative_inventory = 1,
		grass                     = 1
	},
	sounds            = default.node_sound_leaves_defaults(),
	selection_box     = {
		type  = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -5 / 16, 0.5 },
	},
})
minetest.register_node("default:grass_4", {
	description       = S("Grass"),
	drawtype          = "plantlike",
	tiles             = { "default_grass_4.png" },
	inventory_image   = "default_grass_4.png",
	wield_image       = "default_grass_4.png",
	paramtype         = "light",
	walkable          = false,
	buildable_to      = true,
	is_ground_content = true,
	drop              = "default:grass_1",
	groups            = {
		snappy                    = 3,
		flammable                 = 3,
		flora                     = 1,
		attached_node             = 1,
		not_in_creative_inventory = 1,
		grass                     = 1 },
	sounds            = default.node_sound_leaves_defaults(),
	selection_box     = {
		type  = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -5 / 16, 0.5 },
	},
})
minetest.register_node("default:grass_5", {
	description       = S("Grass"),
	drawtype          = "plantlike",
	tiles             = { "default_grass_5.png" },
	inventory_image   = "default_grass_5.png",
	wield_image       = "default_grass_5.png",
	paramtype         = "light",
	walkable          = false,
	buildable_to      = true,
	is_ground_content = true,
	drop              = "default:grass_1",
	groups            = {
		snappy                    = 3,
		flammable                 = 3,
		flora                     = 1,
		attached_node             = 1,
		not_in_creative_inventory = 1,
		grass                     = 1
	},
	sounds            = default.node_sound_leaves_defaults(),
	selection_box     = {
		type  = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -5 / 16, 0.5 },
	},
})

minetest.register_node("default:dry_grass_1", {
	description = S("Savanna Grass"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"default_dry_grass_1.png"},
	inventory_image = "default_dry_grass_3.png",
	wield_image = "default_dry_grass_3.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, flora = 1,
			  attached_node = 1, grass = 1, dry_grass = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -3 / 16, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random dry grass node
		local stack = ItemStack("default:dry_grass_" .. math.random(1, 5))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("default:dry_grass_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 5 do
	minetest.register_node("default:dry_grass_" .. i, {
		description = S("Savanna Grass"),
		drawtype = "plantlike",
		waving = 1,
		tiles = {"default_dry_grass_" .. i .. ".png"},
		inventory_image = "default_dry_grass_" .. i .. ".png",
		wield_image = "default_dry_grass_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1,
				  not_in_creative_inventory = 1, grass = 1, dry_grass = 1},
		drop = "default:dry_grass_1",
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -1 / 16, 6 / 16},
		},
	})
end


minetest.register_node("default:fern_1", {
	description = S("Fern"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"default_fern_1.png"},
	inventory_image = "default_fern_1.png",
	wield_image = "default_fern_1.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, flora = 1, grass = 1,
			  fern = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random fern node
		local stack = ItemStack("default:fern_" .. math.random(1, 3))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("default:fern_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 3 do
	minetest.register_node("default:fern_" .. i, {
		description = S("Fern"),
		drawtype = "plantlike",
		waving = 1,
		visual_scale = 2,
		tiles = {"default_fern_" .. i .. ".png"},
		inventory_image = "default_fern_" .. i .. ".png",
		wield_image = "default_fern_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1,
				  grass = 1, fern = 1, not_in_creative_inventory = 1},
		drop = "default:fern_1",
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
		},
	})
end


minetest.register_node("default:marram_grass_1", {
	description = S("Marram Grass"),
	drawtype = "plantlike",
	waving = 1,
	tiles = {"default_marram_grass_1.png"},
	inventory_image = "default_marram_grass_1.png",
	wield_image = "default_marram_grass_1.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flammable = 3, flora = 1, grass = 1, marram_grass = 1,
			  attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
	},

	on_place = function(itemstack, placer, pointed_thing)
		-- place a random marram grass node
		local stack = ItemStack("default:marram_grass_" .. math.random(1, 3))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("default:marram_grass_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 3 do
	minetest.register_node("default:marram_grass_" .. i, {
		description = S("Marram Grass"),
		drawtype = "plantlike",
		waving = 1,
		tiles = {"default_marram_grass_" .. i .. ".png"},
		inventory_image = "default_marram_grass_" .. i .. ".png",
		wield_image = "default_marram_grass_" .. i .. ".png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = true,
		groups = {snappy = 3, flammable = 3, flora = 1, attached_node = 1,
				  grass = 1, marram_grass = 1, not_in_creative_inventory = 1},
		drop = "default:marram_grass_1",
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16},
		},
	})
end

minetest.register_node("default:ice", {
	description       = S("Ice"),
	tiles             = { "default_ice.png" },
	is_ground_content = true,
	paramtype         = "light",
	freezemelt        = "default:water_source",
	groups            = { cracky = 3, melts = 1 },
	sounds            = default.node_sound_glass_defaults(),
})

minetest.register_node("default:snow", {
	description       = S("Snow"),
	tiles             = { "default_snow.png" },
	inventory_image   = "default_snowball.png",
	wield_image       = "default_snowball.png",
	is_ground_content = true,
	paramtype         = "light",
	buildable_to      = true,
	leveled           = 7,
	drawtype          = "nodebox",
	freezemelt        = "default:water_flowing",
	node_box          = {
		type  = "leveled",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, -0.5 + 2 / 16, 0.5 },
		},
	},
	groups            = { crumbly = 3, falling_node = 1, melts = 1, float = 1 },
	sounds            = default.node_sound_dirt_defaults({
		footstep = { name = "default_snow_footstep", gain = 0.25 },
		dug      = { name = "default_snow_footstep", gain = 0.75 },
	}),
	on_construct      = function(pos)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name == "default:dirt_with_grass" then
			minetest.set_node(pos, { name = "default:dirt_with_snow" })
		end
	end,
})
minetest.register_alias("snow", "default:snow")

minetest.register_node("default:snowblock", {
	description       = S("Snow Block"),
	tiles             = { "default_snow.png" },
	is_ground_content = true,
	freezemelt        = "default:water_source",
	groups            = { crumbly = 3, melts = 1 },
	sounds            = default.node_sound_dirt_defaults({
		footstep = { name = "default_snow_footstep", gain = 0.25 },
		dug      = { name = "default_snow_footstep", gain = 0.75 },
	}),
})


minetest.register_node("default:meselamp", {
	description = S("Mese Lamp"),
	drawtype = "glasslike",
	tiles = {"default_meselamp.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3, oddly_breakable_by_hand = 3},
	sounds = default.node_sound_glass_defaults(),
	light_source = default.LIGHT_MAX,
})
