local setmetatable, v,          id
    = setmetatable, vector.new, core.get_content_id

local Cuboid   = require('map.Cuboid')
local Exit     = require('map.room.Exit')
local WallType = require('map.room.wall.Type')


local id_air = id('air')

local parent = Cuboid
--- @abstract
--- @class Voxrame.map.Room: Voxrame.map.Cuboid, Voxrame.map.room.Connectable
local Room = {
	--- @readonly
	--- @type IntegerVector
	size         = nil, --- @diagnostic disable-line: assign-type-mismatch
	--- @protected
	--- @type IntegerVector
	size_max     = nil, --- @diagnostic disable-line: assign-type-mismatch
	--- @protected
	--- @type table<'_all'|Voxrame.map.room.wall.Type, integer[]>
	wall_blocks  = nil, --- @diagnostic disable-line: assign-type-mismatch
	--- @type table<Voxrame.map.room.wall.Type, Voxrame.map.room.Exit>
	exits        = nil, --- @diagnostic disable-line: assign-type-mismatch
	--- @protected
	--- @type VoxelArea
	area         = nil, --- @diagnostic disable-line: assign-type-mismatch
	--- @protected
	--- @type integer[]
	data         = nil, --- @diagnostic disable-line: assign-type-mismatch
	--- @protected
	--- @type boolean
	debug        = false,
	--- @protected
	--- @static
	--- @type integer
	debug_node_id = 0,
	--- @protected
	--- @static
	--- @type helpers.Logger
	logger        = core.get_mod_logger(),
}
parent:extended(Room)

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

--- @param position PositionVector
--- @param size     IntegerVector?
--- @return self
function Room:new(position, size)
	size = size or self.size or v(9, 5, 9)
	if self.size_max then
		size = size:apply(math.min, self.size_max)
	end

	local class = self
	self = {}
	self.size   = size --- @diagnostic disable-line: read-only
	self.from   = position - (size/2):ceil():subtract(1)
	self.to     = position + (size/2):floor()
	self.exits  = {}

	return setmetatable(self, { __index = class })
end

--- @param debug boolean?
--- @return self
function Room:set_debug(debug)
	self.debug = debug or false

	return self
end

--- You can override method `:initialize()` for your purposes.
--- It will be called before `:do_generation()` inside `generate()` inside `init()`
--- @protected
--- @return self
function Room:initialize()
	return self
end

--- @private
--- @return self
function Room:init()
	return self
		:init_walls()
		:initialize()
end

--- Calls specified `method` on room and all its exits.
--- @protected
--- @param method string
--- @param ... any
--- @return self
function Room:apply(method, ...)
	parent[method](self, ...)
	for _, exit in pairs(self.exits) do
		exit.frame[method](exit.frame, ...)
	end

	return self
end

--- Moves coordinates of room and all its exits by offset.  \
--- Use before `generate()` to set room position.
--- Be sure that exits already initialized.
--- @param offset PositionVector
--- @return self
function Room:move(offset)
	return self:apply('move', offset)
end

--- Moves coordinates of room and all its exits to `position`.  \
--- Use before `generate()` to set room position.
--- Be sure that exits already initialized.
--- @param position PositionVector
--- @return self
function Room:move_at(position)
	return self:apply('move_at', position)
end

--- Moves coordinates of room and all its exits to side with `delta`.  \
--- Use before `generate()` to set room position.
--- Be sure that exits already initialized.
--- @param side  Voxrame.map.room.wall.Type
--- @param delta integer?
--- @return self
function Room:move_to(side, delta)
	return self:apply('move_to', side, delta)
end

--- @protected
--- @return self
function Room:fill_with_air()
	self.area:fill_with(id_air, self.from, self.to)

	return self
end

--- @protected
--- @return self
function Room:fill_walls()
	if not self.wall_blocks then
		return self
	end

	local area = self.area
	for name, wall in pairs(self.walls) do
		local nodes_ids = self.wall_blocks[name] or self.wall_blocks['_all']
		area:fill_with(nodes_ids, wall.from, wall.to)
	end

	return self
end

--- @param connector Voxrame.map.room.Connector
--- @return self
function Room:connect_to(connector)
	local direction = connector:get_direction()
	assert(direction.y == 0, 'Direction of connector must be horizontal')

	local connector_side = WallType.of(direction)
	if not connector_side then
		self.logger.error(
			'Cannot connect Room: Invalid connector side `%s` of direction `%s`',
			dump(connector_side), dump(direction)
		)

		return self
	end
	local my_exit_side = WallType.opposite_for(connector_side)
	if not my_exit_side then
		self.logger.error(
			'Cannot connect Room: cannot find opposite side of connector side `%s`',
			dump(connector_side)
		)

		return self
	end

	if not self.exits[my_exit_side] then
		local position = self:floor_center_of(my_exit_side)
		self.exits[my_exit_side] = Exit.to(my_exit_side):at(position):with_size(3, 4)
	end
	local room_exit = self.exits[my_exit_side]

	-- Выход из присоединяемой комнаты может быть не в центре стены
	-- Нам нужно выровнять комнату относительно расположения выхода на этой стене
	local exit_offset_from_center = room_exit:floor_center() - self:floor_center_of(my_exit_side)
	local alignment_offset = self.size:multiply(direction) / 2
	alignment_offset = alignment_offset - exit_offset_from_center
	alignment_offset.y = self.size.y / 2

	self:move(connector:floor_center() + alignment_offset)

	self.from, self.to = vector.sort(self.from, self.to)

	return self
end

--- @protected
--- @return self
function Room:debug_things()
	if not self.debug then
		return self
	end

	local center  = self:center()
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
--- @return self
function Room:generate(area, data)
	self.area = area
	self.data = data

	return self
		:init()
		:fill_with_air()
		:fill_walls()
		:debug_things()
		:do_generation()
end


return Room
