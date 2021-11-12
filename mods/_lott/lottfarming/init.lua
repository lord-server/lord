local S = minetest.get_translator("lottfarming")

<<<<<<< HEAD
lottfarming = {}

<<<<<<< HEAD
lottfarming.MAX_LIGHT = 15

=======
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
lottfarming.get_translator = S

-- how often node timers for plants will tick, +/- some random value
local function tick(pos)
	minetest.get_node_timer(pos):start(math.random(166, 286))
end
-- how often a growth failure tick is retried (e.g. too dark)
local function tick_again(pos)
	minetest.get_node_timer(pos):start(math.random(40, 80))
end

<<<<<<< HEAD
local function check_fertility(t, nodename)
	for _, k in pairs(t) do
		if minetest.get_item_group(nodename, k) >= 2 then
			return true
		end
	end
	return false
end

=======
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
farming.place_seed = function(itemstack, placer, pointed_thing, plantname)
=======
function place_seed(itemstack, placer, pointed_thing, plantname, param2)
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
	local pt = pointed_thing
	-- check if pointing at a node
	if not pt then
		return itemstack
	end
	if pt.type ~= "node" then
		return itemstack
	end

	local under = minetest.get_node(pt.under)
	local above = minetest.get_node(pt.above)
<<<<<<< HEAD

	local player_name = placer and placer:get_player_name() or ""

	if minetest.is_protected(pt.under, player_name) then
		minetest.record_protection_violation(pt.under, player_name)
		return
	end
	if minetest.is_protected(pt.above, player_name) then
		minetest.record_protection_violation(pt.above, player_name)
		return
	end

	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name] then
		return itemstack
	end
	if not minetest.registered_nodes[above.name] then
		return itemstack
	end

	-- check if pointing at the top of the node
	if pt.above.y ~= pt.under.y+1 then
		return itemstack
	end

	-- check if you can replace the node above the pointed node
	if not minetest.registered_nodes[above.name].buildable_to then
		return itemstack
	end

	local item = minetest.registered_items[itemstack:get_name()]

	if not (check_fertility(item.fertility, under.name) == true) then
		return itemstack
	end
<<<<<<< HEAD

	-- add the node and remove 1 item from the itemstack
	minetest.log("action", player_name .. " places node " .. plantname .. " at " ..
		minetest.pos_to_string(pt.above))
	minetest.add_node(pt.above, {name = plantname, param2 = 1})
	tick(pt.above)
	if not minetest.is_creative_enabled(player_name) then
=======
	minetest.add_node(pt.above, {name=plantname, param2=param2})
	if not minetest.setting_getbool("creative_mode") then
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
		itemstack:take_item()
	end
	return itemstack
end

<<<<<<< HEAD
farming.grow_plant = function(pos, _)
	local node = minetest.get_node(pos)
	local name = node.name
	local def = minetest.registered_nodes[name]

	if not def.next_plant then
		-- disable timer for fully grown plant
