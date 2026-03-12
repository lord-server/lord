local v         , id
    = vector.new, core.get_content_id

local Room  = Voxrame.map.Room


local ids_wall_nodes = {
	id('lord_bricks:mordor_clay_brick'),
	id('lord_bricks:mordor_clay_masonry'),
	id('lord_bricks:mordor_clay_masonry_large'),
}
local id_modor_stone = id('lord_rocks:mordor_stone')
local id_orc_torch   = id('torches:orc_wall')

--- @class buildings.OrcishCave.Room.Secondary: Voxrame.map.Room
local Secondary = {
    --- @type IntegerVector
    size = v(10, 5, 10),
    --- @private
    --- @type table<'_all'|Voxrame.map.room.wall.Type, integer[]>
    wall_blocks = {
        _all = ids_wall_nodes,
		floor = table.insert_all(
			table.copy(ids_wall_nodes),
			{ id_modor_stone, id_modor_stone, id_modor_stone }
		)
    },
}
Room:extended(Secondary)

function Secondary:corners()
	for _, corner in pairs(self:get_corners_of('floor', true)) do
		local to_center = self:to_center_from(corner)
		local orientation = to_center.x > 0 and 3 or 2
		self.area:set_node_at(corner:above(), id_orc_torch, orientation)
	end

	return self
end

--- @return self
function Secondary:do_generation()
	return self
		:corners()
end


return Secondary
