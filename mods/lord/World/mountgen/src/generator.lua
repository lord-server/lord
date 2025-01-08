local math_floor, math_ceil, math_tan, table_insert, id
    = math.floor, math.ceil, math.tan, table.insert, minetest.get_content_id

local Node = require('generator.Node')


local stone_id = id('default:stone')
local air_id   = id('air')

mountgen.list_chunks = function(p1, p2)
	local chunks = {}
	local size = 64

	local fp1 = {
		x = math_floor(p1.x / size) * size,
		y = math_floor(p1.y / size) * size,
		z = math_floor(p1.z / size) * size,
	}
	local cp2 = {
		x = math_ceil(p2.x / size) * size,
		y = math_ceil(p2.y / size) * size,
		z = math_ceil(p2.z / size) * size,
	}

	local nx = (cp2.x - fp1.x) / size
	local ny = (cp2.y - fp1.y) / size
	local nz = (cp2.z - fp1.z) / size

	for z = 1, nz do
		for y = 1, ny do
			for x = 1, nx do
				local lp1 = { x = fp1.x + size * (x - 1), y = fp1.y + size * (y - 1), z = fp1.z + size * (z - 1) }
				local lp2 = { x = lp1.x + size - 1, y = lp1.y + size - 1, z = lp1.z + size - 1 }
				table_insert(chunks, { lp1, lp2 })
			end
		end
	end

	return chunks
end

local can_place_dirt = function(data)
	if data ~= stone_id then
		return true
	end

	return false
end

local can_place_plant = function(data)
	if data == air_id then
		return true
	end

	return false
end

mountgen.mountgen = function(top, config)
	local method_name = config.METHOD
	top.x = math_floor(top.x + 0.5)
	top.y = math_floor(top.y + 0.5)
	top.z = math_floor(top.z + 0.5)

	if top.y <= config.Y0 then
		minetest.log('Trying to build negative mountain')
		return
	end

	--- @type mountgen.generator.HeightMap
	local height_map, width, center
	if method_name == 'cone' then

		height_map, width, center = mountgen.cone(top, config)

	elseif method_name == 'diamond-square' then

		local H = top.y - config.Y0
		local W = math_ceil(2 * H * math_tan(math.rad(90 - config.ANGLE))) + 3
		height_map, width, center = mountgen.diamond_square(W, H,
			config.rk_thr,
			config.rk_small,
			config.rk_big)

	else
		minetest.log('error', 'unknown method: ' .. tostring(method_name))
		return
	end

	local p1 = { x = top.x + 1 - center, y = config.Y0, z = top.z + 1 - center }
	local p2 = { x = top.x + width - center, y = top.y + 16, z = top.z + width - center }

	local chunks = mountgen.list_chunks(p1, p2)
	local voxel_manip = minetest.get_voxel_manip(p1, p2)

	for _, chunk in ipairs(chunks) do
		local lp1 = chunk[1]
		local lp2 = chunk[2]

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

			local data = voxel_manip:get_data()
			for i in area:iterp(p1, p2) do
				local local_z = math_floor((i - 1) / (wx * wy)) + 1 - dz
				local local_y = math_floor((i - 1) / wx) % wy + 1 - dy
				local local_x = (i - 1) % wx + 1 - dx

				local global_z = local_z + offset_z
				local global_y = local_y + offset_y
				local global_x = local_x + offset_x

				if global_z >= 1 and global_z <= width and
					global_x >= 1 and global_x <= width and
					global_y >= 1 then
					local height = math_floor(height_map.map[global_z][global_x] + 0.5)
					if height > 0 then
						if global_y < height then
							data[i] = Node.get_rock({ x = global_x, y = global_y, z = global_z }, config)
						elseif global_y == height then
							if can_place_dirt(data[i], stone_id) then
								data[i] = Node.get_coverage({ x = global_x, y = global_y, z = global_z }, config)
							end
						elseif global_y == height + 1 then
							if can_place_plant(data[i], air_id) then
								local plant_node_id = Node.get_plant({ x = global_x, y = global_y, z = global_z }, config)
								if plant_node_id ~= nil then
									data[i] = plant_node_id
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
end
