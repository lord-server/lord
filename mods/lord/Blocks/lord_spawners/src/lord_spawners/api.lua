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

-- main tables
local lord_spawners        = {
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	nodes = {}
}

local max_obj_per_mapblock = tonumber(minetest.settings:get('max_objects_per_block'))
local enable_particles     = minetest.settings:get_bool('enable_particles')
local tick_max             = 30
local tick_short_max       = 20

function lord_spawners.register_spawner(name, def)
	def.mod_prefix = name:split(':')[1]
	def.mob_name   = name:split(':')[2]

	-- Entity inside the spawner
	local ent_name = 'lord_spawners:dummy_' .. def.mod_prefix .. '_' .. def.mob_name
	local ent_def  = {
		hp_max               = 1,
		visual               = def.dummy_visual or 'mesh',
		visual_size          = def.dummy_size,
		collisionbox         = { 0, 0, 0, 0, 0, 0 },
		mesh                 = def.dummy_mesh,
		textures             = def.dummy_texture,
		physical             = false,
		makes_footstep_sound = false,
		automatic_rotate     = math.pi * -3,
		static_save          = false,
		timer                = 0,
		on_activate          = function(self, staticdata, dtime_s)
			self.object:set_velocity({ x = 0, y = 0, z = 0 })
			self.object:set_acceleration({ x = 0, y = 0, z = 0 })
			self.object:set_armor_groups({ immortal = 1 })
		end
	}

	minetest.register_entity(ent_name, ent_def)

	-- Default spawner (active)
	local node_def               = {}
	node_def.description         = def.mod_prefix .. '_' .. def.mob_name .. ' spawner'
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
	node_def.on_timer            = lord_spawners.on_timer
	node_def.on_construct        = function(pos)
		-- set meta
		local meta = minetest.get_meta(pos)
		meta:set_int('tick', 0)
		meta:set_int('tick_short', 0)

		lord_spawners.set_status(pos, 'active')
		lord_spawners.tick_short(pos)
	end

	node_def.after_place_node    = function(pos, placer, itemstack, pointed_thing)
		local meta = minetest.get_meta(pos)
		meta:set_string('owner', placer:get_player_name())

		meta:set_string(
			'infotext', def.mob_name .. ' spawner\nowner: ' .. placer:get_player_name() .. '\nspawner is active'
		)
	end

	node_def.on_destruct         = function(pos)
		-- delete particles and remove dummy
		lord_spawners.set_status(pos, 'waiting')
	end

	local node_name              = 'lord_spawners:' .. def.mod_prefix .. '_' .. def.mob_name .. '_spawner'

	minetest.register_node(node_name, node_def)
	lord_spawners.nodes[node_name]    = def

	-- Waiting spawner
	local node_def_waiting            = table.copy(node_def)
	node_name                         = 'lord_spawners:' .. def.mod_prefix .. '_' .. def.mob_name .. '_spawner_waiting'
	node_def_waiting.description      = def.mod_prefix .. '_' .. def.mob_name .. ' spawner waiting'
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
	node_def_waiting.on_timer         = lord_spawners.on_timer
	node_def_waiting.on_construct     = nil
	node_def_waiting.after_place_node = nil
	node_def_waiting.on_destruct      = nil

	minetest.register_node(node_name, node_def_waiting)
	lord_spawners.nodes[node_name]  = def

	-- Rusty spawner
	local node_def_rusty            = table.copy(node_def)
	node_name                       = 'lord_spawners:' .. def.mod_prefix .. '_' .. def.mob_name .. '_spawner_rusty'
	node_def_rusty.description      = def.mod_prefix .. '_' .. def.mob_name .. ' spawner rusty'
	node_def_rusty.tiles            = { 'lord_spawners_spawner_rusty.png' }
	node_def_rusty.groups           = { cracky = 1, level = 2, not_in_creative_inventory = 1, mobs_spawner = 1 }
	node_def_rusty.drop             = 'default:steel_ingot 10'
	node_def_rusty.on_timer         = nil
	node_def_rusty.on_construct     = nil
	node_def_rusty.after_place_node = nil
	node_def_rusty.on_destruct      = nil

	minetest.register_node(node_name, node_def_rusty)
	lord_spawners.nodes[node_name] = def

	minetest.register_lbm({
		name      = 'lord_spawners:start_nodetimer_' .. def.mod_prefix .. '_' .. def.mob_name .. '_spawner',
		nodenames = 'lord_spawners:' .. def.mod_prefix .. '_' .. def.mob_name .. '_spawner',
		action    = function(pos)
			lord_spawners.tick_short(pos)
		end,
	})
