

local on_generated_is_registered    = false
local on_dungeon_generated_handlers = {}

--- @param callback fun(minp:Position, maxp:Position, data:table, area:VoxelArea, room_centers:Position[])
minetest.register_on_dungeon_generated = function(callback)
	table.insert(on_dungeon_generated_handlers, callback)

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

		for _, on_dungeon_generated_handler in pairs(on_dungeon_generated_handlers) do
			on_dungeon_generated_handler(minp, maxp, data, area, notify.dungeon)
		end

		vm:set_data(data)
		vm:calc_lighting()
		vm:write_to_map()
	end)
	on_generated_is_registered = true
end
