local math_max, math_sqrt, math_floor
    = math.max, math.sqrt, math.floor


local function fill_with_zeroes(diameter)
	local map = {}
	for i = 1, diameter do
		map[i] = {}
		for j = 1, diameter do  map[i][j] = 0  end
	end

	return map
end

---Generate mountain as cone
---@param diameter number desired width of the mountain
---@param height   number mountain height
---@return table, number, number "height map, map size, center_coordinate"
mountgen.cone = function(diameter, height)
	diameter = math_max(diameter, 1)
	height   = math_max(height, 1)

	local height_map = fill_with_zeroes(diameter)

	local radius = diameter / 2
	local l0     = math_sqrt(radius^2 + radius^2)

	for z = 0, diameter - 1 do
		for x = 0, diameter - 1 do
			local px = x - radius
			local pz = z - radius
			local l  = math_sqrt(px^2 + pz^2)
			local h  = height * (1 - 2 * l / l0)
			mountgen.set_value(height_map, z, x, h)
		end
	end
	return height_map, diameter, math_floor(radius) + 1
end