=======
function place_spore(itemstack, placer, pointed_thing, plantname, p2)
	local pt = pointed_thing
	if not pt then
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
		return
	end

	if type(def.next_plant) == "function" then
		def.next_plant = def.next_plant()
	end

	-- grow seed
	if (minetest.get_item_group(node.name, "seed") >= 1) and def.fertility then
		local soil_node = minetest.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})
		if not soil_node then
			tick_again(pos)
			return
		end

		-- omitted is a check for light, we assume seeds can germinate in the dark.
		for _, v in pairs(def.fertility) do
			if minetest.get_item_group(soil_node.name, v) ~= 0 then
				local placenode = {name = def.next_plant[1].node}
				if def.place_param2 then
					placenode.param2 = def.place_param2
				end
				local placepos = pos
				if def.next_plant[1].pos then
					local lpos = def.next_plant[1].pos
					placepos = {x = pos.x + lpos.x, y = pos.y + lpos.y, z = pos.z + lpos.z}
				end
				minetest.swap_node(placepos, placenode)
				if minetest.registered_nodes[def.next_plant[1].node].next_plant then
					tick(pos)
					return
				end
			end
		end
		return
	else
		tick_again(pos)
	end

	-- check light
	local light = minetest.get_node_light(pos)
	if (not light) or (light < def.minlight) or (light > def.maxlight) then
		tick_again(pos)
		return
	end

	-- check and grow
	if def.planttype == 1 then
		-- ground check
		local below = minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z})

		if not check_fertility(def.fertility, below.name) then
			tick_again(pos)
			return
		end

		-- grow
		for _, k in pairs(def.next_plant) do
			if k ~= nil then
				local placenode = {name = k.node}
				if def.place_param2 then
					placenode.param2 = def.place_param2
				end
				local placepos = pos
				if k.pos then
					placepos = {x = pos.x + k.pos.x, y = pos.y + k.pos.y, z = pos.z + k.pos.z}
				end
				minetest.set_node(placepos, placenode)
			end
		end

		-- new timer needed?
		if def.next_plant[1] then
			if minetest.registered_nodes[def.next_plant[1].node].next_plant then
				tick(pos)
			end
		end

		return
	else
		-- ground check
		local ground_check = true
		if def.on_ground_check then
			ground_check = def.on_ground_check()
		end
		if not ground_check then
			tick_again(pos)
		end

		-- grow
		for _, k in pairs(def.next_plant) do
			if k ~= nil then
				local placenode = {name = k.node}
				if def.place_param2 then
					placenode.param2 = def.place_param2
				end
				local placepos = pos
				if k.pos then
					local f_pos
					if type(k.pos) == "function" then
						f_pos = k.pos()
					else
						f_pos = k.pos
					end
					placepos = {x = pos.x + f_pos.x, y = pos.y + f_pos.y, z = pos.z + f_pos.z}
				end
				minetest.swap_node(placepos, placenode)

				-- new timer needed?
				if minetest.registered_nodes[minetest.get_node(pos).name].next_plant then
					tick(placepos)
				end
			end
		end
		return
	end
end

farming.register_plant = function(name, def)
	local mname = name:split(":")[1]
	local pname = name:split(":")[2]

	-- Check def table
	if (not def.planttype) or (type(def.planttype) ~= "number") or (def.planttype < 1)
	or (def.planttype - math.floor(def.planttype) ~= 0) then
		def.planttype = 1
	end
<<<<<<< HEAD
	if not def.description then
		def.description = S("Seed")
	end
	if not def.harvest_description then
		def.harvest_description = pname:gsub("^%l", string.upper)
	end
	if not def.seed_inv_img then
		def.seed_inv_img = "unknown_item.png"
	end
	if not def.minlight then
		def.minlight = 1
	end
	if not def.maxlight then
		def.maxlight = 14
	end
	if not def.fertility then
		def.fertility = {}
