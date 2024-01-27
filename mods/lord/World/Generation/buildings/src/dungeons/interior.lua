local pairs, math_random, table_is_empty, vector_new, id
	= pairs, math.random, table.is_empty, vector.new, minetest.get_content_id

local INTERIOR_CHANCE       = 3

local c_air    = id("air")
local c_ignore = id("ignore")

local c_bed_bottom          = id("beds:bed_bottom")
local c_bed_top             = id("beds:bed_top")
local c_dwarf_chest_spawner = id("lottmapgen:dwarf_chest_spawner")
local c_torch               = id("default:torch_wall")

--- @param data table     map data taken from `VoxelManip:get_data()`
--- @param area VoxelArea map data indexer
--- @param ...  Position  all args after `area` must be `Position`s
local function is_air(data, area, ...)
	for _, value in pairs({...}) do
		local index = type(value) == "table" and area:indexp(value) or value
		local node_id = data[index]
		if node_id ~= c_air and node_id ~= c_ignore then
			return false
		end
	end
	return true
end

--- @private
--- @class dungeons.Interior
local Interior = {
	--- @type table map data (linear array) with nodes IDs taken from `VoxelManip:get_data()`
	data        = nil,
	--- @type table map data (linear array) with nodes `param2` values taken from `VoxelManip:get_param2_data()`
	param2_data = nil,
	--- @type VoxelArea map data indexer for positioning in `data` linear array
	area        = nil,
}

--- Constructor
---
--- @param data        table     map data (linear array) with nodes IDs taken from `VoxelManip:get_data()`
--- @param param2_data table     map data (linear array) with nodes `param2` values \
---                              taken from `VoxelManip:get_param2_data()`
--- @param area        VoxelArea map data indexer for positioning in `data` linear array
--- @return dungeons.Interior
function Interior:new(data, param2_data, area)
	self = setmetatable({}, { __index = self })

	self.data        = data
	self.param2_data = param2_data
	self.area        = area

	return self
end

--- @param x      number
--- @param y      number
--- @param z      number
--- @param param2 number
function Interior:place_torch_if_possible(x, y, z, param2)
	local torch_pos_index = self.area:index(x, y, z)
	local current_node_id = self.data[torch_pos_index]
	if current_node_id == c_air or current_node_id == c_ignore then
		self.data       [torch_pos_index] = c_torch
		self.param2_data[torch_pos_index] = param2
	end
end

--- @param wall   RoomWall
--- @param corner string   one of {"left"|"right"}
function Interior:place_north_wall_bad_and_chest(wall, corner)
	local sign = corner == "left" and 1 or -1
	local corner_pos = corner == "left"
		and wall.start_pos
		or  vector_new(wall.end_pos.x, wall.start_pos.y, wall.start_pos.z)

	local bed_top_pos    = corner_pos:add(vector_new(sign * 1, 1, -1))
	local bed_bottom_pos = corner_pos:add(vector_new(sign * 1, 1, -2))
	local chest_pos      = corner_pos:add(vector_new(sign * 2, 1, -1))

	if is_air(self.data, self.area, bed_top_pos, bed_bottom_pos, chest_pos) then
		self.data[self.area:indexp(bed_top_pos)]    = c_bed_top
		self.data[self.area:indexp(bed_bottom_pos)] = c_bed_bottom
		self.data[self.area:indexp(chest_pos)]      = c_dwarf_chest_spawner
	end
end

--- @param wall RoomWall
function Interior:place_north_wall_torches(wall)
	local s, e = wall.start_pos, wall.end_pos
	self:place_torch_if_possible(s.x + 1, e.y - 1, s.z - 1, 4)
	self:place_torch_if_possible(e.x - 1, e.y - 1, e.z - 1, 4)
end

--- @param wall RoomWall
function Interior:place_south_wall_torches(wall)
	local s_pos, e_pos = wall.start_pos, wall.end_pos
	self:place_torch_if_possible(s_pos.x + 1, e_pos.y - 1, s_pos.z + 1, 5)
	self:place_torch_if_possible(e_pos.x - 1, e_pos.y - 1, e_pos.z + 1, 5)
end

--- @param room_walls  RoomWalls list of room walls
function Interior:place_room_interior(room_walls)
	local north_wall = room_walls.north
	local south_wall = room_walls.south

	self:place_north_wall_bad_and_chest(north_wall, "left")
	self:place_north_wall_bad_and_chest(north_wall, "right")

	self:place_north_wall_torches(north_wall)
	self:place_south_wall_torches(south_wall)
end

--- @param rooms_centers Position[]
--- @param rooms_walls   RoomWalls[]
function Interior:generate(rooms_centers, rooms_walls)
	for i, room_center in pairs(rooms_centers) do
		if (math_random(INTERIOR_CHANCE) == 1 and not table_is_empty(rooms_walls[i])) then
			self:place_room_interior(rooms_walls[i])
		end
	end
end


return {
	on_dungeon_generated = function(minp, maxp, data, param2_data, area, rooms_centers, rooms_walls)
		Interior:new(data, param2_data, area):generate(rooms_centers, rooms_walls)
	end
}
