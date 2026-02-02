local setmetatable, vector_sort, vector_in_area, v
    = setmetatable, vector.sort, vector.in_area, vector.new

local WallType = require('map.room.wall.Type')


--- @class Voxrame.map.Cuboid
local Cuboid = {
	--- @type PositionVector
	from  = nil, --- @diagnostic disable-line: assign-type-mismatch
	--- @type PositionVector
	to    = nil, --- @diagnostic disable-line: assign-type-mismatch
	--- @type Voxrame.map.room.Walls
	walls = nil, --- @diagnostic disable-line: assign-type-mismatch
}

--- @generic GenericCuboid: Voxrame.map.Cuboid
--- @param child_class GenericCuboid|nil
--- @return GenericCuboid
function Cuboid:extended(child_class)
	return setmetatable(child_class or {}, { __index = self })
end

--- @param from        Position corner where cuboid starts.
--- @param to          Position corner where cuboid ends.
--- @param init_walls? boolean  initialize `.walls` property for use methods like `get_wall()`
--- @return self
function Cuboid:new(from, to, init_walls)
	from, to   = vector_sort(from, to)
	init_walls = init_walls or false

	local class = self
	self = {}
	self.from = from
	self.to   = to
	self = setmetatable(self, { __index = class })

	if init_walls then
		self:init_walls()
	end

	return self --- @diagnostic disable-line: return-type-mismatch
end

--- Determines whether the position is inside the cuboid.  \
--- Sides are inclusive.
--- @param position Position
--- @return boolean
function Cuboid:contains(position)
	return vector_in_area(position, self.from, self.to)
end

--- Returns center position of the cuboid.
--- @return PositionVector
function Cuboid:center()
	return ((self.from + self.to) / 2):floor()
end

--- Returns normalized direction-vector from given position to the center of the cuboid.  \
--- If `length` is specified, the resulting vector is scaled to that length.
--- @param position PositionVector
--- @param length?  number
--- @return vector
function Cuboid:to_center_from(position, length)
	length = length or 1

	return ((self:center() - position):normalize() * length)
end

--- Returns normalized direction-vector from the center of the cuboid to the given position.  \
--- If `length` is specified, the resulting vector is scaled to that length.
--- @param position PositionVector
--- @param length?  number
--- @return vector
function Cuboid:from_center_to(position, length)
	length = length or 1

	return ((position - self:center()):normalize() * length)
end

--- @private
--- @return Voxrame.map.room.Walls
function Cuboid:calc_walls()
	local f = self.from
	local e = self.to

	return {
		west    = Cuboid:new( v(f.x - 1, f.y - 1, f.z - 1), v(f.x - 1, e.y + 1, e.z + 1) ),
		east    = Cuboid:new( v(e.x + 1, f.y - 1, f.z - 1), v(e.x + 1, e.y + 1, e.z + 1) ),
		south   = Cuboid:new( v(f.x - 1, f.y - 1, f.z - 1), v(e.x + 1, e.y + 1, f.z - 1) ),
		north   = Cuboid:new( v(f.x - 1, f.y - 1, e.z + 1), v(e.x + 1, e.y + 1, e.z + 1) ),
		floor   = Cuboid:new( v(f.x - 1, f.y - 1, f.z - 1), v(e.x + 1, f.y - 1, e.z + 1) ),
		ceiling = Cuboid:new( v(f.x - 1, e.y + 1, f.z - 1), v(e.x + 1, e.y + 1, e.z + 1) ),
	}
end

--- @protected
--- @return self
function Cuboid:init_walls()
	self.walls = self:calc_walls()

	return self
end

--- @param name        Voxrame.map.room.wall.Type name of wall.
--- @param inside_room boolean?                   if true, corners will be shifted one node inside the room.
--- @return Voxrame.map.room.Wall
function Cuboid:wall(name, inside_room)
	inside_room = inside_room or false

	self.walls = self.walls or self:calc_walls()

	local wall = self.walls[name]

	if inside_room then
		wall = table.copy_with_metatables(wall)
		wall.from = wall.from + self:to_center_from(wall.from):sign()
		wall.to   = wall.to   + self:to_center_from(wall.to):sign()
	end

	return wall
end

--- Returns corner positions of specified wall.
--- Requires `.walls` property to be initialized (by calling `:init_walls()`).
--- @param name        Voxrame.map.room.wall.Type name of wall.
--- @param inside_room boolean?                   if true, corners will be shifted one node inside the room.
--- @return PositionVector[]
function Cuboid:get_corners_of(name, inside_room)
	inside_room = inside_room or false

	--- @type Voxrame.map.room.Wall
	local wall = self:wall(name, inside_room)
	local from = wall.from
	local to   = wall.to

	local corners = {}
	if name == WallType.floor or name == WallType.ceiling then
		corners = {
			from:copy(),
			v(from.x, from.y, to.z),
			to:copy(),
			v(to.x,   from.y, from.z),
		}
	elseif name == WallType.north or name == WallType.south then
		corners = {
			from:copy(),
			v(to.x, from.y, from.z),
			to:copy(),
			v(from.x, to.y, from.z),
		}
	elseif name == WallType.west or name == WallType.east then
		corners = {
			from:copy(),
			v(from.x, from.y, to.z),
			to:copy(),
			v(from.x, to.y, from.z),
		}
	end

	return corners
end

--- @param wall_type Voxrame.map.room.wall.Type
--- @return PositionVector
function Cuboid:center_of(wall_type)
	return self:wall(wall_type):center()
end

--- @param side Voxrame.map.room.wall.Type
--- @return PositionVector
function Cuboid:floor_center_of(side)
	local position = self:center_of(side)
	position.y = self:floor().from.y + 1

	return position
end

-- -----------------------------------------------------------------

-- #region `:floor()`, `:north()`, ...

--- @
--- @param inside_room boolean?
--- @return Voxrame.map.room.Wall
function Cuboid:floor(inside_room)
	return self:wall(WallType.floor, inside_room)
end

--- @param inside_room boolean?
--- @return Voxrame.map.room.Wall
function Cuboid:ceiling(inside_room)
	return self:wall(WallType.ceiling, inside_room)
end

--- @param inside_room boolean?
--- @return Voxrame.map.room.Wall
function Cuboid:north(inside_room)
	return self:wall(WallType.north, inside_room)
end

--- @param inside_room boolean?
--- @return Voxrame.map.room.Wall
function Cuboid:south(inside_room)
	return self:wall(WallType.south, inside_room)
end

--- @param inside_room boolean?
--- @return Voxrame.map.room.Wall
function Cuboid:east(inside_room)
	return self:wall(WallType.east, inside_room)
end

--- @param inside_room boolean?
--- @return Voxrame.map.room.Wall
function Cuboid:west(inside_room)
	return self:wall(WallType.west, inside_room)
end

-- #endregion


return Cuboid
