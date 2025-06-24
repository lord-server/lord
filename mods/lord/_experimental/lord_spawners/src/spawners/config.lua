
--- @class spawners.Config
local config = {
	max_obj_per_mapblock = tonumber(minetest.settings:get('max_objects_per_block')),
	enable_particles     = minetest.settings:get_bool('enable_particles'),
	tick_max             = 30,
	tick_short_max       = 20,

	racial               = { 'dwarf', 'elf', 'orc', 'hobbit' } -- without humans as for now. TODO when races refactored
}


return config
