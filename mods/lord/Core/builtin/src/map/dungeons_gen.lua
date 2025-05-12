local pairs, table_insert, vector_new, id
	= pairs, table.insert, vector.new, minetest.get_content_id


local on_generated_is_registered    = false
local on_dungeon_generated_handlers = {}

local c_air = id("air")

--- При генерации комнат данжей движок использует следующие размеры:
---  - Обычные комнаты: 8×8×6 (макс.).
---  - Большие залы: 16×16×16 (редко).
---  - Коридоры: 1×2 блока и длиной до 13.
---
--- При этом бывает так, что соседние комнаты и коридоры пересекаются.
--- Движок не передаёт размеры комнат, только их центры.
---
--- Т.о. при поиске стен "вручную" мы можем наткнуться на то,
--- что стены очень далеко, -- дальше, чем заявлено.
---
--- Кроме того, бывает так, что комната сгенерировалась на стыке с пещерой
--- и тогда стены попросту нет вообще.
---
--- Мы ищем от центра во все стороны, поэтому нам нужна только половина
--- (если пересекутся больше комнат и коридоров, то стены не запишутся)
local MAX_NODES_TO_WALL = math.ceil((8 + 16 + 13) / 2)
--- Центр комнаты движок указывает на полу, тут нам нужна вся высота, а не половина
local MAX_NODES_TO_CEIL = 8 + 16 + 2

--- @class RoomWall
--- @field start_pos vector
--- @field end_pos   vector

--- @class RoomWalls
--- @field north   RoomWall
--- @field south   RoomWall
--- @field east    RoomWall
--- @field west    RoomWall
--- @field floor   RoomWall
--- @field ceiling RoomWall


---@param rc   Position room center
---@param data table
---@param area VoxelArea
local function find_room_walls_positions(rc, data, area)
	local wx_plus, wx_minus, wz_plus, wz_minus
	for delta = 1, MAX_NODES_TO_WALL do
		if wx_plus == nil  and data[area:index(rc.x + delta, rc.y, rc.z)] ~= c_air then wx_plus  = rc.x + delta end
		if wx_minus == nil and data[area:index(rc.x - delta, rc.y, rc.z)] ~= c_air then wx_minus = rc.x - delta end
		if wz_plus == nil  and data[area:index(rc.x, rc.y, rc.z + delta)] ~= c_air then wz_plus  = rc.z + delta end
		if wz_minus == nil and data[area:index(rc.x, rc.y, rc.z - delta)] ~= c_air then wz_minus = rc.z - delta end
	end

	return wx_plus, wx_minus, wz_plus, wz_minus
end

--- @param rc       Position room center
--- @param wx_minus number
--- @param wx_plus  number
--- @param wz_minus number
--- @param wz_plus  number
--- @param data     table
--- @param area     VoxelArea
--- @return number|nil
local function find_room_ceiling_y(rc, wx_minus, wx_plus, wz_minus, wz_plus, data, area)
	for dy = 1, MAX_NODES_TO_CEIL do
		if
			data[area:index(wx_plus  - 1, rc.y + dy,  rc.z        )] ~= c_air or
			data[area:index(wx_minus + 1, rc.y + dy,  rc.z        )] ~= c_air or
			data[area:index(rc.x,         rc.y + dy,  wz_plus  - 1)] ~= c_air or
			data[area:index(rc.x,         rc.y + dy,  wz_minus + 1)] ~= c_air
		then
			return rc.y + dy
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

	local wx_plus, wx_minus, wz_plus, wz_minus = find_room_walls_positions(rc, data, area)
	if wx_plus == nil or wx_minus == nil or wz_plus == nil or wz_minus == nil then
		return {}
	end

	local ceil_y = find_room_ceiling_y(rc, wx_minus, wx_plus, wz_minus, wz_plus, data, area)
	if ceil_y == nil then
		return {}
	end
	local floor_y = rc.y - 1

	local v = vector_new

	return {
		west    = { start_pos = v(wx_minus, floor_y, wz_minus),  end_pos = v(wx_minus, ceil_y,  wz_plus),  },
		east    = { start_pos = v(wx_plus,  floor_y, wz_minus),  end_pos = v(wx_plus,  ceil_y,  wz_plus),  },
		south   = { start_pos = v(wx_minus, floor_y, wz_minus),  end_pos = v(wx_plus,  ceil_y,  wz_minus), },
		north   = { start_pos = v(wx_minus, floor_y, wz_plus),   end_pos = v(wx_plus,  ceil_y,  wz_plus),  },
		floor   = { start_pos = v(wx_minus, floor_y, wz_minus),  end_pos = v(wx_plus,  floor_y, wz_plus),  },
		ceiling = { start_pos = v(wx_minus, ceil_y,  wz_minus),  end_pos = v(wx_plus,  ceil_y,  wz_plus),  },
	}
end

--- @param data table
--- @param area VoxelArea
--- @param rooms_centers Position[]
--- @return RoomWalls[]
local function detect_rooms_walls(data, area, rooms_centers)
	local rooms_walls = {}
	for _, room_center in pairs(rooms_centers) do
		table_insert(rooms_walls, find_room_walls(room_center, data, area))
	end

	return rooms_walls
end

-- luacheck: no max line length
--- @param callback fun(minp:Position, maxp:Position, data:table, param2_data:table, area:VoxelArea, rooms_centers:Position[], rooms_walls:RoomWalls[])
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

		local is_on_mapgen, with_param2 = true, true
		minetest.with_map_part_do(minp, maxp, function(area, data, param2_data)

			local rooms_walls = detect_rooms_walls(data, area, notify.dungeon)

			for _, on_dungeon_generated_handler in pairs(on_dungeon_generated_handlers) do
				on_dungeon_generated_handler(minp, maxp, data, param2_data, area, notify.dungeon, rooms_walls)
			end

		end, is_on_mapgen, with_param2)
	end)
	on_generated_is_registered = true
end
