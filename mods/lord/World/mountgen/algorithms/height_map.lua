mountgen.get_value = function(map, z, x)
	local h = #(map)
	local w = #(map[1])

	if x <= 0 or z <= 0 or x >= w-1 or z >= h-1 then
		return nil
	end

	return map[z+1][x+1]
end

mountgen.set_value = function(map, z, x, val)
	local h = #(map)
	local w = #(map[1])
	if x <= 0 or z <= 0 or x >= w-1 or z >= h-1 then
		return
	end
	map[z+1][x+1] = val
end

