local v
    = vector.new

local Room = require('map.Room')
local Exit = require('map.room.Exit')
local Side = require('map.room.wall.Type')


--- @class Voxrame.map.Corridor: Voxrame.map.Room
local Corridor = Room:extended()

--- @param size      {width: integer, height: integer} size of corridor's vertical slice.
--- @param length    integer                           corridor's length.
--- @param direction PositionVector|WorldSide|Voxrame.map.room.wall.Type direction of the corridor. Must be horizontal.
--- @return self
function Corridor:new(size, length, direction)
	--- @type Voxrame.map.room.wall.Type
	local direction_side
	if type(direction) ~= 'string' then       --- @cast direction PositionVector
		assert(direction.y == 0, 'Corridor direction must be horizontal')
		direction_side = Side.of(direction)
	else                                      --- @cast direction WorldSide
		assert(direction--[[@as string]]:is_one_of(Side.horizontal()))
		direction_side = direction
	end

	local room_size
	if direction_side == Side.east or direction_side == Side.west then
		room_size = v(length, size.height, size.width)
	else
		room_size = v(size.width, size.height, length)
	end

	local corridor = Room.new(self, v(0, 0, 0), room_size)

	-- We need to create exits for easy connection of corridors to rooms
	local start_side, end_side
	end_side   = direction_side
	start_side = Side.opposite_for(end_side)

	corridor.exits[start_side] = Exit.to(start_side):at(corridor:floor_center_of(start_side)):with_size(size)
	corridor.exits[end_side]   = Exit.to(end_side  ):at(corridor:floor_center_of(end_side  )):with_size(size)

	return corridor
end

--- @protected
--- @return self
function Corridor:do_generation()
	return self
end


return Corridor
