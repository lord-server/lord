
--- @param pos1         Position  min position of loaded part of map.
--- @param pos2         Position  max position of loaded part of map.
--- @param callback     fun(area:VoxelArea,data:table,param2_data:table,light_data:table)
--- @param is_on_mapgen boolean   this function is called inside "on_generated()" callbacks.
--- @param with_param2  boolean   also load param2 data & pass in specified `callback()` function as `param2_data` arg..
--- @param with_light   boolean   also load light data & pass in specified `callback()` function as `light_data` arg..
function minetest.with_map_part_do(pos1, pos2, callback, is_on_mapgen, with_param2, with_light)
	is_on_mapgen = is_on_mapgen or false
	--- @type VoxelManip
	local voxel_manipulator
	local e_min, e_max
	if is_on_mapgen then
		voxel_manipulator, e_min, e_max = minetest.get_mapgen_object("voxelmanip")
	else
		voxel_manipulator = minetest.get_voxel_manip({ pos1, pos2 })
		e_min, e_max      = voxel_manipulator:read_from_map(pos1, pos2)
	end

	local area = VoxelArea:new({ MinEdge = e_min, MaxEdge = e_max })

	local data, param2_data, light_data
	data = voxel_manipulator:get_data()
	if with_param2 then   param2_data = voxel_manipulator:get_param2_data()  end
	if with_light  then   light_data  = voxel_manipulator:get_light_data()   end


	callback(area, data, param2_data, light_data)


	voxel_manipulator:set_data(data)
	if with_param2 then   voxel_manipulator:set_param2_data(param2_data)  end
	if with_light  then   voxel_manipulator:set_light_data(light_data)    end
	voxel_manipulator:set_lighting({ day =0, night =0})
	voxel_manipulator:calc_lighting()
	voxel_manipulator:write_to_map(data)
end
