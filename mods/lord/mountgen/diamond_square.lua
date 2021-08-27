local function cut_peak(map, z, x)
	local v1 = mountgen.get_value(map, z-1, x)
	local v2 = mountgen.get_value(map, z+1, x)
	local v3 = mountgen.get_value(map, z, x-1)
	local v4 = mountgen.get_value(map, z, x+1)
	mountgen.set_value(map, z, x, (v1+v2+v3+v4)/4)
end

mountgen.diamond_square = function(W, H, config)
	local n = math.ceil(math.log(W) / math.log(2))
	local r = math.pow(2, n-1)
	local w = 2*r + 1

	local map = {}
	for i = 1, w do
		map[i] = {}
		for j = 1, w do
			map[i][j] = 0
		end
	end

	local i = n
	while i >= 1 do
		local step = math.pow(2, i)
		local step2 = math.pow(2, i-1)

		local num = math.pow(2, n-i)
		local rk = RAND_K

		local rand

		if i < config.rk_thr then
			rk = config.rk_small
		else
			rk = config.rk_big
		end

		-- diamond
		if i < n then
			local z = 0
			for _ = 1, num do
				local x = 0
				for _ = 1, num do
					local val1 = mountgen.get_value(map, z, x)
					local val2 = mountgen.get_value(map, z+step, x)
					local val3 = mountgen.get_value(map, z, x+step)
					local val4 = mountgen.get_value(map, z+step, x+step)
					rand = math.random(-step2/rk, step2/rk)
					local val = (val1 + val2 + val3 + val4)/4 + rand
					mountgen.set_value(map, z+step2, x+step2, val)
					x = x + step
				end
				z = z + step
			end
		else
			mountgen.set_value(map, step2, step2, H)
		end

		-- square
		local z = 0
		for _ = 1, num+1 do
			local x = 0
			for _ = 1, num+1 do
				local val1, val2, val3, val4
				local val

				rand = math.random(-step2/rk, step2/rk)
				val1 = mountgen.get_value(map, z-step2, x+step2)
				val2 = mountgen.get_value(map, z+step2, x+step2)
				val3 = mountgen.get_value(map, z, x)
				val4 = mountgen.get_value(map, z, x+step)
				val = (val1 + val2 + val3 + val4)/4 + rand
				mountgen.set_value(map, z, x+step2, val)

				rand = math.random(-step2/rk, step2/rk)
				val1 = mountgen.get_value(map, z+step2, x-step2)
				val2 = mountgen.get_value(map, z+step2, x+step2)
				val3 = mountgen.get_value(map, z, x)
				val4 = mountgen.get_value(map, z+step, x)
				val = (val1 + val2 + val3 + val4)/4 + rand
				mountgen.set_value(map, z+step2, x, val)

				x = x + step
			end
			z = z + step
		end

		i = i - 1
	end

	cut_peak(map, r, r)

	return map, w, r+1
end

