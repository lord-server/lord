local pairs, math_random, id
	= pairs, math.random, minetest.get_content_id


local id_air = id('air')

local ids_side_wall_blocks = {
	id('default:cobble'),
	id('default:mossycobble'),
	id('default:stone'),
	id('default:stonebrick'),
	id('default:stonebrick'),
}
local ids_wall_blocks      = {
	north = ids_side_wall_blocks,
	south = ids_side_wall_blocks,
	west  = ids_side_wall_blocks,
	east  = ids_side_wall_blocks,
	floor = {
		id('default:cobble'),
		id('default:mossycobble'),
		id('default:mossycobble'),
		id('default:stonebrick'),
	},
	ceiling = {
		id('default:cobble'),
		id('default:mossycobble'),
		id('default:stone'),
		id('default:stonebrick'),
	},
}

--- @param wall_type string    one of 'north', 'south', 'west', 'east', 'floor', 'ceiling'
--- @param data      table
--- @param area      VoxelArea
local function fill_wall(wall_type, start_pos, end_pos, data, area)
	local wall_blocks = ids_wall_blocks[wall_type]
	for x = start_pos.x, end_pos.x do
		for y = start_pos.y, end_pos.y do
			for z = start_pos.z, end_pos.z do
				if (data[area:index(x, y, z)] ~= id_air) then
					data[area:index(x, y, z)] = wall_blocks[math_random(#wall_blocks)]
				end
			end
		end
	end
end

return {
	--- @param minp          Position
	--- @param maxp          Position
	--- @param data          table
	--- @param area          VoxelArea
	--- @param rooms_centers Position[]
	--- @param room_walls    RoomWalls[]
	on_dungeon_generated = function(minp, maxp, data, area, rooms_centers, rooms_walls)
		for i, room_center in pairs(rooms_centers) do
			for wall_type, wall in pairs(rooms_walls[i]) do
				fill_wall(wall_type, wall.start_pos, wall.end_pos, data, area)
			end
		end
	end
}
