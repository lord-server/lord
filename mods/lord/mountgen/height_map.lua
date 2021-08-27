mountgen.get_value = function(map, z, x)
	local h = table.getn(map)
	local w = table.getn(map[1])

	if x < 0 or z < 0 or x >= w or z >= h then
	       	return 0
	end

	return map[z+1][x+1]
end

mountgen.set_value = function(map, z, x, val)
	local h = table.getn(map)
	local w = table.getn(map[1])
	print(x, z, w, h)
	if x < 0 or z < 0 or x >= w or z >= h then
		return
	end
	map[z+1][x+1] = val
end

