local pairs, math_random, table_is_empty, id
    = pairs, math.random, table.is_empty, minetest.get_content_id


local REMAINS_Y_MAX = -100
local REMAINS_CHANCE = 100/60 -- 60%

local FIND_FREE_PLACE_ATTEMPTS = 10

local id_air      = id('air')
local ids_remains = {
	id('remains:ancient_miner_mapgen_1'),
	id('remains:ancient_miner_mapgen_2'),
}

--- @private
--- @class dungeons.Remains
local Remains = {
	--- @type table map data (linear array) with nodes IDs taken from `VoxelManip:get_data()`
	data        = nil,
	--- @type table map data (linear array) with nodes `param2` values taken from `VoxelManip:get_param2_data()`
	param2_data = nil,
	--- @type VoxelArea map data indexer for positioning in `data` or `param2_data` linear arrays
	area        = nil,
}

--- Constructor
---
--- @param data        table     map data (linear array) with nodes IDs taken from `VoxelManip:get_data()`
--- @param param2_data table     map data (linear array) with nodes `param2` values \
---                              taken from `VoxelManip:get_param2_data()`
--- @param area        VoxelArea map data indexer for positioning in `data` or `param2_data` linear arrays
--- @return dungeons.Remains
function Remains:new(data, param2_data, area)
	self = setmetatable({}, { __index = self })

	self.data        = data
	self.param2_data = param2_data
	self.area        = area

	return self
end

--- @param room_floor RoomWall
--- @return number|nil
function Remains:find_free_place_index(room_floor)
	local floor_y = room_floor.start_pos.y

	local attempt = 0
	while attempt < FIND_FREE_PLACE_ATTEMPTS do
		local rnd_x = math_random(room_floor.start_pos.x + 1, room_floor.end_pos.x - 1)
		local rnd_z = math_random(room_floor.start_pos.z + 1, room_floor.end_pos.z - 1)

		local index = self.area:index(rnd_x, floor_y + 1, rnd_z)

		if self.data[index] == id_air then
			return index
		end

		attempt = attempt + 1
	end
end

--- @param room_floor  RoomWall
--- @param room_center Position
function Remains:place_remains(room_floor, room_center)
	local index = self:find_free_place_index(room_floor)
	if not index then  return  end

	self.data[index]        = ids_remains[math_random(#ids_remains)]
	self.param2_data[index] = math_random(0, 3)
end

--- @param rooms_centers Position[]
--- @param rooms_walls   RoomWalls[]
function Remains:generate(rooms_centers, rooms_walls)
	for i, room_center in pairs(rooms_centers) do
		if (math_random(REMAINS_CHANCE) == 1 and not table_is_empty(rooms_walls[i])) then
			self:place_remains(rooms_walls[i].floor, room_center)
		end
	end
end


return {
	--- @param min_pos       Position
	--- @param max_pos       Position
	--- @param data          table
	--- @param param2_data   table
	--- @param area          VoxelArea
	--- @param rooms_centers Position[]
	--- @param rooms_walls   RoomWalls[]
	on_dungeon_generated = function(min_pos, max_pos, data, param2_data, area, rooms_centers, rooms_walls)
		if max_pos.y > REMAINS_Y_MAX then
			return
		end

		Remains:new(data, param2_data, area):generate(rooms_centers, rooms_walls)
	end
}
