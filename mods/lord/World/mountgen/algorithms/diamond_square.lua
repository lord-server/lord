---smooth map at (x,z)
---@param map table height map
---@param z integer z coordinate
---@param x integer x coordinate
local function smooth(map, z, x)
	local v1 = mountgen.get_value(map, z-1, x)
	local v2 = mountgen.get_value(map, z+1, x)
	local v3 = mountgen.get_value(map, z, x-1)
	local v4 = mountgen.get_value(map, z, x+1)
	mountgen.set_value(map, z, x, (v1+v2+v3+v4)/4)
end

---Random value from -max_value to max_value
---@param max_value any
local function adjust_random(max_value)
    return (2*math.random()-1)*max_value
end

---Average of 4 values. Ignore nils
---@param v1 any
---@param v2 any
---@param v3 any
---@param v4 any
local function average(v1, v2, v3, v4)
    local cnt = 0
    local sum = 0
    if v1 ~= nil then
        sum = sum + v1
        cnt = cnt + 1
    end
    if v2 ~= nil then
        sum = sum + v2
        cnt = cnt + 1
    end
    if v3 ~= nil then
        sum = sum + v3
        cnt = cnt + 1
    end
    if v4 ~= nil then
        sum = sum + v4
        cnt = cnt + 1
    end
    if cnt == 0 then
        return 0
    end
    return sum / cnt
end

---Generate mountain with diamond-square algorithm
---@param map_w integer desired width of the mountain
---@param mountain_h integer height of the mountain
---@param rk_thr integer for scales greater than this, use rk_big
---@param rk_small integer smoothness coefficient for small scales
---@param rk_big integer smoothness coefficient for big scales
---@return table, integer, integer "height map, map size, center coordinate"
mountgen.diamond_square = function(map_w, mountain_h, rk_thr, rk_small, rk_big)
    W = math.max(map_w, 3)
    H = math.max(mountain_h, 1)

	local n = math.ceil(math.log(W) / math.log(2))
	n = math.max(n, 1)
	local r = 2 ^ (n-1)
	local w = 2*r + 1

	local map = {}
	for i = 1, w do
		map[i] = {}
		for j = 1, w do
			map[i][j] = 0
		end
	end

    -- run diamond square
	local i = n
	while i >= 1 do
		local step = 2 ^ i
		local step2 = 2 ^ (i-1)

		local num = 2 ^ (n-i)

		local rk

		if i < rk_thr then
			rk = rk_small
		else
			rk = rk_big
		end

		-- diamond
		if i <= n-2 then
			local z = 0
			for _ = 1, num do
				local x = 0
				for _ = 1, num do
					local val1 = mountgen.get_value(map, z, x)
					local val2 = mountgen.get_value(map, z+step, x)
					local val3 = mountgen.get_value(map, z, x+step)
					local val4 = mountgen.get_value(map, z+step, x+step)
					local rand = adjust_random(step2/rk)
					local val = average(val1, val2, val3, val4) + rand
					mountgen.set_value(map, z+step2, x+step2, val)
					x = x + step
				end
				z = z + step
			end
        else
            -- set central peak and corners
			mountgen.set_value(map, 2^(n-1), 2^(n-1), H)
            mountgen.set_value(map, 1, 1, 0)
            mountgen.set_value(map, 1, 2^n, 0)
            mountgen.set_value(map, 2^n, 1, 0)
            mountgen.set_value(map, 2^n, 2^n, 0)
		end

		-- square
		local z = 0
		for _ = 1, num+1 do
			local x = 0
			for _ = 1, num+1 do
				local val1, val2, val3, val4
				local val
				local rand

                rand = adjust_random(step2/rk)
				val1 = mountgen.get_value(map, z-step2, x+step2)
				val2 = mountgen.get_value(map, z+step2, x+step2)
				val3 = mountgen.get_value(map, z, x)
				val4 = mountgen.get_value(map, z, x+step)
                val = average(val1, val2, val3, val4) + rand
				mountgen.set_value(map, z, x+step2, val)

                rand = adjust_random(step2/rk)
				val1 = mountgen.get_value(map, z+step2, x-step2)
				val2 = mountgen.get_value(map, z+step2, x+step2)
				val3 = mountgen.get_value(map, z, x)
				val4 = mountgen.get_value(map, z+step, x)
                val = average(val1, val2, val3, val4) + rand
				mountgen.set_value(map, z+step2, x, val)

				x = x + step
			end
			z = z + step
		end

		i = i - 1
	end
	smooth(map, r, r)
	return map, w, r+1
end