end

--
-- Particles
--
function lord_spawners.cloud_boom(pos)
	if not enable_particles then
		return
	end

	minetest.add_particlespawner({
		amount     = 5,
		time       = 2,
		minpos     = vector.subtract({ x = pos.x - 0.3, y = pos.y, z = pos.z - 0.3 }, 0.3),
		maxpos     = vector.add({ x = pos.x + 0.3, y = pos.y, z = pos.z + 0.3 }, 0.3),
		minvel     = { x = 0.1, y = 0.1, z = 0.1 },
		maxvel     = { x = 0.2, y = 0.2, z = 0.2 },
		minacc     = vector.new({ x = -0.1, y = 0.3, z = -0.1 }),
		maxacc     = vector.new({ x = 0.1, y = 0.6, z = 0.1 }),
		minexptime = 2,
		maxexptime = 3,
		minsize    = 16,
		maxsize    = 24,
		texture    = 'lord_spawners_smoke_particle_2.png',
		animation  = {
			type     = 'vertical_frames',
			-- Width of a frame in pixels
			aspect_w = 16,
			-- Height of a frame in pixels
			aspect_h = 16,
			-- Full loop length
			length   = 2.0,
		},
	})
end

function lord_spawners.add_flame_effects(pos)
	if not enable_particles then
		return
	end

	return minetest.add_particlespawner({
		amount     = 6,
		time       = 0,
		minpos     = vector.subtract({ x = pos.x - 0.001, y = pos.y - 0.001, z = pos.z - 0.001 }, 0.5),
		maxpos     = vector.add({ x = pos.x + 0.001, y = pos.y + 0.001, z = pos.z + 0.001 }, 0.5),
		minvel     = { x = -0.1, y = -0.1, z = -0.1 },
		maxvel     = { x = 0.1, y = 0.1, z = 0.1 },
		minacc     = vector.new(),
		maxacc     = vector.new(),
		minexptime = 1,
		maxexptime = 5,
		minsize    = 0.5,
		maxsize    = 2.5,
		texture    = 'lord_spawners_flame_particle_2.png',
	})
end

function lord_spawners.add_smoke_effects(pos)
	if not enable_particles then
		return
	end

	return minetest.add_particlespawner({
		amount     = 1,
		time       = 0,
		minpos     = vector.subtract({ x = pos.x - 0.001, y = pos.y - 0.001, z = pos.z - 0.001 }, 0.5),
		maxpos     = vector.add({ x = pos.x + 0.001, y = pos.y + 0.001, z = pos.z + 0.001 }, 0.5),
		minvel     = { x = -0.5, y = 0.5, z = -0.5 },
		maxvel     = { x = 0.5, y = 1.5, z = 0.5 },
		minacc     = vector.new({ x = -0.1, y = 0.1, z = -0.1 }),
		maxacc     = vector.new({ x = 0.1, y = 0.3, z = 0.1 }),
		minexptime = 0.5,
		maxexptime = 2,
		minsize    = 0.5,
		maxsize    = 2,
		texture    = 'lord_spawners_smoke_particle.png^[transform' .. math.random(0, 3),
	})
end

