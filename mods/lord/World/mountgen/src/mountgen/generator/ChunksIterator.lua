local math_floor, math_ceil, table_insert
	= math.floor, math.ceil, table.insert


--- Collect chunks positions, that are in the area between p1 and p2
--- @param p1 Position
--- @param p2 Position
--- @return Position[][]
local function list_chunks(p1, p2)
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


--- @class mountgen.generator.ChunksIterator
local ChunksIterator = {}

--- @static
--- @param p1 Position
--- @param p2 Position
--- @param callback fun(data:number[],index:number,pos:Position)
function ChunksIterator.foreach_pos_in(p1, p2, callback)
	local chunks = list_chunks(p1, p2)
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

				callback(data, i, { x = global_x, y = global_y, z = global_z })
			end
			voxel_manip:set_data(data)
			voxel_manip:write_to_map(true)
		end
	end
end


return ChunksIterator
