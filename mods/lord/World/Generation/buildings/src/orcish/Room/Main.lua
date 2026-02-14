local pairs, math_random, v,          id
    = pairs, math.random, vector.new, minetest.get_content_id

local Room     = Voxrame.map.Room
local Exit     = Voxrame.map.room.Exit
local WallType = Voxrame.map.room.wall.Type


local id_air         = id('air')
local id_lava        = id('default:lava_source')
local id_barrel      = id('barrel:barrel')
local id_orc_torch   = id('torches:orc_wall')
local id_modor_stone = id('lord_rocks:mordor_stone')
local id_remains     = id('remains:ancient_miner_1')
local id_bone_1      = id('bones:bone_1')

local ids_wall_nodes = {
	id('lord_bricks:mordor_clay_brick'),
	id('lord_bricks:mordor_clay_masonry'),
	id('lord_bricks:mordor_clay_masonry_large'),
}

--- @class buildings.OrcishCave.Room.Main: Voxrame.map.Room
local Main = {
	--- @type IntegerVector
	size = v(19, 7, 15),
	--- @private
	--- @type table<'_all'|Voxrame.map.room.wall.Type, integer[]>
	wall_blocks = {
		_all  = ids_wall_nodes,
		floor = table.insert_all(
			table.copy(ids_wall_nodes),
			{ id_modor_stone, id_modor_stone, id_modor_stone }
		)
	},
	--- @type Voxrame.map.room.Exit[]
	exits = {},
}
setmetatable(Main, { __index = Room })

--- @private
--- @return self
function Main:lava_circle()
	local area    = self.area
	local center  = self:center()
	local floor_y = self.walls['floor'].from.y
	for x = center.x - 2, center.x + 2 do
		area:set_node_at({ x = x, y = floor_y, z = center.z - 2 }, id_lava)
		area:set_node_at({ x = x, y = floor_y, z = center.z + 2 }, id_lava)
	end
	for z = center.z - 1, center.z + 1 do
		area:set_node_at({ x = center.x - 2, y = floor_y, z = z }, id_lava)
		area:set_node_at({ x = center.x + 2, y = floor_y, z = z }, id_lava)
	end

	return self
end

--- @private
--- @return self
function Main:fill_walls()
	local area = self.area
	for name, wall in pairs(self.walls) do
		local nodes_ids = self.wall_blocks[name] or self.wall_blocks['_all']
		area:fill_with(nodes_ids, wall.from, wall.to)
	end

	return self
end

--- @return self
function Main:add_exits()
	local exits_count = math_random(2, 4)

	local walls = { WallType.north, WallType.south, WallType.east, WallType.west }
	table.shuffle(walls)

	for i = 1, exits_count do
		local side = walls[i] --- @as Voxrame.map.room.wall.Type
		local position = self:floor_center_of(side)

		local exit = Exit.to(side):at(position):with_size(3, 4):shift(math_random(-4, 4))
		self.exits[#self.exits + 1] = exit

		self.area:fill_with(id_air, exit.frame.from, exit.frame.to)
	end

	return self
end

--- Returns list of exits (areas) of the room.
--- @return Voxrame.map.room.Exit[]
function Main:get_exits()
	return self.exits
end

--- @return self
function Main:remains()
	local floor = table.copy(self:wall('floor', true))
	self.area:fill_with({ id_remains, id_bone_1 }, floor.from, floor.to, 0.02, { 0, 1, 2, 3 })

	return self
end

--- @private
--- @return self
function Main:barrels()
	local barrels_pile_size = 2 -- for all dimensions

	for _, corner in pairs(self:get_corners_of('floor')) do
		local to_center = self:to_center_from(corner):sign()

		local from = corner + to_center
		local to   = from   + to_center * (barrels_pile_size-1)

		local pile_peak = v(from.x, to.y, from.z)

		self.area:place_pile(id_barrel, from, to, pile_peak)

		local orientation = to_center.x > 0 and 3 or 2
		self.area:set_node_at(pile_peak:above(), id_orc_torch, orientation)
	end

	return self
end

--- @return self
function Main:do_generation()
	return self
		:fill_walls()
		:add_exits()
		:lava_circle()
		:remains()
		:barrels()
end


return Main
