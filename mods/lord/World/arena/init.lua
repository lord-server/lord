arena = {
	-- Defines thickness of a border around arena, where mobs aren't spawned but
	-- the arena updates.
	LAZY_AREA_OFFSET = {x=20, y=20, z=20},
	-- Mobs spawn at y=minp + this offset
	SPAWN_Y_OFFSET = 4,
}

local state = {
	last_occupied_id = 0,
	arenas = {},
}

local function alloc_arena_id()
	state.last_occupied_id = state.last_occupied_id + 1
	return state.last_occupied_id
end

function arena.add_arena(pos1, pos2, mobs)
	local id = alloc_arena_id()
	state.arenas[id] = {
		pos1 = pos1,
		pos2 = pos2,
		mobs = mobs,
	}
	return id
end

function arena.remove_arena(id)
	state.arenas[id] = nil
end

-- Spawns mob somewhere in the cuboid
local function spawn_mob_inside_cuboid(mob, minp, maxp)
	local pos = {
		x = math.random(minp.x, maxp.x),
		y = minp.y + arena.SPAWN_Y_OFFSET,
		z = math.random(minp.z, maxp.z),
	}
	minetest.add_entity(pos, mob)
end

local function is_inside_cuboid(p, minp, maxp)
	return
		p.x >= minp.x and p.x <= maxp.x and
		p.y >= minp.y and p.y <= maxp.y and
		p.z >= minp.z and p.z <= maxp.z
end

-- Returns amount of mobs and players inside the cuboid
local function get_mobs_inside_cuboid(mobs, pos1, pos2)
	-- Minimum and maximum position in the cuboid
	local minp, maxp = vector.sort(pos1, pos2)

	-- This gets objects outside the cuboid, we will
	-- ignore them later
	local radius = vector.distance(minp, maxp) / 2
	local center = vector.divide(vector.add(minp, maxp), 2)
	local objects = minetest.get_objects_inside_radius(center, radius)

	local players = 0
	local mob_count = {}
	-- Add mobs to the table above
	for mob, _ in pairs(mobs) do
		mob_count[mob] = 0
	end

	-- Count the objects
	for _, object in pairs(objects) do
		local pos = object:get_pos()
		if object:is_player() then
			-- HACK: This is to update arena if a player is somewhere near it.
			local valid_pos_for_player = is_inside_cuboid(
				pos,
				vector.subtract(minp, arena.LAZY_AREA_OFFSET),
				vector.add(maxp, arena.LAZY_AREA_OFFSET)
			)
			players = valid_pos_for_player
				and players + 1
				or  players
		else
			--- @type Entity
			local entity = object
			local name = entity:get_luaentity().name
			if name and mob_count[name] and is_inside_cuboid(pos, minp, maxp) then
				mob_count[name] = mob_count[name] + 1
			end
		end
	end

	return mob_count, players
end

-- Automatically spawns required amount of mobs
function arena.autospawn(arena_def)
	-- Check how many mobs we should spawn
	local actual_mobs, players = get_mobs_inside_cuboid(arena_def.mobs,
		arena_def.pos1, arena_def.pos2)

	-- No players nearby - no mobs spawned
	if players == 0 then
		return
	end

	for mob, needed_amount in pairs(arena_def.mobs) do
		local need_to_spawn = needed_amount - actual_mobs[mob]
		if need_to_spawn > 0 then
			for i=1, need_to_spawn do
				spawn_mob_inside_cuboid(mob, arena_def.pos1, arena_def.pos2)
			end
		end
	end
end

local arena_update_time = 5
local t = 0
minetest.register_globalstep(function(dt)
	t = t + dt
	if t >= arena_update_time then
		t = t - arena_update_time
		for id, arena_def in pairs(state.arenas) do
			arena.autospawn(arena_def)
		end
	end
end)

minetest.register_node("arena:lighting_gas", {
	description = "Lighting gas",
	tiles = {"default_blackout.png"},
	drawtype = "airlike",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	buildable_to = true,
	pointable = false,
	light_source = 14,
	groups = {not_in_creative_inventory=1, dig_immediate=3},
})

------------
-- ARENAS --
------------
arena.add_arena({x=1143, y=-30911, z=-50}, {x=1189, y=-30900, z=-4}, {
	["lottmobs:balrog"] = 10,
})

