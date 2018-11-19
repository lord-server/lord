-- mods/default/functions.lua

local random = math.random


-- проверка на возможность роста деревьев
function default.can_grow(pos)
	local n
    for p = pos.y + 1, pos.y + 20 do
		n = minetest.get_node({x = pos.x, y = p, z = pos.z})
		if (n.name~="air") then
			return false
		end
	end
	local node_under = minetest.get_node_or_nil({x = pos.x, y = pos.y - 1, z = pos.z})
	if not node_under then
		return false
	end
	local name_under = node_under.name
	local is_soil = minetest.get_item_group(name_under, "soil")
	if is_soil == 0 then
		return false
	end
	local light_level = minetest.get_node_light(pos)
	if not light_level or light_level < 13 then
		return false
	end

	return true
end

--
-- Sounds
--

function default.node_sound_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="", gain=1.0}
	table.dug = table.dug or
			{name="default_dug_node", gain=0.25}
	table.place = table.place or
			{name="default_place_node_hard", gain=1.0}
	return table
end

function default.node_sound_stone_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="default_hard_footstep", gain=0.5}
	table.dug = table.dug or
			{name="default_hard_footstep", gain=1.0}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_dirt_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="default_dirt_footstep", gain=1.0}
	table.dug = table.dug or
			{name="default_dirt_footstep", gain=1.5}
	table.place = table.place or
			{name="default_place_node", gain=1.0}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_sand_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="default_sand_footstep", gain=0.5}
	table.dug = table.dug or
			{name="default_sand_footstep", gain=1.0}
	table.place = table.place or
			{name="default_place_node", gain=1.0}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_gravel_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_gravel_footstep", gain = 0.4}
	table.dug = table.dug or
			{name = "default_gravel_footstep", gain = 1.0}
	table.place = table.place or
			{name = "default_place_node", gain = 1.0}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_wood_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="default_wood_footstep", gain=0.5}
	table.dug = table.dug or
			{name="default_wood_footstep", gain=1.0}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_leaves_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="default_grass_footstep", gain=0.35}
	table.dug = table.dug or
			{name="default_grass_footstep", gain=0.85}
	table.dig = table.dig or
			{name="default_dig_crumbly", gain=0.4}
	table.place = table.place or
			{name="default_place_node", gain=1.0}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_glass_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name="default_glass_footstep", gain=0.5}
	table.dug = table.dug or
			{name="default_break_glass", gain=1.0}
	default.node_sound_defaults(table)
	return table
end

function default.node_sound_metal_defaults(table)
	table = table or {}
	table.footstep = table.footstep or
			{name = "default_metal_footstep", gain = 0.4}
	table.dig = table.dig or
			{name = "default_dig_metal", gain = 0.5}
	table.dug = table.dug or
			{name = "default_dug_metal", gain = 0.5}
	table.place = table.place or
			{name = "default_place_node_metal", gain = 0.5}
	default.node_sound_defaults(table)
	return table
end

--
-- Legacy
--

function default.spawn_falling_node(p, nodename)
	spawn_falling_node(p, nodename)
end

