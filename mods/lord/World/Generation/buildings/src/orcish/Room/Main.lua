local pairs, v,          id
    = pairs, vector.new, core.get_content_id

local Room  = Voxrame.map.Room


-- walls:
local ids_wall_nodes = {
	id('lord_bricks:mordor_clay_brick'),
	id('lord_bricks:mordor_clay_masonry'),
	id('lord_bricks:mordor_clay_masonry_large'),
}
local id_modor_stone = id('lord_rocks:mordor_stone')
-- center:
local id_lava            = id('default:lava_source')
local id_charcoal_block  = id('default:charcoalblock')
local id_permanent_flame = id('fire:permanent_flame')
local id_skull_candle    = id('lord_lamps:skull_candle')
-- corners:
local id_barrel    = id('barrel:barrel')
local id_orc_chest = id('lottmapgen:mordor_chest_spawner')
local id_orc_torch = id('torches:orc_wall')
-- decorations:
local id_remains   = id('remains:ancient_miner_1')
local id_bone_1    = id('bones:bone_1')

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
		),
	},
	--- @type Voxrame.map.room.ExitsDefinition
	possible_exits = {
		count = { min =  2, max = 4 },
		shift = { min = -4, max = 4 },
	},
	--- @type integer
	corner_pile_size = 2,
}
Room:extended(Main)

--- @private
--- @return self
function Main:center_lava_circle()
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
function Main:center_flame_and_skull_candles()
	local floor_center = self:floor(true):center()
	self.area:set_node_at(floor_center        , id_charcoal_block)
	self.area:set_node_at(floor_center:above(), id_permanent_flame)

	self.area:set_node_at(floor_center + v( 1, 0,  1), id_skull_candle, 2)
	self.area:set_node_at(floor_center + v( 1, 0, -1), id_skull_candle, 0)
	self.area:set_node_at(floor_center + v(-1, 0,  1), id_skull_candle, 2)
	self.area:set_node_at(floor_center + v(-1, 0, -1), id_skull_candle, 0)

	return self
end

--- @return self
function Main:remains()
	local floor = self:floor(true)
	self.area:fill_with({ id_remains, id_bone_1 }, floor.from, floor.to, 0.02, { 0, 1, 2, 3 })

	return self
end

--- @private
--- @return self
function Main:corners_barrels()
	for _, corner in pairs(self:get_corners_of('floor')) do
		local to_center = self:to_center_from(corner):sign()

		local from = corner + to_center
		local to   = from   + to_center * (self.corner_pile_size - 1)

		local pile_peak = v(from.x, to.y, from.z)

		self.area:place_pile({ id_barrel, id_orc_chest }, from, to, pile_peak)

		local orientation = to_center.x > 0 and 3 or 2
		self.area:set_node_at(pile_peak:above(), id_orc_torch, orientation)
	end

	return self
end

--- @return self
function Main:do_generation()
	return self
		:remains()
		:center_lava_circle()
		:center_flame_and_skull_candles()
		:corners_barrels()
end


return Main
