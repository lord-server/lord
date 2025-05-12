local dwarf_tomb = require('dungeons.dwarf_tomb')
local walls      = require('dungeons.walls')
local interior   = require('dungeons.interior')
local remains    = require('dungeons.remains')


minetest.register_on_dungeon_generated(function(minp, maxp, data, param2_data, area, rooms_centers, rooms_walls)
	local tomb_room_index = dwarf_tomb.on_dungeon_generated(minp, maxp, data, area, rooms_centers)
	walls.on_dungeon_generated(minp, maxp, data, area, rooms_centers, rooms_walls)
	interior.on_dungeon_generated(minp, maxp, data, param2_data, area, rooms_centers, rooms_walls)
	remains.on_dungeon_generated(minp, maxp, data, param2_data, area, rooms_centers, rooms_walls, tomb_room_index)
end)