--
-- Timers
--
-- how often node timers for spawners will tick, +/- some random value
function lord_spawners.tick(pos)
	local meta         = minetest.get_meta(pos)
	local tick_counter = meta:get_int('tick')
	local owner        = meta:get_string('owner')
	local privs        = minetest.get_player_privs(owner);

	-- not for admin
	if not privs.privs then
		tick_counter = tick_counter + 1
		meta:set_int('tick', tick_counter)
	end

	-- rusty spawner
	if tick_counter >= tick_max then
		lord_spawners.set_status(pos, 'rusty')
		return
	end

	minetest.get_node_timer(pos):start(math.random(5, 15))
end

-- how often a spawn failure tick is retried (e.g. too dark)
function lord_spawners.tick_short(pos)
	local meta               = minetest.get_meta(pos)
	local tick_short_counter = meta:get_int('tick_short')

	if tick_short_counter >= tick_short_max then
		lord_spawners.tick(pos)
		return
	else
		tick_short_counter = tick_short_counter + 1
		meta:set_int('tick_short', tick_short_counter)
	end
	minetest.get_node_timer(pos):start(math.random(5, 10))
	-- minetest.get_node_timer(pos):start(math.random(10, 20))
end

--
-- Core Functions
--
-- start spawning mobs
function lord_spawners.start_spawning(spawn_area_random_pos, mob_name, mod_prefix, sound_custom)
	if not (spawn_area_random_pos or mob_name) then
		return
	end

	local sound_name = mod_prefix .. '_' .. mob_name
	-- use custom sounds
	if sound_custom ~= '' then
		sound_name = sound_custom
	end

	-- use random colors for sheeps
	if mob_name == 'sheep_white' then
		local sheep_colors = {
			'black', 'blue', 'brown', 'cyan', 'dark_green', 'dark_grey', 'green',
			'grey', 'magenta', 'orange', 'pink', 'red', 'violet', 'white', 'yellow'
		}
		mob_name           = 'sheep_' .. sheep_colors[math.random(1, #sheep_colors)]
	end

	for i = 1, #spawn_area_random_pos do
		-- spawn a bit more above the block - prevent spawning inside the block
		spawn_area_random_pos[i].y = spawn_area_random_pos[i].y + 0.5

		lord_spawners.cloud_boom(spawn_area_random_pos[i])

		minetest.after(1, function()
			-- minetest.set_node(spawn_area_random_pos[i], {name = 'default:apple' })
			local obj = minetest.add_entity(spawn_area_random_pos[i], mod_prefix .. ':' .. mob_name)
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

function lord_spawners.on_timer(pos, elapsed)
	local meta      = minetest.get_meta(pos)
	local node      = minetest.get_node(pos)
	local mob_table = lord_spawners.nodes[node.name]

	if not mob_table then
		return
	end

	local posmin                = { x = pos.x - 3, y = pos.y - 1, z = pos.z - 3 }
	local posmax                = { x = pos.x + 4, y = pos.y + 4, z = pos.z + 4 }
	local player_near           = false
	local entities_near         = 0
	local entities_max          = 6
	local node_light_min        = 13

	local owner                 = meta:get_string('owner') or ''
	local mod_prefix            = mob_table.mod_prefix
	local mob_name              = mob_table.mob_name
	local sound_custom          = mob_table.sound_custom
	local night_only            = mob_table.night_only
	local max_objects           = max_obj_per_mapblock / 4
	local offset                = mob_table.dummy_offset
	local has_dummy             = false

	local objects_inside_radius = minetest.get_objects_inside_radius(pos, 0.5)

	for _, obj in ipairs(objects_inside_radius) do
		local lua_ent = obj:get_luaentity()

		if lua_ent then
			if lua_ent.name == 'lord_spawners:dummy_' .. mod_prefix .. '_' .. mob_name then
				has_dummy = true
			end
		end
	end

	if not has_dummy and meta:get_string('status') == 'active' then
		minetest.add_entity(
			{ x = pos.x, y = pos.y + offset, z = pos.z }, 'lord_spawners:dummy_' .. mod_prefix .. '_' .. mob_name
		)
	end

	-- check spawner light
	local node_light = minetest.get_node_light(pos)

	-- dark
	if (not node_light or node_light < node_light_min) and not night_only then
		lord_spawners.set_status(pos, 'waiting')

		-- set infotext
		meta:set_string(
			'infotext', mob_name .. ' spawner\nowner: ' .. owner .. '\nToo dark for mob to spawn. Waiting for day .. .'
		)
		lord_spawners.tick_short(pos)
		return

	elseif node_light >= node_light_min and night_only then
		-- light
		lord_spawners.set_status(pos, 'waiting')

		-- set infotext
		meta:set_string(
			'infotext',
			mob_name .. ' spawner\nowner: ' .. owner .. '\nToo much light for mob to spawn. Waiting for night .. .'
		)
		lord_spawners.tick_short(pos)
		return
	end

	-- positions where mobs can spawn
	local spawn_area_pos = minetest.find_nodes_in_area(posmin, posmax, 'air')

	-- check if there is enough place to spawn mob
	if #spawn_area_pos < 1 then
		lord_spawners.set_status(pos, 'waiting')

		-- set infotext
		meta:set_string(
			'infotext', mob_name .. ' spawner\nowner: ' .. owner .. '\nNot enough place to spawn mob. Find more space!'
		)
		lord_spawners.tick(pos)
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
		lord_spawners.set_status(pos, 'waiting')

		-- set infotext
		meta:set_string(
			'infotext',
			mob_name .. ' spawner\nowner: ' .. owner .. '\n' ..
				'Not enough place to spawn mob. Searching for new location .. .'
		)
		lord_spawners.tick_short(pos)
		return
	end

	-- area where player and entity count will be detected
	local activation_area = minetest.get_objects_inside_radius(pos, 16)

	-- prevent object clutter on the map
	if #activation_area > max_objects then
		lord_spawners.set_status(pos, 'waiting')

		-- set infotext
		meta:set_string(
			'infotext',
			mob_name .. ' spawner\nowner: ' .. owner .. '\n' ..
				'Too many objects in the area (' .. #activation_area .. '/' .. max_objects .. '), ' ..
				'clean-up dropped objects first!'
		)
		lord_spawners.tick_short(pos)
		return
	end

	for k, object in ipairs(activation_area) do
		-- find player inside activation area
		if object:is_player() then
			player_near = true
		end

		-- find entities inside activation area
		if not object:is_player()
			and object:get_luaentity()
			and object:get_luaentity().name ~= '__builtin:item'
		then
			local tmp_mob_name = string.split(object:get_luaentity().name, ':')[2]

			if tmp_mob_name ~= nil then
				-- sheeps have colors in names
				if
					string.find(tmp_mob_name, 'sheep') and
					string.find(mob_name, 'sheep') and
					not string.find(tmp_mob_name, 'dummy')
				then
					entities_near = entities_near + 1
				elseif tmp_mob_name == mob_name then
					entities_near = entities_near + 1
				end
			else
				minetest.log(
					'warning',
					'[lord_spawners] tmp_mob_name was nil, luaentity name was: ' ..
						object:get_luaentity().name .. ' at: ' .. minetest.pos_to_string(object:get_pos())
				)
			end
		end

		-- stop looping when met all conditions
		if entities_near >= entities_max and player_near then
			break
		end
	end

	-- don't do anything and try again later when player not near or max entities reached
	if entities_near >= entities_max or not player_near then
		lord_spawners.set_status(pos, 'waiting')

		meta:set_string(
			'infotext',
			mob_name .. ' spawner\nowner: ' .. owner .. '\nmax mobs reached: ' .. entities_near .. '/' .. entities_max
		) -- or player not near
		lord_spawners.tick_short(pos)
		return
	end

	-- start spawning
	lord_spawners.start_spawning(spawn_area_random_pos, mob_name, mod_prefix, sound_custom)

	lord_spawners.set_status(pos, 'active')
	meta:set_string(
		'infotext',
		mob_name .. ' spawner\nowner: ' .. owner .. '\nspawner is active reached: ' .. entities_near .. '/' .. entities_max
	)

	meta:set_int('tick', 0)
	meta:set_int('tick_short', 0)

	lord_spawners.tick(pos)
end

--
-- Status Manager
--
function lord_spawners.set_status(pos, set_status)
	local meta      = minetest.get_meta(pos)
	local node      = minetest.get_node(pos)
	local mob_table = lord_spawners.nodes[node.name]

	if not mob_table then
		return
	end

	local mod_prefix  = mob_table.mod_prefix
	local mob_name    = mob_table.mob_name
	local offset      = mob_table.dummy_offset

	-- get meta
	local owner       = meta:get_string('owner')
	local meta_status = meta:get_string('status')
	local id_flame    = meta:get_int('id_flame')
	local id_smoke    = meta:get_int('id_smoke')

	--
	-- active
	--
	if set_status == 'active' then
		-- remove particles and add them again - keeps particles after server restart
		-- delete particles
		if id_flame ~= -1 and id_smoke ~= -1 then
			minetest.delete_particlespawner(id_flame)
			minetest.delete_particlespawner(id_smoke)
			meta:set_int('id_flame', -1)
			meta:set_int('id_smoke', -1)
		end

		-- add particles
		id_flame = lord_spawners.add_flame_effects(pos)
		id_smoke = lord_spawners.add_smoke_effects(pos)
		meta:set_int('id_flame', id_flame)
		meta:set_int('id_smoke', id_smoke)

		if meta_status ~= set_status then
			-- add dummy entity
			minetest.add_entity(
				{ x = pos.x, y = pos.y + offset, z = pos.z },
				'lord_spawners:dummy_' .. mod_prefix .. '_' .. mob_name
			)

			meta:set_string('status', 'active')

			minetest.swap_node(pos, { name = 'lord_spawners:' .. mod_prefix .. '_' .. mob_name .. '_spawner' })
		end
	elseif set_status == 'waiting' and meta_status ~= set_status then
		--
		-- waiting
		--

		-- delete particles
		if id_flame ~= -1 and id_smoke ~= -1 then
			minetest.delete_particlespawner(id_flame)
			minetest.delete_particlespawner(id_smoke)
			meta:set_int('id_flame', -1)
			meta:set_int('id_smoke', -1)
		end

		-- remove dummy
		local objs = minetest.get_objects_inside_radius(pos, 0.5)
		if objs then
			for _, obj in ipairs(objs) do
				if
					obj and obj:get_luaentity() and
					obj:get_luaentity().name == 'lord_spawners:dummy_' .. mod_prefix .. '_' .. mob_name
				then
					obj:remove()
				end
			end
		end

		meta:set_string('status', 'waiting')

		minetest.swap_node(pos, { name = 'lord_spawners:' .. mod_prefix .. '_' .. mob_name .. '_spawner_waiting' })
	elseif set_status == 'rusty' and meta_status ~= set_status then
		--
		-- rusty
		--

		-- delete particles
		if id_flame ~= -1 and id_smoke ~= -1 then
			minetest.delete_particlespawner(id_flame)
			minetest.delete_particlespawner(id_smoke)
			meta:set_int('id_flame', -1)
			meta:set_int('id_smoke', -1)
		end

		-- remove dummy
		local objs = minetest.get_objects_inside_radius(pos, 0.5)
		if objs then
			for _, obj in ipairs(objs) do
				if
					obj and obj:get_luaentity() and
					obj:get_luaentity().name == 'lord_spawners:dummy_' .. mod_prefix .. '_' .. mob_name
				then
					obj:remove()
				end
			end
		end

		meta:set_string('status', 'rusty')

		minetest.swap_node(pos, { name = 'lord_spawners:' .. mod_prefix .. '_' .. mob_name .. '_spawner_rusty' })

		-- set infotext
		meta:set_string(
			'infotext',
			mob_name .. ' spawner\nowner: ' .. owner .. '\n' ..
				'Spawner was searching for too long and got rusted! Dig up the spawner and place it again.'
		)
		return
	end
end


return {
	register  = lord_spawners.register_spawner,
	get_nodes = function() return lord_spawners.nodes end,
}
