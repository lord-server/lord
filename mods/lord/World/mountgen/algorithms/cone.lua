---Generate mountain as cone
---@param map_w integer desired width of the mountain
---@param mountain_h integer mountain height
---@return table, integer, integer "height map, map size, center_coordinate"
mountgen.cone = function(map_w, mountain_h)
	local map = {}

	local W = math.max(map_w, 1)
	local H = math.max(mountain_h, 1)

	for i = 1, W do
		map[i] = {}
		for j = 1, W do
			map[i][j] = 0
		end
	end

	local l0 = math.sqrt(W/2*W/2 + W/2*W/2)

	for z = 0,W-1 do
	for x = 0,W-1 do
		local px = x - W/2
		local pz = z - W/2
		local l = math.sqrt(px*px+pz*pz)
		local h = H*(1-l/l0*2)
		mountgen.set_value(map, z, x, h)
	end
	end
	return map, W, math.floor(W/2)+1
end