=======
	minetest.add_node(pt.above, {name=plantname, param2 = p2})
	if not minetest.setting_getbool("creative_mode") then
		itemstack:take_item()
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
	end

	farming.registered_plants[pname] = def

	-- Register seed
	local lbm_nodes = {mname .. ":seed_" .. pname}
	local seed_g = {seed = 1, snappy = 3, attached_node = 1, flammable = 2}
	minetest.register_node(def.seed_name or (":" .. mname .. ":seed_" .. pname), {
		description = def.description,
		tiles = def.planted_tiles or {"lottfarming_seed_planted.png"},
		inventory_image = def.seed_inv_img,
		wield_image = def.seed_inv_img,
		drawtype = "signlike",
		groups = seed_g,
		planttype = def.planttype,
		paramtype = "light",
		paramtype2 = "wallmounted",
		place_param2 = def.place_param2 or nil, -- this isn't actually used for placement
		walkable = false,
		sunlight_propagates = true,
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -0.49, 0.5},
		},
		fertility = def.fertility,
		sounds = default.node_sound_dirt_defaults({
			dig = {name = "", gain = 0},
			dug = {name = "default_grass_footstep", gain = 0.2},
			place = {name = "default_place_node", gain = 0.25},
		}),

		on_place = function(itemstack, placer, pointed_thing)
			local under = pointed_thing.under
			local node = minetest.get_node(under)
			local udef = minetest.registered_nodes[node.name]
			if udef and udef.on_rightclick and
					not (placer and placer:is_player() and
					placer:get_player_control().sneak) then
				return udef.on_rightclick(under, node, placer, itemstack,
					pointed_thing) or itemstack
			end

			return farming.place_seed(itemstack, placer, pointed_thing, def.seed_name or (mname .. ":seed_" .. pname))
		end,
		next_plant = def.next_plant or {{node = mname .. ":" .. pname .. "_1"}},
		on_timer = farming.grow_plant,
		minlight = def.minlight or 11,
		maxlight = def.maxlight or 15,
	})

=======

	local player_name = placer and placer:get_player_name() or ""

	if minetest.is_protected(pt.under, player_name) then
		minetest.record_protection_violation(pt.under, player_name)
		return
	end
	if minetest.is_protected(pt.above, player_name) then
		minetest.record_protection_violation(pt.above, player_name)
		return
	end

	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name] then
		return itemstack
	end
	if not minetest.registered_nodes[above.name] then
		return itemstack
	end

	-- check if pointing at the top of the node
	if pt.above.y ~= pt.under.y+1 then
		return itemstack
	end

	-- check if you can replace the node above the pointed node
	if not minetest.registered_nodes[above.name].buildable_to then
		return itemstack
	end

	local item = minetest.registered_items[itemstack:get_name()]

	-- check if pointing at node with given group
	local function check_fertility(t)
		for _, k in pairs(t) do
			if minetest.get_item_group(under.name, k) >= 1 then
				return true
			end
		end
	end

	if not (check_fertility(item.fertility) == true) then
		return itemstack
	end

	-- add the node and remove 1 item from the itemstack
	minetest.log("action", player_name .. " places node " .. plantname .. " at " ..
		minetest.pos_to_string(pt.above))
	minetest.add_node(pt.above, {name = plantname, param2 = 1})
	tick(pt.above)
	if not minetest.is_creative_enabled(player_name) then
		itemstack:take_item()
	end
	return itemstack
end

