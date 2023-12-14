local pairs, id
	= pairs, minetest.get_content_id

local c_air          = id("air")
local c_mossy_cobble = id("default:mossycobble")
local c_gold         = id("default:goldblock")
local c_tomb_legs    = id("lottblocks:dwarf_tomb_bottom")
local c_tomb_head    = id("lottblocks:dwarf_tomb_top")

local TOMB_Y_MIN = -500
local TOMB_Y_MAX = -250
local TOMB       = {
	MIN_ROOMS = 6, -- ~ 45%                - minimal count of rooms in dungeon, where the tomb can be spawned
	CHANCE    = 2, -- ~ 45% / 2 == ~ 22%   - of all dungeons in layer y=[-250,-500]
	-- Info: By default (perlin noise in config) there is not so much dungeons.
	--       In addition it's very difficult to find them.
	--       So ~ 22% - its very very rarely.
}

--- @param x number
--- @param y number
--- @param z number
--- @param data table
--- @param area VoxelArea
local function place_tomb(x, y, z, data, area)
	data[area:index(x, y + 1, z)]     = c_tomb_legs
	data[area:index(x, y + 1, z + 1)] = c_tomb_head

	data[area:index(x, y, z)]         = c_mossy_cobble
	data[area:index(x, y, z + 1)]     = c_mossy_cobble

	for dz = -1, 2 do
		data[area:index(x + 1, y, z + dz)] = c_gold
		data[area:index(x - 1, y, z + dz)] = c_gold
	end
	data[area:index(x, y, z + 2)] = c_gold
	data[area:index(x, y, z - 1)] = c_gold
end

--- @param room_center Position
--- @param data table
--- @param area VoxelArea
--- @return boolean
local function is_enough_space(room_center, data, area)
	for dy = 0, 1 do  -- needs two layers: 1 - for gold & cobble, 2 - for tomb
		for dx = -1, 1 do  -- width 3: 1 on right, 1 on left (for gold)
			for dz = -1, 2 do  -- tomb takes 2 blocks, & additional 1 on each side (head/legs)
				if data[area:index(room_center.x + dx, room_center.y + dy, room_center.z + dz)] ~= c_air then
					return false
				end
			end
		end
	end

	return true
end

--- @param rooms_centers Position[]
--- @param data table
--- @param area VoxelArea
--- @return Position|nil
local function find_room_with_space(rooms_centers, data, area)
	for _, room_center in pairs(rooms_centers) do
		if is_enough_space(room_center, data, area) then
			return room_center
		end
	end

	return nil
end

return {
	--- @param minp Position
	--- @param maxp Position
	--- @param data table
	--- @param area VoxelArea
	--- @param rooms_centers Position[]
	on_dungeon_generated = function(minp, maxp, data, area, rooms_centers)
		if maxp.y < TOMB_Y_MIN or minp.y > TOMB_Y_MAX then
			return
		end

		if #rooms_centers >= TOMB.MIN_ROOMS and math.random(TOMB.CHANCE) == 1 then
			local place_to = find_room_with_space(rooms_centers, data, area)
			if place_to then
				place_tomb(place_to.x, place_to.y, place_to.z, data, area)
			end
		end
	end
}