-- Horrible crap to support old code
-- Don't use this and never do what this does, it's completely wrong!
-- (More specifically, the client and the C++ code doesn't get the group)
function default.register_falling_node(nodename, texture)
	minetest.log("error", debug.traceback())
	minetest.log('error', "WARNING: default.register_falling_node is deprecated")
	if minetest.registered_nodes[nodename] then
		minetest.registered_nodes[nodename].groups.falling_node = 1
	end
end

--
-- Global callbacks
--

-- Global environment step function
function on_step(dtime)
	-- print("on_step")
end
minetest.register_globalstep(on_step)

function on_placenode(p, node)
	--print("on_placenode")
end
minetest.register_on_placenode(on_placenode)

function on_dignode(p, node)
	--print("on_dignode")
end
minetest.register_on_dignode(on_dignode)

function on_punchnode(p, node)
end
minetest.register_on_punchnode(on_punchnode)


--
-- Grow trees
--

--minetest.register_abm({
	--nodenames = {"default:sapling"},
	--interval = 10,
	--chance = 50,
	--action = function(pos, node)
		--local nu =  minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
		--local is_soil = minetest.get_item_group(nu, "soil")
		--if is_soil == 0 then
			--return
		--end

		--minetest.log("action", "A sapling grows into a tree at "..minetest.pos_to_string(pos))
		--local vm = minetest.get_voxel_manip()
		--local minp, maxp = vm:read_from_map({x=pos.x-16, y=pos.y, z=pos.z-16}, {x=pos.x+16, y=pos.y+16, z=pos.z+16})
		--local a = VoxelArea:new{MinEdge=minp, MaxEdge=maxp}
		--local data = vm:get_data()
		--default.grow_tree(data, a, pos, math.random(1, 4) == 1, math.random(1,100000))
		--vm:set_data(data)
		--vm:write_to_map(data)
		--vm:update_map()
	--end
--})

--minetest.register_abm({
	--nodenames = {"default:junglesapling"},
	--interval = 10,
	--chance = 50,
	--action = function(pos, node)
		--local nu =  minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
		--local is_soil = minetest.get_item_group(nu, "soil")
		--if is_soil == 0 then
			--return
		--end

		--minetest.log("action", "A jungle sapling grows into a tree at "..minetest.pos_to_string(pos))
		--local vm = minetest.get_voxel_manip()
		--local minp, maxp = vm:read_from_map({x=pos.x-16, y=pos.y-1, z=pos.z-16}, {x=pos.x+16, y=pos.y+16, z=pos.z+16})
		--local a = VoxelArea:new{MinEdge=minp, MaxEdge=maxp}
		--local data = vm:get_data()
		--default.grow_jungletree(data, a, pos, math.random(1,100000))
		--vm:set_data(data)
		--vm:write_to_map(data)
		--vm:update_map()
	--end
--})

--
-- Lavacooling
--

default.cool_lava_source = function(pos)
	minetest.set_node(pos, {name="default:obsidian"})
	minetest.sound_play("default_cool_lava", {pos = pos,  gain = 0.25})
end

default.cool_lava_flowing = function(pos)
	minetest.set_node(pos, {name="default:stone"})
	minetest.sound_play("default_cool_lava", {pos = pos,  gain = 0.25})
end

minetest.register_abm({
	nodenames = {"default:lava_flowing"},
	neighbors = {"group:water"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		default.cool_lava_flowing(pos, node, active_object_count, active_object_count_wider)
	end,
})

minetest.register_abm({
	nodenames = {"default:lava_source"},
	neighbors = {"group:water"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		default.cool_lava_source(pos, node, active_object_count, active_object_count_wider)
	end,
})

--
-- Papyrus and cactus growing
--

minetest.register_abm({
	nodenames = {"default:cactus"},
	neighbors = {"group:sand"},
	interval = 50,
	chance = 20,
	action = function(pos, node)
		pos.y = pos.y-1
		local name = minetest.get_node(pos).name
		if minetest.get_item_group(name, "sand") ~= 0 then
			pos.y = pos.y+1
			local height = 0
			while minetest.get_node(pos).name == "default:cactus" and height < 4 do
				height = height+1
				pos.y = pos.y+1
			end
			if height < 4 then
				if minetest.get_node(pos).name == "air" then
					minetest.set_node(pos, {name="default:cactus"})
				end
			end
		end
	end,
})

minetest.register_abm({
	nodenames = {"default:papyrus"},
	neighbors = {"group:soil", "default:sand"},
	interval = 50,
	chance = 20,
	action = function(pos, node)
		pos.y = pos.y-1
		local name = minetest.get_node(pos).name
		if (minetest.registered_nodes[name].groups["soil"])or(name == "default:sand") then
			if minetest.find_node_near(pos, 3, {"group:water"}) == nil then
				return
			end
			pos.y = pos.y+1
			local height = 0
			while minetest.get_node(pos).name == "default:papyrus" and height < 4 do
				height = height+1
				pos.y = pos.y+1
			end
			if height < 4 then
				if minetest.get_node(pos).name == "air" then
					minetest.set_node(pos, {name="default:papyrus"})
				end
			end
		end
	end,
})

--
-- dig upwards
--

function default.dig_up(pos, node, digger)
	if digger == nil then return end
	local np = {x = pos.x, y = pos.y + 1, z = pos.z}
	local nn = minetest.get_node(np)
	if nn.name == node.name then
		minetest.node_dig(np, nn, digger)
	end
end


--
-- Leafdecay
--

-- To enable leaf decay for a node, add it to the "leafdecay" group.
--
-- The rating of the group determines how far from a node in the group "tree"
-- the node can be without decaying.
--
-- If param2 of the node is ~= 0, the node will always be preserved. Thus, if
-- the player places a node of that kind, you will want to set param2=1 or so.
--
-- If the node is in the leafdecay_drop group then the it will always be dropped
-- as an item

default.leafdecay_trunk_cache = {}
default.leafdecay_enable_cache = true
-- Spread the load of finding trunks
default.leafdecay_trunk_find_allow_accumulator = 0

minetest.register_globalstep(function(dtime)
	local finds_per_second = 5000
	default.leafdecay_trunk_find_allow_accumulator =
			math.floor(dtime * finds_per_second)
end)

minetest.register_abm({
	nodenames = {"group:leafdecay"},
	neighbors = {"air", "group:liquid"},
	-- A low interval and a high inverse chance spreads the load
	interval = 2,
	chance = 5,

	action = function(p0, node, _, _)
		--print("leafdecay ABM at "..p0.x..", "..p0.y..", "..p0.z..")")
		local do_preserve = false
		local d = minetest.registered_nodes[node.name].groups.leafdecay
		if not d or d == 0 then
			--print("not groups.leafdecay")
			return
		end
		local n0 = minetest.get_node(p0)
		if n0.param2 ~= 0 then
			--print("param2 ~= 0")
			return
		end
		local p0_hash = nil
		if default.leafdecay_enable_cache then
			p0_hash = minetest.hash_node_position(p0)
			local trunkp = default.leafdecay_trunk_cache[p0_hash]
			if trunkp then
				local n = minetest.get_node(trunkp)
				local reg = minetest.registered_nodes[n.name]
				-- Assume ignore is a trunk, to make the thing work at the border of the active area
				if n.name == "ignore" or (reg and reg.groups.tree and reg.groups.tree ~= 0) then
					--print("cached trunk still exists")
					return
				end
				--print("cached trunk is invalid")
				-- Cache is invalid
				table.remove(default.leafdecay_trunk_cache, p0_hash)
			end
		end
		if default.leafdecay_trunk_find_allow_accumulator <= 0 then
			return
		end
		default.leafdecay_trunk_find_allow_accumulator =
				default.leafdecay_trunk_find_allow_accumulator - 1
		-- Assume ignore is a trunk, to make the thing work at the border of the active area
		local p1 = minetest.find_node_near(p0, d, {"ignore", "group:tree"})
		if p1 then
			do_preserve = true
			if default.leafdecay_enable_cache then
				--print("caching trunk")
				-- Cache the trunk
				default.leafdecay_trunk_cache[p0_hash] = p1
			end
		end
		if not do_preserve then
			-- Drop stuff other than the node itself
			local itemstacks = minetest.get_node_drops(n0.name)
			for _, itemname in ipairs(itemstacks) do
				if minetest.get_item_group(n0.name, "leafdecay_drop") ~= 0 or
						itemname ~= n0.name then
					local p_drop = {
						x = p0.x - 0.5 + math.random(),
						y = p0.y - 0.5 + math.random(),
						z = p0.z - 0.5 + math.random(),
					}
					minetest.add_item(p_drop, itemname)
				end
			end
			-- Remove node
			minetest.remove_node(p0)
			nodeupdate(p0)
		end
	end
})

--This allows trees act *almost* like falling nodes, useful for big trees!

local falling_trees = minetest.settings:get_bool("falling_trees")

if not falling_trees then
	if minetest.is_singleplayer() then
		falling_trees = false
	else
		falling_trees = true
	end
end

if falling_trees == true then
	function default.dig_tree(pos, node, name, digger, height, radius, drop)
		minetest.node_dig(pos, node, digger)

		if minetest.is_protected(pos, digger:get_player_name()) then
			return
		end

		local base_y = pos.y
		for i = 1, (height + 5) do
			pos.y = base_y + i
			local node = minetest.get_node(pos)
			if node.name ~= name or i == (height + 5) then
				minetest.remove_node({x = pos.x, y = pos.y-1, z = pos.z})
				for k = -radius, radius do
				for l = -radius, radius do
				for j = 0, 1 do
					local tree_bellow = minetest.get_node({x = pos.x+k, y = pos.y-1, z = pos.z+l})
					if tree_bellow.name ~= name then
						local pos1 = {x = pos.x+k, y = pos.y+j, z = pos.z+l}
						if minetest.get_node(pos1).name == name then
							minetest.spawn_item(pos1, drop)
							minetest.remove_node(pos1)
						end
					end
				end
				end
				end
				return
			elseif node.name == name then
				minetest.set_node({x = pos.x, y = pos.y-1, z = pos.z}, {name = name})
			end
		end
	end
else
	function default.dig_tree(pos, node, name, digger, height, radius, drop)
		minetest.node_dig(pos, node, digger)
		return
	end
end

minetest.register_on_punchplayer(function(player, hitter, time_from_last_punch, tool_capabilities)
	local weapon = hitter:get_wielded_item()
	if tool_capabilities ~= nil then
		local wear = ((tool_capabilities.full_punch_interval or 1.4) / 75 ) * 9000
		weapon:add_wear(wear)
		hitter:set_wielded_item(weapon)
	end
end)

-- From PlizAdam's tnt mod.
-- https://github.com/PilzAdam/TNT

local destroy = function(pos, radius)
	local nodename = minetest.get_node(pos).name
	if nodename ~= "air" then
		minetest.remove_node(pos)
		if math.random(1, 1000) < radius then
			minetest.set_node(pos, {name="default:lava_source"})
		end
		minetest.check_for_falling(pos)
		if minetest.registered_nodes[nodename].groups.flammable ~= nil then
			minetest.set_node(pos, {name="fire:basic_flame"})
			return
		end
	end
end

default.explode = function(pos, time, radius, damage, node)
	minetest.after(time, function(pos)
		if node then
			if minetest.get_node(pos).name ~= node then
				return
			end
		end
		minetest.sound_play("default_explode", {pos=pos, gain=1.5, max_hear_distance=2*64})
		minetest.set_node(pos, {name="castle:pillars_dungeon_stone_top"})

		local objects = minetest.get_objects_inside_radius(pos, radius * 2)
		for _,obj in ipairs(objects) do
			if obj:is_player() or (obj:get_luaentity() and obj:get_luaentity().name ~= "__builtin:item") then
				local obj_p = obj:getpos()
				local vec = {x=obj_p.x-pos.x, y=obj_p.y-pos.y, z=obj_p.z-pos.z}
				local dist = (vec.x^2+vec.y^2+vec.z^2)^0.5
				local damage = damage or (80*0.5^dist)*2
				obj:punch(obj, 1.0, {
					full_punch_interval=1.0,
					damage_groups={fleshy=damage},
				}, vec)
			end
		end

		local pr = PseudoRandom(os.time())
		for dx = -radius, radius do
		for dy = radius, -radius, -1 do
		for dz = -radius, radius do

			pos.x = pos.x+dx
			pos.y = pos.y+dy
			pos.z = pos.z+dz

			local r = vector.length(vector.new(dx, dy, dz))
			local node =  minetest.get_node(pos)
			if (radius * radius) / (r * r) >= (pr:next(80, 125) / 100)
			and not minetest.is_protected(pos) then
				destroy(pos, radius)
			end

			pos.x = pos.x-dx
			pos.y = pos.y-dy
			pos.z = pos.z-dz
		end
		end
		end

		minetest.add_particlespawner(
			100,
			0.1,
			{x=pos.x-3, y=pos.y-3, z=pos.z-3},
			{x=pos.x+3, y=pos.y+3, z=pos.z+3},
			{x=-0, y=-0, z=-0},
			{x=0, y=0, z=0},
			{x=-0.5,y=5,z=-0.5},
			{x=0.5,y=5,z=0.5},
			0.1,
			1,
			8,
			15,
			false,
			"tnt_smoke.png"
		)
	end, pos)
end
