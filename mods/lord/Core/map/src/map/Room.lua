local setmetatable, v,          id
    = setmetatable, vector.new, core.get_content_id

local RoomWall = require('map.Room.Wall')
local WallType = require('map.Room.Wall.Type')



local id_air = id('air')

--- @abstract
--- @class Voxrame.map.Room: Voxrame.map.Cuboid
local Room = {
	--- @type vector
	center = nil, --- @diagnostic disable-line: assign-type-mismatch
	--- @type vector
	size   = nil, --- @diagnostic disable-line: assign-type-mismatch
	--- @type Voxrame.map.Room.Walls
	walls  = nil, --- @diagnostic disable-line: assign-type-mismatch
	--- @protected
	--- @type VoxelArea
	area   = nil, --- @diagnostic disable-line: assign-type-mismatch
	--- @protected
	--- @type integer[]
	data   = nil, --- @diagnostic disable-line: assign-type-mismatch
	--- @protected
	--- @type boolean
	debug  = false,
	--- @protected
	--- @static
	--- @type integer
	debug_node_id = 0,

	Wall = RoomWall,
}
core.register_on_mods_loaded(function()
	Room.debug_node_id = Room.debug_node_id ~= 0 -- already set by another mod?
		and Room.debug_node_id
		or (core.registered_nodes['default:stone']
			and id('default:stone')
			or  id_air
		)
end)

--- @static
--- @param node_id integer
--- @return Voxrame.map.Room
function Room.set_debug_node_id(node_id)
	Room.debug_node_id = node_id

	return Room
end

--- @param position vector
--- @param size     vector?
function Room:new(position, size)
	size = size or self.size or v(9, 5, 9)

	local class = self
	self = {}
	self.center = position
	self.size   = size
	self.from   = position - (size/2):ceil():subtract(1)
	self.to     = position + (size/2):floor()

	return setmetatable(self, { __index = class })
end

--- @param debug boolean?
--- @return self
function Room:set_debug(debug)
	self.debug = debug or false

	return self
end

--- @param name        Voxrame.map.Room.Wall.Type name of wall.
--- @param inside_room boolean?                   if true, corners will be shifted one node inside the room.
--- @return Voxrame.map.Room.Wall
function Room:get_wall(name, inside_room)
	inside_room = inside_room or false

	local wall = self.walls[name]

	if inside_room then
		wall = table.copy(wall)
		wall.from = wall.from + self:to_center_from(wall.from):sign()
		wall.to   = wall.to   + self:to_center_from(wall.to):sign()
	end

	return wall
end

--- @param name        Voxrame.map.Room.Wall.Type name of wall.
--- @param inside_room boolean?                   if true, corners will be shifted one node inside the room.
--- @return vector[]
function Room:get_corners_of(name, inside_room)
	inside_room = inside_room or false

	--- @type Voxrame.map.Room.Wall
	local wall = self.walls[name]
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

	if inside_room then
		for index, corner in pairs(corners) do
			local direction = self:to_center_from(corner):sign()
			corners[index] = corner + direction
		end
	end

	return corners
end

--- @param position vector
--- @param length?  number
--- @return vector
function Room:to_center_from(position, length)
	length = length or 1

	return ((self.center - position):normalize() * length)
end

--- @param position vector
--- @param length?  number
--- @return vector
function Room:from_center_to(position, length)
	length = length or 1

	return ((position - self.center):normalize() * length)
end


--- You can override method `:initialize()` for your purposes.
--- It will be called before `:do_generation()` inside `generate()` inside `init()`
--- @protected
--- @return self
function Room:initialize()
	return self
end

--- @protected
--- @return self
function Room:init_walls()
	local s = self.from
	local e = self.to

	self.walls = {
		west    = { from = v(s.x - 1, s.y - 1, s.z - 1),  to = v(s.x - 1, e.y + 1, e.z + 1), },
		east    = { from = v(e.x + 1, s.y - 1, s.z - 1),  to = v(e.x + 1, e.y + 1, e.z + 1), },
		south   = { from = v(s.x - 1, s.y - 1, s.z - 1),  to = v(e.x + 1, e.y + 1, s.z - 1), },
		north   = { from = v(s.x - 1, s.y - 1, e.z + 1),  to = v(e.x + 1, e.y + 1, e.z + 1), },
		floor   = { from = v(s.x - 1, s.y - 1, s.z - 1),  to = v(e.x + 1, s.y - 1, e.z + 1), },
		ceiling = { from = v(s.x - 1, e.y + 1, s.z - 1),  to = v(e.x + 1, e.y + 1, e.z + 1), },
	}

	return self
end

--- @private
--- @return self
function Room:init()
	return self
		:init_walls()
		:initialize()
end

--- @protected
--- @return self
function Room:fill_with_air()
	self.area:fill_with(id_air, self.from, self.to)

	return self
end

--- @protected
--- @return self
function Room:debug_things()
	if not self.debug then
		return self
	end

	local center  = self.center
	local node_id = self.debug_node_id
	self.area
		:set_node_at(center + v(1, 0, 0), node_id)
		:set_node_at(center + v(0, 0, 1), node_id)
		:set_node_at(center - v(1, 0, 0), node_id)
		:set_node_at(center - v(0, 0, 1), node_id)

	return self
end

--- @abstract
--- @protected
--- @return self
function Room:do_generation()
	error('You should override method `:do_generation()` in your child class.')
end

--- @param area VoxelArea
--- @param data integer[]
function Room:generate(area, data)
	self.area = area
	self.data = data

	return self
		:init()
		:fill_with_air()
		:debug_things()
		:do_generation()
end


return Room
