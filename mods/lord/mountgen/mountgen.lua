mountgen.list_chunks = function(p1, p2)
	local chunks = {}
	local size = 64

	local fp1 = {x=math.floor(p1.x/size)*size, y=math.floor(p1.y/size)*size, z=math.floor(p1.z/size)*size}
	local cp2 = {x=math.ceil(p2.x/size)*size,  y=math.ceil(p2.y/size)*size,  z=math.ceil(p2.z/size)*size}

	local nx = (cp2.x - fp1.x)/size
	local ny = (cp2.y - fp1.y)/size
	local nz = (cp2.z - fp1.z)/size

	for z=1,nz do
	for y=1,ny do
	for x=1,nx do
		local lp1 = {x=fp1.x + size*(x-1), y=fp1.y + size*(y-1), z=fp1.z + size*(z-1)}
		local lp2 = {x=lp1.x + size-1, y=lp1.y + size-1, z=lp1.z + size-1}
		table.insert(chunks, {lp1, lp2})
	end
	end
	end

	return chunks
end

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

	local height_map = {}
	for z = 1,w do
		height_map[z] = {}
		for x = 1,w do
			local height_main = main_map[z][x]
			local height_top  = head_map[z][x]+(coneH - head_coneH)-coneH*config.TOP_H
			local height = math.floor(math.min(height_main, height_top)+yb+0.5)

			height_map[z][x] = height
		end
	end


	local p1 = {x = top.x + 1 - center, y=y1, z = top.z + 1 - center}
	local p2 = {x = top.x + w - center, y=y2+16, z = top.z + w - center}

	local chunks = mountgen.list_chunks(p1, p2)

	for id,chunk in ipairs(chunks) do
		local lp1 = chunk[1]
		local lp2 = chunk[2]

		local voxel_manip = minetest.get_voxel_manip()
		local cp1, cp2 = voxel_manip:read_from_map(lp1, lp2)
		local area = VoxelArea:new({MinEdge=cp1, MaxEdge=cp2})

		local wx = cp2.x - cp1.x + 1
		local wy = cp2.y - cp1.y + 1
	--	local wz = cp2.z - cp1.z + 1 -- it is unused now

		local dx = lp1.x - cp1.x
		local dz = lp1.z - cp1.z
		local dy = lp1.y - cp1.y

		local offset_x = lp1.x - p1.x
		local offset_y = lp1.y - p1.y
		local offset_z = lp1.z - p1.z

		local stone_id = minetest.get_content_id("default:stone")
		local air_id = minetest.get_content_id("air")

		local data = voxel_manip:get_data()
		for i in area:iterp(p1, p2) do
			local local_z = math.floor((i-1) / (wx*wy)) + 1 - dz
			local local_y = math.floor((i-1) / wx) % wy + 1 - dy
			local local_x = (i-1) % wx + 1 - dx

			local global_z = local_z + offset_z
			local global_y = local_y + offset_y
			local global_x = local_x + offset_x

			if global_z >= 1 and global_z <= w and
			   global_x >= 1 and global_x <= w and
			   global_y >= 1 then
				local height = height_map[global_z][global_x]

				if global_y < height then
					data[i] = stone_id
				elseif global_y == height then
					if data[i] == air_id then
						local top_node = mountgen.top_node({x=global_x,y=global_y,z=global_z}, config)
						data[i] = minetest.get_content_id(top_node)
					end
				elseif global_y == height + 1 then
					if data[i] == air_id then
						local upper_node = mountgen.upper_node({x=global_x,y=global_y,z=global_z}, config)
						if upper_node ~= nil then
							data[i] = minetest.get_content_id(upper_node)
						end
					end
				end
			end
	        end
		voxel_manip:set_data(data)
		voxel_manip:write_to_map()
	end
end
