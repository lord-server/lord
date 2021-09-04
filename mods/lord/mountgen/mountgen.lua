mountgen.mountgen = function(top, fun, config)
	top.x = math.floor(top.x+0.5)
	top.y = math.floor(top.y+0.5)
	top.z = math.floor(top.z+0.5)

	if top.y <= config.Y0 then
		minetest.log("Trying to build negative mountain")
		return
	end

	local y1 = config.Y0
	local y2 = top.y
	local H = y2 - y1
	local coneH = (H * 1.4)/(1-config.TOP_H)
	local yb = H*(1-1.4)
	local W = math.ceil(2*coneH*math.tan(config.ANGLE*3.141/180/2))+3

	local main_map, w, center = fun(W, coneH, config)
	local head_coneH = (w/2)/math.tan(config.HEAD_ANGLE*3.141/180/2)
	local head_map, _, _ = fun(W, head_coneH, config)

	local p1 = {x = top.x + 1 - center, y=y1, z = top.z + 1 - center}
	local p2 = {x = top.x + w - center, y=y2+16, z = top.z + w - center}

	local voxel_manip = minetest.get_voxel_manip()
	local cp1, cp2 = voxel_manip:read_from_map(p1, p2)
	local area = VoxelArea:new({MinEdge=cp1, MaxEdge=cp2})

	local wx = cp2.x - cp1.x + 1
	local wy = cp2.y - cp1.y + 1
	local wz = cp2.z - cp1.z + 1

	local dx = p1.x - cp1.x
	local dz = p1.z - cp1.z
	local dy = y1 - cp1.y

	local stone_id = minetest.get_content_id("default:stone")
	local air_id = minetest.get_content_id("air")

	local data = voxel_manip:get_data()
	for i in area:iterp(p1, p2) do
		local z = math.floor((i-1) / (wx*wy)) + 1 - dz
		local y = math.floor((i-1) / wx) % wy + 1 - dy
		local x = (i-1) % wx + 1 - dx

		local height_main = main_map[z][x]
		local height_top  = head_map[z][x]+(coneH - head_coneH)-coneH*config.TOP_H
		local height = math.floor(math.min(height_main, height_top)+yb+0.5)

		if y < height then
			data[i] = stone_id
		elseif y == height then
			if data[i] == air_id then
				local top = mountgen.top_node({x=x,y=y,z=z}, config)
				data[i] = minetest.get_content_id(top)
			end
		elseif y == height + 1 then
			if data[i] == air_id then
				local upper = mountgen.upper_node({x=x,y=y,z=z}, config)
				if upper ~= nil then
					data[i] = minetest.get_content_id(upper)
				end
			end
		end
        end
	voxel_manip:set_data(data)
	voxel_manip:write_to_map()
end