<<<<<<< HEAD
farming.grow_plant = function(pos, _)
	local node = minetest.get_node(pos)
	local name = node.name
	local def = minetest.registered_nodes[name]

	if not def.next_plant then
		-- disable timer for fully grown plant
		return
	end

	if def.stop_trigger and (def.stop_trigger() == true) then
		tick_again(pos)
		return
	end

	if type(def.next_plant) == "function" then
		def.next_plant = def.next_plant()
	end

	-- grow seed
	if minetest.get_item_group(node.name, "seed") and def.fertility then
		local soil_node = minetest.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})
		if not soil_node then
			tick_again(pos)
			return
		end
		-- omitted is a check for light, we assume seeds can germinate in the dark.
		for _, v in pairs(def.fertility) do
			if minetest.get_item_group(soil_node.name, v) ~= 0 then
				local placenode = {name = def.next_plant[1].node}
				if def.place_param2 then
					placenode.param2 = def.place_param2
				end
				local placepos = pos
				if def.next_plant[1].pos then
					local lpos = def.next_plant[1].pos
					placepos = {x = pos.x + lpos.x, y = pos.y + lpos.y, z = pos.z + lpos.z}
				end
				minetest.swap_node(placepos, placenode)
				if minetest.registered_nodes[def.next_plant[1].node].next_plant then
					tick(pos)
					return
				end
			end
		end

		return
	end

	-- check light
	local light = minetest.get_node_light(pos)
	if not light or light < def.minlight or light > def.maxlight then
		tick_again(pos)
		return
	end

	-- ground check and grow
	if def.planttype == 1 then
		-- ground check
		local below = minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z})
		if not ((minetest.get_item_group(below.name, "soil") > 2)
		or (minetest.get_item_group(below.name, def.fertility) > 0)) then
			tick_again(pos)
			return
		end

		-- grow
		for _, k in pairs(def.next_plant) do
			if k ~= nil then
				local placenode = {name = k.node}
				if def.place_param2 then
					placenode.param2 = def.place_param2
				end
				local placepos = pos
				if k.pos then
					placepos = {x = pos.x + k.pos.x, y = pos.y + k.pos.y, z = pos.z + k.pos.z}
				end
				minetest.set_node(placepos, placenode)
			end
		end

		-- new timer needed?
		if def.next_plant[1] then
			if minetest.registered_nodes[def.next_plant[1].node].next_plant then
				tick(pos)
			end
		end
		return
	else
		-- ground check
		if not def.on_ground_check then
			return
		end
		local ground_check = def.on_ground_check() or false
		if not ground_check then
			tick_again(pos)
		end

		-- grow
		for _, k in pairs(def.next_plant) do
			if k ~= nil then
				local placenode = {name = k.node}
				if def.place_param2 then
					placenode.param2 = def.place_param2
				end
				local placepos = pos
				if k.pos then
					placepos = {x = pos.x + k.pos.x, y = pos.y + k.pos.y, z = pos.z + k.pos.z}
				end
				minetest.swap_node(placepos, placenode)

				-- new timer needed?
				if minetest.registered_nodes[placenode].next_plant then
					tick(placepos)
				end
			end
		end
		return
	end
end

farming.register_plant = function(name, def)
	local mname = name:split(":")[1]
	local pname = name:split(":")[2]

	-- Check def table
	if (not def.planttype) or (type(def.planttype) ~= "number") or (def.planttype < 1)
	or (def.planttype - math.floor(def.planttype) ~= 0) then
		def.planttype = 1
	end
	if not def.description then
		def.description = S("Seed")
	end
	if not def.harvest_description then
		def.harvest_description = pname:gsub("^%l", string.upper)
	end
	if not def.seed_inv_img then
		def.seed_inv_img = "unknown_item.png"
	end
	if not def.minlight then
		def.minlight = 1
	end
	if not def.maxlight then
		def.maxlight = 14
	end
	if not def.fertility then
		def.fertility = {}
	end

	farming.registered_plants[pname] = def

	-- Register seed
	local lbm_nodes = {mname .. ":seed_" .. pname}
	local g = {seed = 1, snappy = 3, attached_node = 1, flammable = 2}
	for _, v in pairs(def.fertility) do
		g[v] = 1
	end
	minetest.register_node(def.seed_name or (":" .. mname .. ":seed_" .. pname), {
		description = def.description,
		tiles = def.planted_tiles or {"lottfarming_seed_planted.png"},
		inventory_image = def.seed_inv_img,
		wield_image = def.seed_inv_img,
		drawtype = "signlike",
		groups = g,
		planttype = def.planttype,
		paramtype = "light",
		paramtype2 = "wallmounted",
		place_param2 = def.place_param2 or nil, -- this isn't actually used for placement
		walkable = false,
		sunlight_propagates = true,
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -0.49, 0.5},
		},
		fertility = def.fertility,
		sounds = default.node_sound_dirt_defaults({
			dig = {name = "", gain = 0},
			dug = {name = "default_grass_footstep", gain = 0.2},
			place = {name = "default_place_node", gain = 0.25},
		}),

		on_place = function(itemstack, placer, pointed_thing)
			local under = pointed_thing.under
			local node = minetest.get_node(under)
			local udef = minetest.registered_nodes[node.name]
			if udef and udef.on_rightclick and
					not (placer and placer:is_player() and
					placer:get_player_control().sneak) then
				return udef.on_rightclick(under, node, placer, itemstack,
					pointed_thing) or itemstack
			end

			return farming.place_seed(itemstack, placer, pointed_thing, mname .. ":seed_" .. pname)
		end,
		next_plant = def.next_plant or {{node = mname .. ":" .. pname .. "_1"}},
		on_timer = farming.grow_plant,
		minlight = def.minlight,
		maxlight = def.maxlight,
	})

