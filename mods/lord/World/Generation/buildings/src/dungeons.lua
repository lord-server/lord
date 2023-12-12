
local dwarf_tomb = require('dungeons.dwarf_tomb')
local walls      = require('dungeons.walls')

minetest.register_on_dungeon_generated(function(minp, maxp, data, param2_data, area, room_centers, rooms_walls)
	dwarf_tomb.on_dungeon_generated(minp, maxp, data, area, room_centers)
	walls.on_dungeon_generated(minp, maxp, data, area, room_centers, rooms_walls)
end)
