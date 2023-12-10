local pairs, table_insert, id
	= pairs, table.insert, minetest.get_content_id


local on_generated_is_registered    = false
local on_dungeon_generated_handlers = {}

local c_air = id("air")


--- @class RoomWall
--- @field start_pos Position
--- @field end_pos   Position

--- @class RoomWalls
--- @field north   RoomWall
--- @field south   RoomWall
--- @field east    RoomWall
--- @field west    RoomWall
--- @field floor   RoomWall
--- @field ceiling RoomWall

--- @param rc       Position room center
--- @param wx_minus number
--- @param wx_plus  number
--- @param wz_minus number
--- @param wz_plus  number
--- @param data     table
--- @param area     VoxelArea
--- @return number|nil
local function find_room_high_y(rc, wx_minus, wx_plus, wz_minus, wz_plus, data, area)
	for dy = 1, 16 do
		if
			data[area:index(wx_plus  - 1, rc.y + dy,  rc.z        )] ~= c_air or
			data[area:index(wx_minus + 1, rc.y + dy,  rc.z        )] ~= c_air or
			data[area:index(rc.x,         rc.y + dy,  wz_plus  - 1)] ~= c_air or
			data[area:index(rc.x,         rc.y + dy,  wz_minus + 1)] ~= c_air
		then
			return rc.y + dy - 1
		end
	end

	return nil
end

--- @param room_center Position[]
--- @param data table
--- @param area VoxelArea
--- @return RoomWalls|RoomWall[]|table
local function find_room_walls(room_center, data, area)
	local rc = room_center
	local wx_plus, wx_minus, wz_plus, wz_minus
	for delta = 1, 8 do
		if wx_plus == nil  and data[area:index(rc.x + delta, rc.y, rc.z)] ~= c_air then wx_plus  = rc.x + delta end
		if wx_minus == nil and data[area:index(rc.x - delta, rc.y, rc.z)] ~= c_air then wx_minus = rc.x - delta end
		if wz_plus == nil  and data[area:index(rc.x, rc.y, rc.z + delta)] ~= c_air then wz_plus  = rc.z + delta end
		if wz_minus == nil and data[area:index(rc.x, rc.y, rc.z - delta)] ~= c_air then wz_minus = rc.z - delta end
	end
	if wx_plus == nil or wx_minus == nil or wz_plus == nil or wz_minus == nil then
		return {}
	end

	local high_y = find_room_high_y(rc, wx_minus, wx_plus, wz_minus, wz_plus, data, area)
	if high_y == nil then
		return {}
	end

	return {
		west    = {
			start_pos = { x = wx_minus, y = rc.y, z = wz_minus },
			end_pos   = { x = wx_minus, y = high_y, z = wz_plus },
		},
		east    = {
			start_pos = { x = wx_plus, y = rc.y, z = wz_minus },
			end_pos   = { x = wx_plus, y = high_y, z = wz_plus },
		},
		south   = {
			start_pos = { x = wx_minus, y = rc.y, z = wz_minus },
			end_pos   = { x = wx_plus, y = high_y, z = wz_minus },
		},
		north   = {
			start_pos = { x = wx_minus, y = rc.y, z = wz_plus },
			end_pos   = { x = wx_plus, y = high_y, z = wz_plus },
		},
		floor   = {
			start_pos = { x = wx_minus, y = rc.y - 1, z = wz_minus },
			end_pos   = { x = wx_plus, y = rc.y - 1, z = wz_plus },
		},
		ceiling = {
			start_pos = { x = wx_minus, y = high_y + 1, z = wz_minus },
			end_pos   = { x = wx_plus, y = high_y + 1, z = wz_plus },
		},
	}
end

--- @param data table
--- @param area VoxelArea
--- @param room_centers Position[]
--- @return RoomWalls[]
local function detect_rooms_walls(data, area, room_centers)
	local rooms_walls = {}
	for _, room_center in pairs(room_centers) do
		table_insert(rooms_walls, find_room_walls(room_center, data, area))
	end

	return rooms_walls
end

-- luacheck: no max line length
--- @param callback fun(minp:Position, maxp:Position, data:table, area:VoxelArea, room_centers:Position[], rooms_walls:RoomWall[][])
minetest.register_on_dungeon_generated = function(callback)
	table_insert(on_dungeon_generated_handlers, callback)

	if on_generated_is_registered then
		return
	end

	minetest.set_gen_notify("dungeon")
	minetest.register_on_generated(function(minp, maxp, seed)
		local notify = minetest.get_mapgen_object("gennotify")
		if not notify or not notify.dungeon then
			return
		end

		local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
		local area           = VoxelArea:new({ MinEdge = emin, MaxEdge = emax })
		local data           = vm:get_data()

		local rooms_walls = detect_rooms_walls(data, area, notify.dungeon)

		for _, on_dungeon_generated_handler in pairs(on_dungeon_generated_handlers) do
			on_dungeon_generated_handler(minp, maxp, data, area, notify.dungeon, rooms_walls)
		end

		vm:set_data(data)
		vm:calc_lighting()
		vm:write_to_map()
	end)
	on_generated_is_registered = true
end