>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
	-- Register harvest
	if def.harvest_name then
		if not minetest.registered_items[def.harvest_name] then
			minetest.register_craftitem(def.harvest_name or (":" .. mname .. ":" .. pname), {
				description = def.harvest_description,
				inventory_image = def.harvest_inv_img or (mname .. "_" .. pname .. ".png"),
				groups = def.groups or {flammable = 2},
				on_use = def.on_use,
			})
		end
	else
		minetest.register_craftitem(":" .. mname .. ":" .. pname, {
			description = def.harvest_description,
			inventory_image = def.harvest_inv_img or (mname .. "_" .. pname .. ".png"),
			groups = def.groups or {flammable = 2},
			on_use = def.on_use,
		})
	end

	-- Register growing steps
	if def.planttype == 1 then
		if not def.steps then
			return nil
		end

		for i = 1, def.steps do
			local base_rarity = 1
			if def.steps ~= 1 then
				base_rarity =  8 - (i - 1) * 7 / (def.steps - 1)
			end
			local drop = {
				items = {
					{items = {def.harvest_name or (mname .. ":" .. pname)}, rarity = base_rarity},
					{items = {def.harvest_name or (mname .. ":" .. pname)}, rarity = base_rarity * 2},
					{items = {def.seed_name or (mname .. ":seed_" .. pname)}, rarity = base_rarity},
					{items = {def.seed_name or (mname .. ":seed_" .. pname)}, rarity = base_rarity * 2},
				}
			}
			local nodegroups = {snappy = 3, flammable = 2, plant = 1, not_in_creative_inventory = 1, attached_node = 1}
			nodegroups[pname] = i

			local next_plant = nil

			if i < def.steps then
<<<<<<< HEAD
				next_plant = {{node = mname .. ":" .. pname .. "_" .. (i + 1)}}
