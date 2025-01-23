local math_max, math_ceil, math_tan, math_log, math_random
	= math.max, math.ceil, math.tan, math.log, math.random

local HeightMap = require('mountgen.generator.HeightMap')
local FieldType = require('mountgen.config.FieldType')

local S = minetest.get_mod_translator()


local smooth_filter = {
	{ 0, 1, 1, 1, 0 },
	{ 1, 1, 1, 1, 1 },
	{ 1, 1, 1, 1, 1 },
	{ 1, 1, 1, 1, 1 },
	{ 0, 1, 1, 1, 0 }
}

---smooth map at (x,z)
---@param map mountgen.generator.HeightMap height map
---@param z number z coordinate
---@param x number x coordinate
local function smooth(map, z, x)
	local sum = 0
	local cnt = 0
	for i = 1, 5 do
		for j = 1, 5 do
			local val = map:get_value(z - 3 + i, x - 3 + j)
			if val ~= nil then
				cnt = cnt + smooth_filter[i][j]
				sum = sum + val * smooth_filter[i][j]
			end
		end
	end
	if cnt == 0 then
		return
	end
	map:set_value(z, x, sum / cnt)
end

---Random value from -max_value to max_value
---@param max_value any
local function adjust_random(max_value)
	return (2 * math_random() - 1) * max_value
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

--- @class mountgen.algorithm.DiamondSquare.ConfigValues: mountgen.config.ValuesTable
--- @field rk_big   number smooth on the big scales
--- @field rk_small number smooth on the small scales
--- @field rk_thr   number big & small scale boundary

--- @alias mountgen.DiamondSquareCfgValues mountgen.algorithm.DiamondSquare.ConfigValues

--- @class mountgen.algorithm.DiamondSquare: mountgen.AlgorithmInterface
local DiamondSquare = {
	NAME = 'diamond-square',
	--- @private
	--- @const
	--- @type mountgen.config.FieldDefinition[]
	CONFIG_FIELDS = {
		rk_big = {
			name        = 'rk_big',
			type        = FieldType.NUMBER,
			label       = S('Big scale smooth'),
			description = S('Smooth on the big scales of whole mountain.\n(smooth of diamonds)'),
		},
		rk_small = {
			name        = 'rk_small',
			type        = FieldType.NUMBER,
			label       = S('Small scale smooth'),
			description = S('Smooth on the small scales of sibling nodes.\n(smooth of square)'),
		},
		rk_thr = {
			name        = 'rk_thr',
			type        = FieldType.NUMBER,
			label       = S('Big & small scale boundary'),
			description = S('For scales greater than this, use `Big-scale-smooth`, otherwise `Small-scale-smooth`'),
		},
	},
	--- @private
	--- @const
	--- @type table
	CONFIG_DEFAULTS = {
		--- @type number
		rk_big = 5,
		--- @type number
		rk_small = 100,
		--- @type number
		rk_thr = 5,
	}
}

--- @return string
function DiamondSquare.get_description()
	return
		S('The `DiamondSquare` algorithm is well suited on a large scale for building high mountains.') .. ' ' ..
		S('Be careful, it can freeze serverI.') .. '\n' ..
		S('More info:') .. ' https://ru.wikipedia.org/wiki/Алгоритм_Diamond-Square'
end

--- @return mountgen.config.FieldDefinition[]
function DiamondSquare.get_config_fields()
	return DiamondSquare.CONFIG_FIELDS
end

--- @return table
function DiamondSquare.get_config_defaults()
	return DiamondSquare.CONFIG_DEFAULTS
end

--- Generate mountain with diamond-square algorithm
--- @param top    Position
--- @param config mountgen.algorithm.DiamondSquare.ConfigValues
--- @return mountgen.generator.HeightMap, number, number "height map, map size, center coordinate"
function DiamondSquare.build_height_map(top, config)
	local H = top.y - config.foot_height
	local W = math_ceil(2 * H * math_tan(math.rad(90 - config.angle))) + 3
	local rk_big   = config.rk_big
	local rk_small = config.rk_small
	local rk_thr   = config.rk_thr

	W = math_max(W, 3)
	H = math_max(H, 1)

	local n = math_ceil(math_log(W) / math_log(2))

	n = math_max(n, 1)
	local r = 2 ^ (n - 1)
	local w = 2 * r + 1
	local height_map = HeightMap:new(w)

	-- set central peak and corners
	height_map:set_value(r, r, H)
	height_map:set_value(0, 0, -H / 2)
	height_map:set_value(0, w - 1, -H / 2)
	height_map:set_value(w - 1, 0, -H / 2)
	height_map:set_value(w - 1, w - 1, -H / 2)

	-- run diamond square
	local i = n
	while i >= 1 do
		local step = 2 ^ i
		local step2 = 2 ^ (i - 1)

		local num = 2 ^ (n - i)
		local rk
		if i < rk_thr then
			rk = rk_small
		else
			rk = rk_big
		end

		-- we have already did first pseudo-diamond step when created a peak
		if i ~= n then
			-- diamond
			local z = 0
			for _ = 1, num do
				local x = 0
				for _ = 1, num do
					local val1 = height_map:get_value(z, x)
					local val2 = height_map:get_value(z + step, x)
					local val3 = height_map:get_value(z, x + step)
					local val4 = height_map:get_value(z + step, x + step)
					local rand = adjust_random(step2 / rk)
					local val = average(val1, val2, val3, val4) + rand
					height_map:set_value(z + step2, x + step2, val)
					x = x + step
				end
				z = z + step
			end
		end
		-- square
		local z = 0
		for _ = 1, num + 1 do
			local x = 0
			for _ = 1, num + 1 do
				local val1, val2, val3, val4
				local val
				local rand

				rand = adjust_random(step2 / rk)
				val1 = height_map:get_value(z - step2, x + step2)
				val2 = height_map:get_value(z + step2, x + step2)
				val3 = height_map:get_value(z, x)
				val4 = height_map:get_value(z, x + step)
				val = average(val1, val2, val3, val4) + rand
				height_map:set_value(z, x + step2, val)

				rand = adjust_random(step2 / rk)
				val1 = height_map:get_value(z + step2, x - step2)
				val2 = height_map:get_value(z + step2, x + step2)
				val3 = height_map:get_value(z, x)
				val4 = height_map:get_value(z + step, x)
				val = average(val1, val2, val3, val4) + rand
				height_map:set_value(z + step2, x, val)

				x = x + step
			end
			z = z + step
		end

		i = i - 1
	end
	smooth(height_map, r, r)

	return height_map, w, r + 1
end


return DiamondSquare
