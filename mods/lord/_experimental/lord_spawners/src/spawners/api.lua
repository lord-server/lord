--[[
    Copyright (C) 2016 - 2023 SaKeL <juraj.vajda@gmail.com>

    This library is free software; you can redistribute it and/or
    modify it pos the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library; if not, write to juraj.vajda@gmail.com
--]]
local config    = require("spawners.config")
local nodes     = require("spawners.nodes")
local Particles = require("spawners.Particles")

Particles.init(config)


-- main tables
local spawners = {
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	nodes = {}
}

local max_objects    = tonumber(minetest.settings:get('max_objects_per_block')) / 4
local tick_short_max = 20

function spawners.register_spawner(name, definition)
	definition.mod_prefix        = name:split(':')[1]
	definition.mob_name          = name:split(':')[2]
	definition.dummy_entity_name = 'lord_spawners:dummy_' .. definition.mod_prefix .. '_' .. definition.mob_name

	-- Entity inside the spawner
	nodes.dummy_entity.register(definition.dummy_entity_name, definition.dummy)


	-- Default spawner (active)
	local node_def               = {}
	node_def.description         = definition.mod_prefix .. '_' .. definition.mob_name .. ' spawner'
	node_def.paramtype           = 'light'
	node_def.paramtype2          = 'glasslikeliquidlevel'
	node_def.drawtype            = 'glasslike_framed_optional'
	node_def.walkable            = true
	node_def.sounds              = default.node_sound_metal_defaults()
	node_def.sunlight_propagates = true
	node_def.tiles               = { 'lord_spawners_spawner_16.png' }
	node_def.is_ground_content   = false
	node_def.groups              = {
		cracky       = 1,
		level        = 2,
		mobs_spawner = 1,
	}
	node_def.stack_max           = 1
	node_def.light_source        = 6
	node_def.drop                = 'default:steel_ingot 10'
	node_def.on_timer            = spawners.on_timer
	node_def.on_construct        = function(pos)
		-- set meta
		local meta = minetest.get_meta(pos)
		meta:set_int('tick', 0)
		meta:set_int('tick_short', 0)

		spawners.set_status(pos, 'active')
		spawners.tick_short(pos)
	end

	node_def.after_place_node    = function(pos, placer, itemstack, pointed_thing)
		local meta = minetest.get_meta(pos)
		meta:set_string('owner', placer:get_player_name())

		meta:set_string(
			'infotext', definition.mob_name .. ' spawner\nowner: ' .. placer:get_player_name() .. '\nspawner is active'
		)
	end

	node_def.on_destruct         = function(pos)
		-- delete particles and remove dummy
		spawners.set_status(pos, 'waiting')
	end

	local node_name              = 'lord_spawners:' .. definition.mod_prefix .. '_' .. definition.mob_name .. '_spawner'

	minetest.register_node(node_name, node_def)
	spawners.nodes[node_name]     = definition

	-- Waiting spawner
	local node_def_waiting            = table.copy(node_def)
	node_name                         = node_name .. '_waiting'
	node_def_waiting.description      = definition.mod_prefix .. '_' .. definition.mob_name .. ' spawner waiting'
	node_def_waiting.tiles            = {
		{
			name      = 'lord_spawners_spawner_waiting_animated_16.png',
			animation = {
				type     = 'vertical_frames',
				aspect_w = 16,
				aspect_h = 16,
				length   = 2.0
			}
		}
	}
	node_def_waiting.groups           = { cracky = 1, level = 2, not_in_creative_inventory = 1, mobs_spawner = 1 }
	node_def_waiting.light_source     = 4
	node_def_waiting.drop             = 'default:steel_ingot 10'
	node_def_waiting.on_timer         = spawners.on_timer
	node_def_waiting.on_construct     = nil
	node_def_waiting.after_place_node = nil
	node_def_waiting.on_destruct      = nil

	minetest.register_node(node_name, node_def_waiting)
	spawners.nodes[node_name] = definition


	minetest.register_lbm({
		name      = 'lord_spawners:start_nodetimer_' .. definition.mod_prefix .. '_' .. definition.mob_name .. '_spawner',
		nodenames = 'lord_spawners:' .. definition.mod_prefix .. '_' .. definition.mob_name .. '_spawner',
		action    = function(pos)
			spawners.tick_short(pos)
		end,
	})
end


