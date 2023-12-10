
local dwarf_tomb = require('dungeons.dwarf_tomb')


minetest.register_on_dungeon_generated(function(minp, maxp, data, area, room_centers)
	dwarf_tomb.on_dungeon_generated(minp, maxp, data, area, room_centers)
end)