=======
				next_plant = {{name = mname .. ":" .. pname .. "_" .. (i + 1)}}
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
				lbm_nodes[#lbm_nodes + 1] = mname .. ":" .. pname .. "_" .. i
			end

			minetest.register_node(":" .. mname .. ":" .. pname .. "_" .. i, {
				drawtype = "plantlike",
				waving = 1,
				tiles = {mname .. "_" .. pname .. "_" .. i .. ".png"},
				planttype = def.planttype,
				paramtype = "light",
				paramtype2 = def.paramtype2 or nil,
				place_param2 = def.place_param2 or nil,
				walkable = false,
				buildable_to = true,
				drop = drop,
				selection_box = {
					type = "fixed",
					fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
				},
				groups = nodegroups,
<<<<<<< HEAD
				fertility = def.fertility,
				sounds = default.node_sound_leaves_defaults(),
				next_plant = next_plant,
				on_timer = farming.grow_plant,
				minlight = def.minlight or 13,
				maxlight = def.maxlight or lottfarming.MAX_LIGHT,
=======
				sounds = default.node_sound_leaves_defaults(),
				next_plant = next_plant,
				on_timer = farming.grow_plant,
				minlight = def.minlight,
				maxlight = def.maxlight,
>>>>>>> 01f005f (Closes #344. Closes #321. Redo lottfarming.)
			})
		end

		-- replacement LBM for pre-nodetimer plants
		minetest.register_lbm({
			name = ":" .. mname .. ":start_nodetimer_" .. pname,
			nodenames = lbm_nodes,
			action = function(pos, _)
				tick_again(pos)
			end,
		})
	end

	-- Return
	local r = {
		seed = mname .. ":seed_" .. pname,
		harvest = mname .. ":" .. pname
	}
	return r
=======
function farming:add_plant(full_grown, names, interval, chance, p2)
	minetest.register_abm({
		nodenames = names,
		interval = interval,
		chance = chance,
		action = function(pos, node)
			pos.y = pos.y-1
			if minetest.get_node(pos).name ~= "farming:soil_wet" then
				return
			end
			pos.y = pos.y+1
			local light_level = minetest.get_node_light(pos)
			if not light_level then
				return
			end
			local c = math.ceil(2 * (light_level - 13) ^ 2 + 1)
			if light_level > 7 and (math.random(1, c) == 1 or light_level >= 13) then
				local step
				for i,name in ipairs(names) do
					if name == node.name then
						step = i
						break
					end
				end
				if not step then
					return
				end
				local new_node = {name=names[step+1], param2=p2}
				if new_node.name == nil then
					new_node.name = full_grown
				end
				minetest.set_node(pos, new_node)
			end
		end
})
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
end

minetest.register_lbm({
	name = "lottfarming:start_nodetimer_corn",
	nodenames = {"lottfarming:corn_1", "lottfarming:corn_2", "lottfarming:corn_3", "lottfarming:corn_4",
	"lottfarming:corn_21", "lottfarming:corn_22", "lottfarming:corn_23",
	"lottfarming:corn_31"},
	action = function(pos, node)
		tick_again(pos)
	end,
})

<<<<<<< HEAD
-- ========= ATHELAS =========
dofile(minetest.get_modpath("lottfarming").."/athelas.lua")

-- ========= BARLEY =========
dofile(minetest.get_modpath("lottfarming").."/barley.lua")

=======
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
-- ========= BERRIES =========
dofile(minetest.get_modpath("lottfarming").."/berries.lua")

-- ========= CABBAGE =========
dofile(minetest.get_modpath("lottfarming").."/cabbage.lua")

-- ========= CARROT =========
dofile(minetest.get_modpath("lottfarming").."/carrot.lua")

-- ========= CORN =========
dofile(minetest.get_modpath("lottfarming").."/corn.lua")

-- ========= CRAFTS =========
dofile(minetest.get_modpath("lottfarming").."/crafting.lua")

-- ========= MELON =========
dofile(minetest.get_modpath("lottfarming").."/melon.lua")

-- ========= ORC FOOD =========
dofile(minetest.get_modpath("lottfarming").."/orc_food.lua")

-- ========= OTHER =========
dofile(minetest.get_modpath("lottfarming").."/other.lua")

-- ========= PIPEWEED =========
dofile(minetest.get_modpath("lottfarming").."/pipeweed.lua")

-- ========= POTATO =========
dofile(minetest.get_modpath("lottfarming").."/potato.lua")

-- ========= TOMATO =========
dofile(minetest.get_modpath("lottfarming").."/tomato.lua")

-- ========= TURNIP =========
dofile(minetest.get_modpath("lottfarming").."/turnip.lua")


-- MUSHROOMS

-- ========= BROWN MUSHROOM =========
dofile(minetest.get_modpath("lottfarming").."/brown.lua")

-- ========= RED MUSHROOM =========
dofile(minetest.get_modpath("lottfarming").."/red.lua")

-- ========= BLUE MUSHROOM =========
dofile(minetest.get_modpath("lottfarming").."/blue.lua")

-- ========= GREEN MUSHROOM =========
dofile(minetest.get_modpath("lottfarming").."/green.lua")

-- ========= WHITE MUSHROOM =========
dofile(minetest.get_modpath("lottfarming").."/white.lua")
<<<<<<< HEAD
=======

-- ========= ORC FOOD =========
dofile(minetest.get_modpath("lottfarming").."/orc_food.lua")
>>>>>>> 93c13f4 (Closes #344. Just update lottfarming. Shouldn't be used in stable release)
