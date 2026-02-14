local type, v
    = type, vector.new

local WallType = require('map.room.wall.Type')
local Cuboid   = require('map.Cuboid')


--- @class Voxrame.map.room.Exit: Voxrame.map.room.Connector
local Exit = {
	--- Direction from room to outside (normalized).
	--- @type vector
	direction = nil, --- @diagnostic disable-line: assign-type-mismatch
	--- Voxrame.map.Cuboid Exit frame coordinates.  \
	--- If only `frame.to` is set, its used to store size.
	--- @type Voxrame.map.Cuboid
	frame     = nil, --- @diagnostic disable-line: assign-type-mismatch
}


--- @protected
--- @param direction vector
--- @return self
function Exit:new(direction)
	self = setmetatable({}, { __index = self })
	self.direction  = direction
	-- here we create fake cuboid, it will be set later in `at()` & `with_size()` methods
	self.frame      = Cuboid:new(v(0, 0, 0), v(0, 0, 0))
	self.frame.from = nil
	self.frame.to   = nil

	return self
end

--- Sets exit direction to specified wall side or vector.
--- If `side` is a vector, it is normalized and used as `.direction` property.
--- If `side` is a wall type, the `.direction` sets to vector to a corresponding wall.
---
--- @static
--- @param side Voxrame.map.room.wall.Type|vector
--- @return self
function Exit.to(side)
	--- @type vector
	local direction

	if type(side) ~= 'string' then
		--- @cast side vector
		direction = side:normalize()

		return Exit:new(direction)
	end

	--- @cast side string
	assert(side:is_one_of(WallType))
	local directions = {
		[WallType.north]   = v( 0,  0,  1),
		[WallType.south]   = v( 0,  0, -1),
		[WallType.east]    = v( 1,  0,  0),
		[WallType.west]    = v(-1,  0,  0),
		[WallType.floor]   = v( 0, -1,  0),
		[WallType.ceiling] = v( 0,  1,  0),
	}
	direction = directions[side] or v(0, 0, 0)

	return Exit:new(direction)
end

--- Configures exit position and calculates exit `.frame` coordinates.
--- * If exit size was not set before, default size (1x2) is used.
--- * If called multiple times, exit is repositioned to new `position` keeping its size.
--- @param position PositionVector position of the exit (bottom center of the exit frame).
--- @return self
function Exit:at(position)

	--- @type IntegerVector
	local size = self.frame.to
		and (self.frame.from -- both `from` and `to` are set
			-- here we assume that this is already a "repositioning" of the exit to a new `position`
			and self.frame.to - self.frame.from + v(1, 1, 1)
			-- here size is stored in `to` because `from` was not set yet
			-- and `with_size()` was called before `at()`, so we use it as size
			or  self.frame.to
		)
		-- default size if neither `from` nor `to` were set
		or  v(1, 2, 1)

	self.frame.from   = position - (size / 2):floor()
	self.frame.from.y = position.y
	self.frame.to     = self.frame.from + size - v(1, 1, 1)

	return self
end

--- @param width  number
--- @param height number
--- @return self
function Exit:with_size(width, height)
	--- @type IntegerVector
	local size

	if self.direction.x ~= 0 then
		size = v(1, height, width)
	elseif self.direction.y ~= 0 then
		size = v(width, 1, height)
	else
		size = v(width, height, 1)
	end

	if not self.frame.from then
		-- here size is stores in `to` because `from` was not set yet,
		-- and `at()` was not called yet
		self.frame.to = size
	else
		-- keeping exit's bottom center position
		local position_y = self.frame.from.y
		local center = ((self.frame.from + self.frame.to) / 2):floor()
		self.frame.from   = center - (size / 2):floor()
		self.frame.from.y = position_y

		self.frame.to = self.frame.from + size - v(1, 1, 1)
	end

	return self
end

--- @param delta integer
function Exit:shift(delta)
	self.frame:move(delta * self.direction:cross(v(0, 1, 0)))

	return self
end


return Exit