--
-- Timers
--
-- how often node timers for spawners will tick, +/- some random value
function spawners.tick(pos)
	local meta         = minetest.get_meta(pos)
	local tick_counter = meta:get_int('tick')
	local owner        = meta:get_string('owner')
	local privs        = minetest.get_player_privs(owner);

	-- not for admin
	if not privs.privs then
		tick_counter = tick_counter + 1
		meta:set_int('tick', tick_counter)
	end

	minetest.get_node_timer(pos):start(math.random(5, 15))
end

-- how often a spawn failure tick is retried (e.g. too dark)
function spawners.tick_short(pos)
	local meta               = minetest.get_meta(pos)
	local tick_short_counter = meta:get_int('tick_short')

	if tick_short_counter >= tick_short_max then
		spawners.tick(pos)
		return
	else
		tick_short_counter = tick_short_counter + 1
		meta:set_int('tick_short', tick_short_counter)
	end
	minetest.get_node_timer(pos):start(math.random(5, 10))
end

--
-- Core Functions
--
--- @param
--- @param mob_name     string
--- @param sound_custom string
function spawners.start_spawning(spawn_area_random_pos, mob_name, sound_custom)
	if not (spawn_area_random_pos or mob_name) then
		return
	end

	local sound_name = sound_custom or mob_name:replace(':', '_')


	for i = 1, #spawn_area_random_pos do
		-- spawn a bit more above the block - prevent spawning inside the block
		spawn_area_random_pos[i].y = spawn_area_random_pos[i].y + 0.5

		Particles.cloud_boom(spawn_area_random_pos[i])

		minetest.after(1, function()
			local obj = minetest.add_entity(spawn_area_random_pos[i], mob_name)
			if obj then
				if sound_name then
					minetest.sound_play(sound_name, {
						pos               = spawn_area_random_pos[i],
						max_hear_distance = 16,
						gain              = 0.5
					})
				end
			end
		end)
	end
end

