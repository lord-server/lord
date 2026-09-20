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

local max_objects    = tonumber(core.settings:get('max_objects_per_block')) / 4
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
		local meta = core.get_meta(pos)
		meta:set_int('tick', 0)
		meta:set_int('tick_short', 0)

		spawners.set_status(pos, 'active')
		spawners.tick_short(pos)
	end

	node_def.after_place_node    = function(pos, placer, itemstack, pointed_thing)
		local meta = core.get_meta(pos)
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

	core.register_node(node_name, node_def)
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

	core.register_node(node_name, node_def_waiting)
	spawners.nodes[node_name] = definition


	core.register_lbm({
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
	local meta         = core.get_meta(pos)
	local tick_counter = meta:get_int('tick')
	local owner        = meta:get_string('owner')
	local privs        = core.get_player_privs(owner);

	-- not for admin
	if not privs.privs then
		tick_counter = tick_counter + 1
		meta:set_int('tick', tick_counter)
	end

	core.get_node_timer(pos):start(math.random(5, 15))
end

-- how often a spawn failure tick is retried (e.g. too dark)
function spawners.tick_short(pos)
	local meta               = core.get_meta(pos)
	local tick_short_counter = meta:get_int('tick_short')

	if tick_short_counter >= tick_short_max then
		spawners.tick(pos)
		return
	else
		tick_short_counter = tick_short_counter + 1
		meta:set_int('tick_short', tick_short_counter)
	end
	core.get_node_timer(pos):start(math.random(5, 10))
end

--
-- Core Functions
--
--- @param spawn_area_random_pos Position[]
--- @param mob_name              string
--- @param sound_custom          string
function spawners.start_spawning(spawn_area_random_pos, mob_name, sound_custom)
	if not (spawn_area_random_pos or mob_name) then
		return
	end

	local sound_name = sound_custom or mob_name:replace(':', '_')


	for i = 1, #spawn_area_random_pos do
		-- spawn a bit more above the block - prevent spawning inside the block
		spawn_area_random_pos[i].y = spawn_area_random_pos[i].y + 0.5

		Particles.cloud_boom(spawn_area_random_pos[i])

		core.after(1, function()
			local obj = core.add_entity(spawn_area_random_pos[i], mob_name)
			if obj then
				if sound_name then
					core.sound_play(sound_name, {
						pos               = spawn_area_random_pos[i],
						max_hear_distance = 16,
						gain              = 0.5
					})
				end
			end
		end)
	end
end

local ENTITIES_MAX   = 6
local NODE_LIGHT_MIN = 13

--- Puts the dummy entity into the active spawner if it has no one.
--- @param pos               Position
--- @param meta              MetaDataRef
--- @param dummy_entity_name string
local function restore_dummy_entity(pos, meta, dummy_entity_name)
	local has_dummy = false
	for _, obj in ipairs(core.get_objects_inside_radius(pos, 0.5)) do
		local lua_ent = obj:get_luaentity()
		if lua_ent and lua_ent.name == dummy_entity_name then
			has_dummy = true
		end
	end

	if not has_dummy and meta:get_string('status') == 'active' then
		nodes.dummy_entity.add(pos, dummy_entity_name)
	end
end

--- @param node_light number|nil
--- @param night_only boolean|string `true`, `false` or `'disabled'`
--- @return string|nil message with the reason why the spawner has to wait
local function get_light_wait_message(node_light, night_only)
	if night_only == 'disabled' then
		return nil
	end

	if (not node_light or node_light < NODE_LIGHT_MIN) and not night_only then
		return 'Too dark for mob to spawn. Waiting for day .. .'
	elseif node_light >= NODE_LIGHT_MIN and night_only then
		return 'Too much light for mob to spawn. Waiting for night .. .'
	end
end

--- Chooses `how_many` random positions where the mobs can spawn.
--- @param spawn_area_pos Position[] all the positions where mobs can spawn (positions can be removed from it)
--- @param how_many       integer
--- @return Position[]
local function pick_random_positions(spawn_area_pos, how_many)
	local spawn_area_random_pos = {}

	-- get random spawn position from spawn area
	for i = 1, how_many do
		while #spawn_area_random_pos < how_many and #spawn_area_pos > 0 do

			local random_pos       = spawn_area_pos[math.random(#spawn_area_pos)]
			local random_pos_above = core.get_node(
				{ x = random_pos.x, y = random_pos.y + 1, z = random_pos.z }
			).name

			if random_pos_above == 'air' then
				table.insert(spawn_area_random_pos, random_pos)
			else
				table.remove(spawn_area_pos, i)
			end

		end
	end

	return spawn_area_random_pos
end

--- Detects the player and the mobs of the type inside the activation area.
--- @param activation_area table[] objects
--- @param mob_name        string
--- @return boolean, integer whether a player is near, amount of the mobs near
local function scan_activation_area(activation_area, mob_name)
	local player_near   = false
	local entities_near = 0

	for _, object in ipairs(activation_area) do
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
		if entities_near >= ENTITIES_MAX and player_near then
			break
		end
	end

	return player_near, entities_near
end

--- Sets the "waiting" status and retries soon.
--- @param pos     Position
--- @param message string
local function wait_short(pos, message)
	spawners.set_status(pos, 'waiting', message)
	spawners.tick_short(pos)
end

function spawners.on_timer(pos, elapsed)
	local meta      = core.get_meta(pos)
	local node      = core.get_node(pos)
	local mob_table = spawners.nodes[node.name]

	if not mob_table then
		return
	end

	local mob_name = mob_table.mod_prefix .. ":" .. mob_table.mob_name

	restore_dummy_entity(pos, meta, mob_table.dummy_entity_name)

	-- check spawner light
	local light_message = get_light_wait_message(core.get_node_light(pos), mob_table.night_only)
	if light_message then
		wait_short(pos, light_message)
		return
	end

	-- positions where mobs can spawn
	local posmin         = { x = pos.x - 3, y = pos.y - 1, z = pos.z - 3 }
	local posmax         = { x = pos.x + 4, y = pos.y + 4, z = pos.z + 4 }
	local spawn_area_pos = core.find_nodes_in_area(posmin, posmax, 'air')

	-- check if there is enough place to spawn mob
	if #spawn_area_pos < 1 then
		spawners.set_status(pos, 'waiting', 'Not enough place to spawn mob. Find more space!')
		spawners.tick(pos)
		return
	end

	-- spawn 2 mobs on 2 different positions by chance
	local spawn_area_random_pos = pick_random_positions(spawn_area_pos, math.random(1, 2))

	-- check if there is still enough place to spawn mob
	if #spawn_area_random_pos < 1 then
		wait_short(pos, 'Not enough place to spawn mob. Searching for new location .. .')
		return
	end

	-- area where player and entity count will be detected
	local activation_area = core.get_objects_inside_radius(pos, 16)

	-- prevent object clutter on the map
	if #activation_area > max_objects then
		wait_short(
			pos,
			'Too many objects in the area (' .. #activation_area .. '/' .. max_objects .. '), ' ..
				'clean-up dropped objects first!'
		)
		return
	end

	local player_near, entities_near = scan_activation_area(activation_area, mob_name)

	-- don't do anything and try again later when player not near or max entities reached
	if entities_near >= ENTITIES_MAX or not player_near then
		wait_short(pos, 'max mobs reached: ' .. entities_near .. '/' .. ENTITIES_MAX)
		return
	end

	-- start spawning
	spawners.start_spawning(spawn_area_random_pos, mob_name, mob_table.sound_custom)

	spawners.set_status(pos, 'active', 'spawner is active reached: ' .. entities_near .. '/' .. ENTITIES_MAX)
	meta:set_int('tick', 0)
	meta:set_int('tick_short', 0)

	spawners.tick(pos)
end

--- @param meta MetaDataRef
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
		core.delete_particlespawner(id_flame)
		core.delete_particlespawner(id_smoke)
		meta:set_int('id_flame', -1)
		meta:set_int('id_smoke', -1)
	end
end

--
-- Status Manager
--
function spawners.set_status(pos, set_status, message)
	message = message or ''
	local meta      = core.get_meta(pos)
	local node      = core.get_node(pos)
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
			core.swap_node(pos, { name = 'lord_spawners:' .. mod_prefix .. '_' .. mob_name .. '_spawner' })
			meta:set_string('status', 'active')
		end

	elseif set_status == 'waiting' and meta_status ~= set_status then

		spawner_del_particles(meta)
		nodes.dummy_entity.remove(pos)
		core.swap_node(pos, { name = 'lord_spawners:' .. mod_prefix .. '_' .. mob_name .. '_spawner_waiting' })
		meta:set_string('status', 'waiting')
		meta:set_string('infotext', infotext .. message)

	end
end


return {
	register  = spawners.register_spawner,
	get_nodes = function() return spawners.nodes end,
}
