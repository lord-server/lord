local v
    = vector.new

local Room = require('map.Room')
local Exit = require('map.room.Exit')
local Side = require('map.room.wall.Type')


--- @class Voxrame.map.Corridor: Voxrame.map.Room
local Corridor = Room:extended()

--- @param size      {width: integer, height: integer} size of corridor's vertical slice.
--- @param length    integer                           corridor's length.
--- @param direction PositionVector                    direction of the corridor. Must be horizontal (y == 0).
--- @return self
function Corridor:new(size, length, direction)
	assert(direction.y == 0, 'Corridor direction must be horizontal')

	local room_size
	if direction.x ~= 0 then
		room_size = v(length, size.height, size.width)
	else
		room_size = v(size.width, size.height, length)
	end

	local corridor = Room.new(self, v(0, 0, 0), room_size)

	-- We need to create exits for easy connection of corridors to rooms
	local start_side, end_side
	if direction.x > 0 then
		start_side, end_side = Side.west, Side.east
	elseif direction.x < 0 then
		start_side, end_side = Side.east, Side.west
	elseif direction.z > 0 then
		start_side, end_side = Side.south, Side.north
	elseif direction.z < 0 then
		start_side, end_side = Side.north, Side.south
	else
		error('Invalid direction for corridor')
	end

	corridor.exits[start_side] = Exit.to(start_side):at(corridor:floor_center_of(start_side)):with_size(size)
	corridor.exits[end_side]   = Exit.to(end_side):at(corridor:floor_center_of(end_side)):with_size(size)

	return corridor
end

--- @protected
--- @return self
function Corridor:do_generation()
	return self
end


return Corridor
