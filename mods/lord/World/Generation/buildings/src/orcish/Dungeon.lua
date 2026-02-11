local v,          id
    = vector.new, minetest.get_content_id

	local MainRoom = require('orcish.Room.Main')


--- @class buildings.OrcishDungeon
local OrcishDungeon = {
	--- @type vector
	center = nil, --- @diagnostic disable-line: assign-type-mismatch
	--- @type Voxrame.map.Room[]
	rooms = {},
	--- @type integer
	rooms_count = 0,
	--- id of node taken from `core.get_content_id('<mod:node>|air')` or `nil` if no filling is required.
	--- @protected
	--- @type integer|nil
	on_debug_fill_with = id('default:stone'),
}

--- @param position    vector
--- @param rooms_count integer
function OrcishDungeon:new(position, rooms_count)
	self = setmetatable({}, { __index = self })
	self.center      = position
	self.rooms_count = math.limit(rooms_count, 3, 5)

	return self
end

--- @param debug        boolean
--- @param is_on_mapgen boolean
function OrcishDungeon:generate(debug, is_on_mapgen)
	local half_size = v(30, 30, 30)

	local from      = self.center - half_size
	local to        = self.center + half_size
	local fill_with = self.on_debug_fill_with --- @diagnostic disable-line: access-invisible тупит плагин
	core.with_map_part_do(from, to, function(area, data)
		if not debug and area:content_of(id('air')) > 0.2 then
			core.log('warning', 'OrcishDungeon: abort generation, area has too much air. Is this a cave or overhang?')

			return
		end

		if debug and fill_with then
			area:fill_with(fill_with)
		end

		local main_room = MainRoom:new(self.center)
			:set_debug(debug)
			:generate(area, data)

		for _, exit in pairs(main_room:get_exits()) do
			-- TODO: connect corridors to exits and other rooms to that corridors
			-- something like:
			-- exit:connect(Corridor:new(...))
		end
	end, is_on_mapgen, true)
end


return OrcishDungeon
