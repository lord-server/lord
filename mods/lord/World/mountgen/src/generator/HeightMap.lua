
--- @param size number
--- @return number[][]
local function fill_with_zeroes(size)
	local map = {}
	for i = 1, size do
		map[i] = {}
		for j = 1, size do  map[i][j] = 0  end
	end

	return map
end


--- @class mountgen.generator.HeightMap
local HeightMap = {
	--- @type number
	size = nil,
	--- @type number[][]
	map  = nil,
}

function HeightMap:new(size)
	local class = self
	self = {}

	self.size = size
	self.map  = fill_with_zeroes(size)

	return setmetatable(self, { __index = class })
end

function HeightMap:get_value(z, x)
	local h = self.size
	local w = self.size

	if x < 0 or z < 0 or x > w-1 or z > h-1 then
		return nil
	end

	return self.map[z+1][x+1]
end

function HeightMap:set_value(z, x, val)
	local h = self.size
	local w = self.size

	if x < 0 or z < 0 or x > w-1 or z > h-1 then
		return
	end

	self.map[z+1][x+1] = val
end


return HeightMap
