
local dwarf_tomb = require('dungeons.dwarf_tomb')
local walls      = require('dungeons.walls')

minetest.register_on_dungeon_generated(function(minp, maxp, data, param2_data, area, rooms_centers, rooms_walls)
	dwarf_tomb.on_dungeon_generated(minp, maxp, data, area, rooms_centers)
	walls.on_dungeon_generated(minp, maxp, data, area, rooms_centers, rooms_walls)
end)
