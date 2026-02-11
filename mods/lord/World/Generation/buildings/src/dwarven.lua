local dwarf_tomb = require('dwarven.dwarf_tomb')
local walls      = require('dwarven.walls')
local interior   = require('dwarven.interior')
local remains    = require('dwarven.remains')


minetest.register_on_dungeon_generated(function(minp, maxp, data, param2_data, area, rooms_centers, rooms_walls)
	local tomb_room_index = dwarf_tomb.on_dungeon_generated(minp, maxp, data, area, rooms_centers)
	walls.on_dungeon_generated(minp, maxp, data, area, rooms_centers, rooms_walls)
	interior.on_dungeon_generated(minp, maxp, data, param2_data, area, rooms_centers, rooms_walls)
	remains.on_dungeon_generated(minp, maxp, data, param2_data, area, rooms_centers, rooms_walls, tomb_room_index)
end)
