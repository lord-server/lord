local pairs, math_random, table_is_empty, vector_new, id
	= pairs, math.random, table.is_empty, vector.new, minetest.get_content_id

local INTERIOR_CHANCE = 3
local INTERIOR_Y_MAX  = -50

local id_air    = id("air")
local id_ignore = id("ignore")

local id_bed_bottom          = id("beds:bed_bottom")
local id_bed_top             = id("beds:bed_top")
local id_dwarf_chest_spawner = id("lottmapgen:dwarf_chest_spawner")
local id_bookshelf           = id("default:bookshelf")
local id_fence               = id("default:fence_wood")
local id_hatch               = id("lord_wooden_stuff:hatch_alder")
local id_chair               = id("lord_wooden_stuff:chair_alder")
local id_brewer_barrel       = id("lottpotion:brewer")
local id_torch               = id("default:torch_wall")

--- @param data table     map data taken from `VoxelManip:get_data()`
--- @param area VoxelArea map data indexer
--- @param ...  Position  all args after `area` must be `Position`s
local function is_air(data, area, ...)
	for _, value in pairs({...}) do
		local index = type(value) == "table" and area:indexp(value) or value
		local node_id = data[index]
		if node_id ~= id_air and node_id ~= id_ignore then
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
	if current_node_id == id_air or current_node_id == id_ignore then
		self.data       [torch_pos_index] = id_torch
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
		self.data[self.area:indexp(bed_top_pos)]    = id_bed_top
		self.data[self.area:indexp(bed_bottom_pos)] = id_bed_bottom
		self.data[self.area:indexp(chest_pos)]      = id_dwarf_chest_spawner
	end
end

--- @param wall RoomWall
function Interior:place_north_wall_shelves(wall)
	local wall_length = (wall.end_pos.x - 1) - (wall.start_pos.x + 1)
	if wall_length < 3 then
		return
	end

	local from_x, to_x
	if wall_length < 7 then
		from_x = wall.start_pos.x + 2
		to_x   = wall.end_pos.x - 2
	else
		from_x = math.floor(wall.start_pos.x+1 + (wall_length/2) - 2)
		to_x   = math.ceil (wall.start_pos.x+1 + (wall_length/2) + 2)
	end

	for x = from_x, to_x do
		local shelf_pos  = vector_new(x, wall.start_pos.y + 3, wall.start_pos.z)
		local data_index = self.area:indexp(shelf_pos)
		if not is_air(self.data, self.area, data_index) then
			self.data[data_index] = id_bookshelf
		end
	end
end

--- @param wall   RoomWall
--- @param corner string   one of {"left"|"right"}
function Interior:place_south_wall_barrels(wall, corner)
	local sign = corner == "left" and 1 or -1
	--- @type vector
	local corner_pos = corner == "left"
		and wall.start_pos
		or  vector_new(wall.end_pos.x, wall.start_pos.y, wall.start_pos.z)

	local barrels_pos = {
		corner_pos:add(vector_new(sign * 1, 1, 1)),
		corner_pos:add(vector_new(sign * 2, 1, 1)),
		corner_pos:add(vector_new(sign * 1, 2, 1)),
		corner_pos:add(vector_new(sign * 1, 1, 2)),
	}

	for i = 1, #barrels_pos do
		if is_air(self.data, self.area, barrels_pos[i]) then
			self.data[self.area:indexp(barrels_pos[i])] = id_brewer_barrel
		end
	end
end

--- @param side string   one of {"west"|"east"}
--- @param wall RoomWall
function Interior:place_diner_zone(side, wall)
	local sign = side == "west" and 1 or -1
	local wall_z_center = wall.start_pos.z + math.floor((wall.end_pos.z - wall.start_pos.z) / 2)
	local wall_center_bottom_pos = vector_new(wall.start_pos.x, wall.start_pos.y, wall_z_center)

	local table_leg_pos = wall_center_bottom_pos:add(vector_new(sign * 1, 1, 0))
	local table_top_pos = wall_center_bottom_pos:add(vector_new(sign * 1, 2, 0))
	if is_air(self.data, self.area, table_leg_pos, table_top_pos) then
		self.data[self.area:indexp(table_leg_pos)] = id_fence
		self.data[self.area:indexp(table_top_pos)] = id_hatch
	end

	local chair1_pos = wall_center_bottom_pos:add(vector_new(sign * 1, 1, -1))
	local chair2_pos = wall_center_bottom_pos:add(vector_new(sign * 1, 1, 1))
	if is_air(self.data, self.area, chair1_pos) then
		local pos_index = self.area:indexp(chair1_pos)
		self.data       [pos_index] = id_chair
		self.param2_data[pos_index] = 2 -- chair back turned to south
	end
	if is_air(self.data, self.area, chair2_pos) then
		local pos_index = self.area:indexp(chair2_pos)
		self.data       [pos_index] = id_chair
		self.param2_data[pos_index] = 0 -- chair back turned to north
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
--- @param room_center Position
function Interior:place_room_interior(room_walls, room_center)
	local north_wall = room_walls.north
	local south_wall = room_walls.south
	local west_wall  = room_walls.west
	local east_wall  = room_walls.east

	self:place_north_wall_bad_and_chest(north_wall, "left")
	self:place_north_wall_bad_and_chest(north_wall, "right")

	self:place_north_wall_shelves(north_wall)
	self:place_south_wall_barrels(south_wall, "left")
	self:place_south_wall_barrels(south_wall, "right")

	self:place_diner_zone("west", west_wall)
	self:place_diner_zone("east", east_wall)

	self:place_north_wall_torches(north_wall)
	self:place_south_wall_torches(south_wall)

	minetest.add_entity(room_center, "lottmobs:dead_men")
end

--- @param rooms_centers Position[]
--- @param rooms_walls   RoomWalls[]
function Interior:generate(rooms_centers, rooms_walls)
	for i, room_center in pairs(rooms_centers) do
		if (math_random(INTERIOR_CHANCE) == 1 and not table_is_empty(rooms_walls[i])) then
			self:place_room_interior(rooms_walls[i], room_center)
		end
	end
end


return {
	on_dungeon_generated = function(minp, maxp, data, param2_data, area, rooms_centers, rooms_walls)
		if maxp.y > INTERIOR_Y_MAX then
			return
		end
		Interior:new(data, param2_data, area):generate(rooms_centers, rooms_walls)
	end
}
