
--- @class Voxrame.map.Cuboid
--- @field public from PositionVector
--- @field public to   PositionVector
local Cuboid = {}

-- TODO:
-- also needed to create cuboids by `Cuboid:new`, and fix creation of child classes

-- --- @param from Position
-- --- @param to   Position
-- --- @return self
-- function Cuboid:new(from, to)
-- 	from, to = vector.sort(from, to)

-- 	local class = self
-- 	self = {}
-- 	self.from = from
-- 	self.to   = to

-- 	return setmetatable(self, { __index = class })
-- end

-- --- @param position Position
-- --- @return boolean
-- function Cuboid:contains(position)
-- 	return vector.in_area(position, self.from, self.to)
-- end


return Cuboid
