mountgen.list_chunks = function(skip, count, p1, p2)
	local chunks = {}
	local size = 64

	local fp1 = {
		x = math.floor(p1.x / size) * size,
		y = math.floor(p1.y / size) * size,
		z = math.floor(p1.z / size) *
			size
	}
	local cp2 = { x = math.ceil(p2.x / size) * size, y = math.ceil(p2.y / size) * size, z = math.ceil(p2.z / size) * size }

	local nx = (cp2.x - fp1.x) / size
	local ny = (cp2.y - fp1.y) / size
	local nz = (cp2.z - fp1.z) / size

	local skip_counter = 0
	local add_counter = 0
	local total = nz * ny * nx
	for z = 1, nz do
		for y = 1, ny do
			for x = 1, nx do
				if skip_counter == skip then
					if add_counter < count then
						local lp1 = { x = fp1.x + size * (x - 1), y = fp1.y + size * (y - 1), z = fp1.z + size * (z - 1) }
						local lp2 = { x = lp1.x + size - 1, y = lp1.y + size - 1, z = lp1.z + size - 1 }
						table.insert(chunks, { lp1, lp2 })
						add_counter = add_counter + 1
					end
				else
					skip_counter = skip_counter + 1
				end
			end
		end
	end

	return {
		total = total,
		chunks = chunks,
	}
end

local can_place_dirt = function(data, stone_id)
	if data ~= stone_id then
		return true
	end

	return false
end

local can_place_plant = function(data, air_id)
	if data == air_id then
		return true
	end

	return false
end

mountgen.generate_height_map = function(config, top)
    local method_name = config.METHOD
	top.x = math.floor(top.x + 0.5)
	top.y = math.floor(top.y + 0.5)
	top.z = math.floor(top.z + 0.5)

	if top.y <= config.Y0 then
		minetest.log("Trying to build negative mountain")
		return nil
	end

	local y1 = config.Y0
	local y2 = top.y
	local H = y2 - y1
	local W = math.ceil(2 * H * math.tan(config.ANGLE * 3.141 / 180 / 2)) + 3

	local height_map, width, center
	if method_name == "cone" then
		height_map, width, center = mountgen.cone(W, H)
	elseif method_name == "diamond-square" then
		height_map, width, center = mountgen.diamond_square(W, H,
			config.rk_thr,
			config.rk_small,
			config.rk_big)
	else
		minetest.log("error", "unknown method: " .. tostring(method_name))
		return nil
	end
    return {
        height_map = height_map,
        width = width,
        center = center,
    }
end

local function generate_chunk(config,
							  lp1, lp2,
							  p1, p2,
							  height_map, width)
	local voxel_manip = minetest.get_voxel_manip(lp1, lp2)
    local cp1, cp2 = voxel_manip:read_from_map(lp1, lp2)
	if cp1 ~= nil and cp2 ~= nil then
		local area = VoxelArea:new({ MinEdge = cp1, MaxEdge = cp2 })
		local wx = cp2.x - cp1.x + 1
		local wy = cp2.y - cp1.y + 1
		--	local wz = cp2.z - cp1.z + 1 -- it is unused now

		local dx = lp1.x - cp1.x
		local dz = lp1.z - cp1.z
		local dy = lp1.y - cp1.y

		local offset_x = lp1.x - p1.x
		local offset_y = lp1.y - p1.y
		local offset_z = lp1.z - p1.z

		local underground = true
		local air = true
		for i in area:iterp(lp1, lp2) do
			local local_z = math.floor((i - 1) / (wx * wy)) + 1 - dz
			local local_y = math.floor((i - 1) / wx) % wy + 1 - dy
			local local_x = (i - 1) % wx + 1 - dx

			local global_z = local_z + offset_z
			local global_y = local_y + offset_y
			local global_x = local_x + offset_x

			if global_z >= 1 and global_z <= width and
				global_x >= 1 and global_x <= width and
				global_y >= 1 then
				local height = math.floor(height_map[global_z][global_x] + 0.5)
				if global_y >= height - 1 then
					underground = false
				end
				if global_y <= height + 1 then
					air = false
				end
				if not air and not underground then
					break
				end
			end
		end
		local stone_id = minetest.get_content_id("default:stone")
		local air_id = minetest.get_content_id("air")

		local data = voxel_manip:get_data()
		if air then
			return
		end

		if underground then
			for i in area:iterp(lp1, lp2) do
				data[i] = stone_id
			end
			voxel_manip:set_data(data)
			voxel_manip:write_to_map(true)
			return
		end

		for i in area:iterp(lp1, lp2) do
			local local_z = math.floor((i - 1) / (wx * wy)) + 1 - dz
			local local_y = math.floor((i - 1) / wx) % wy + 1 - dy
			local local_x = (i - 1) % wx + 1 - dx

			local global_z = local_z + offset_z
			local global_y = local_y + offset_y
			local global_x = local_x + offset_x

			if global_z >= 1 and global_z <= width and
				global_x >= 1 and global_x <= width and
				global_y >= 1 then
				local height = math.floor(height_map[global_z][global_x] + 0.5)
				if height > 0 then
					if global_y < height then
						data[i] = stone_id
					elseif global_y == height then
						if can_place_dirt(data[i], stone_id) then
							local top_node = mountgen.top_node({ x = global_x, y = global_y, z = global_z }, config)
							data[i] = minetest.get_content_id(top_node)
						end
					elseif global_y == height + 1 then
						if can_place_plant(data[i], air_id) then
							local upper_node = mountgen.upper_node({ x = global_x, y = global_y, z = global_z },
								config)
							if upper_node ~= nil then
								data[i] = minetest.get_content_id(upper_node)
							end
						end
					end
				end
			end
		end
		voxel_manip:set_data(data)
		voxel_manip:write_to_map(true)
	end
end

mountgen.mountgen = function(top, config, map, completed_chunks)
    local height_map = map.height_map
    local center = map.center
    local width = map.width

    local y1 = config.Y0
	local y2 = top.y

	local p1 = { x = top.x + 1 - center, y = y1, z = top.z + 1 - center }
	local p2 = { x = top.x + width - center, y = y2 + 16, z = top.z + width - center }

	if completed_chunks.ready == nil then
        completed_chunks.ready = false
        completed_chunks.skip = 0
    end

	local max_chunks = 1
	local gen_chunks = mountgen.list_chunks(completed_chunks.skip, max_chunks, p1, p2)
	local total = gen_chunks.total
	local chunks = gen_chunks.chunks

	for _, chunk in ipairs(chunks) do
		local lp1 = chunk[1]
		local lp2 = chunk[2]
		generate_chunk(config, lp1, lp2, p1, p2, height_map, width)
	end
	completed_chunks.skip = completed_chunks.skip + max_chunks
    completed_chunks.ready = completed_chunks.skip == total
    return completed_chunks
end