function spawners.on_timer(pos, elapsed)
	local meta      = minetest.get_meta(pos)
	local node      = minetest.get_node(pos)
	local mob_table = spawners.nodes[node.name]

	if not mob_table then
		return
	end

	local player_near           = false
	local entities_near         = 0
	local entities_max          = 6
	local node_light_min        = 13

	local mob_name              = mob_table.mod_prefix .. ":" .. mob_table.mob_name
	local sound_custom          = mob_table.sound_custom
	local night_only            = mob_table.night_only
	local has_dummy             = false

	local objects_inside_radius = minetest.get_objects_inside_radius(pos, 0.5)
	for _, obj in ipairs(objects_inside_radius) do
		local lua_ent = obj:get_luaentity()
		if lua_ent and lua_ent.name == mob_table.dummy_entity_name then
			has_dummy = true
		end
	end

	if not has_dummy and meta:get_string('status') == 'active' then
		nodes.dummy_entity.add(pos, mob_table.dummy_entity_name)
	end

	-- check spawner light
	local node_light = minetest.get_node_light(pos)

	if night_only ~= 'disabled' then
		-- dark
		if (not node_light or node_light < node_light_min) and not night_only then
			spawners.set_status(pos, 'waiting', 'Too dark for mob to spawn. Waiting for day .. .')
			spawners.tick_short(pos)
			return
		-- light
		elseif node_light >= node_light_min and night_only then
			spawners.set_status(pos, 'waiting', 'Too much light for mob to spawn. Waiting for night .. .')
			spawners.tick_short(pos)
			return
		end
	end

	-- positions where mobs can spawn
	local posmin         = { x = pos.x - 3, y = pos.y - 1, z = pos.z - 3 }
	local posmax         = { x = pos.x + 4, y = pos.y + 4, z = pos.z + 4 }
	local spawn_area_pos = minetest.find_nodes_in_area(posmin, posmax, 'air')

	-- check if there is enough place to spawn mob
	if #spawn_area_pos < 1 then
		spawners.set_status(pos, 'waiting', 'Not enough place to spawn mob. Find more space!')
		spawners.tick(pos)
		return
	end

	-- spawn 2 mobs on 2 different positions by chance
	local how_many              = math.random(1, 2)
	local spawn_area_random_pos = {}

	-- get random spawn position from spawn area
	for i = 1, how_many do
		while #spawn_area_random_pos < how_many and #spawn_area_pos > 0 do

			local random_pos       = spawn_area_pos[math.random(#spawn_area_pos)]
			local random_pos_above = minetest.get_node(
				{ x = random_pos.x, y = random_pos.y + 1, z = random_pos.z }
			).name

			if random_pos_above == 'air' then
				table.insert(spawn_area_random_pos, random_pos)
			else
				table.remove(spawn_area_pos, i)
			end

		end
	end

	-- check if there is still enough place to spawn mob
	if #spawn_area_random_pos < 1 then
		spawners.set_status(pos, 'waiting', 'Not enough place to spawn mob. Searching for new location .. .')
		spawners.tick_short(pos)
		return
	end

	-- area where player and entity count will be detected
	local activation_area = minetest.get_objects_inside_radius(pos, 16)

	-- prevent object clutter on the map
	if #activation_area > max_objects then
		spawners.set_status(
			pos,
			'waiting',
			'Too many objects in the area (' .. #activation_area .. '/' .. max_objects .. '), ' ..
				'clean-up dropped objects first!'
		)
		spawners.tick_short(pos)
		return
	end

	for k, object in ipairs(activation_area) do
		-- find player inside activation area
		if object:is_player() then
			player_near = true
		end

		-- find entities inside activation area
		if
			not object:is_player()
			and object:get_luaentity()
			and object:get_luaentity().name ~= '__builtin:item'
			and object:get_luaentity() == mob_name
		then
			entities_near = entities_near + 1
		end
		-- stop looping when met all conditions
		if entities_near >= entities_max and player_near then
			break
		end
	end

	-- don't do anything and try again later when player not near or max entities reached
	if entities_near >= entities_max or not player_near then
		spawners.set_status(pos, 'waiting', 'max mobs reached: ' .. entities_near .. '/' .. entities_max)
		spawners.tick_short(pos)
		return
	end

	-- start spawning
	spawners.start_spawning(spawn_area_random_pos, mob_name, sound_custom)

	spawners.set_status(pos, 'active', 'spawner is active reached: ' .. entities_near .. '/' .. entities_max)
	meta:set_int('tick', 0)
	meta:set_int('tick_short', 0)

	spawners.tick(pos)
end

--- @param
local function spawner_add_particles(meta, position)
	local id_flame = Particles.add_flame_effects(position)
	local id_smoke = Particles.add_smoke_effects(position)
	meta:set_int('id_flame', id_flame)
	meta:set_int('id_smoke', id_smoke)
end

local function spawner_del_particles(meta)
	local id_flame    = meta:get_int('id_flame')
	local id_smoke    = meta:get_int('id_smoke')
	-- delete particles
	if id_flame ~= -1 and id_smoke ~= -1 then
		minetest.delete_particlespawner(id_flame)
		minetest.delete_particlespawner(id_smoke)
		meta:set_int('id_flame', -1)
		meta:set_int('id_smoke', -1)
	end
end

--
-- Status Manager
--
function spawners.set_status(pos, set_status, message)
	message = message or ''
	local meta      = minetest.get_meta(pos)
	local node      = minetest.get_node(pos)
	local mob_table = spawners.nodes[node.name]

	if not mob_table then
		return
	end

	local mod_prefix  = mob_table.mod_prefix
	local mob_name    = mob_table.mob_name

	-- get meta
	local owner       = meta:get_string('owner')
	local meta_status = meta:get_string('status')

	local infotext = mob_name .. ' spawner\nowner: ' .. owner .. '\n'


	--
	-- active
	--
	if set_status == 'active' then
		-- remove particles and add them again - keeps particles after server restart
		spawner_del_particles(meta)
		spawner_add_particles(meta, pos)

		if meta_status ~= set_status then
			nodes.dummy_entity.add(pos, mob_table.dummy_entity_name)
			minetest.swap_node(pos, { name = 'lord_spawners:' .. mod_prefix .. '_' .. mob_name .. '_spawner' })
			meta:set_string('status', 'active')
		end

	elseif set_status == 'waiting' and meta_status ~= set_status then

		spawner_del_particles(meta)
		nodes.dummy_entity.remove(pos)
		minetest.swap_node(pos, { name = 'lord_spawners:' .. mod_prefix .. '_' .. mob_name .. '_spawner_waiting' })
		meta:set_string('status', 'waiting')
		meta:set_string('infotext', infotext .. message)

	end
end


return {
	register  = spawners.register_spawner,
	get_nodes = function() return spawners.nodes end,
}
