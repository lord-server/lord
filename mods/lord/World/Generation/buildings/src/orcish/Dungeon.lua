local pairs, v,          id
    = pairs, vector.new, core.get_content_id

local MainRoom      = require('orcish.Room.Main')
local SecondaryRoom = require('orcish.Room.Secondary')
local Corridor      = Voxrame.map.Corridor
local Side          = Voxrame.map.room.wall.Type


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
	--- @static
	--- @protected
	--- @type helpers.Logger
	logger = core.get_mod_logger(),
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
	local fill_with = self.on_debug_fill_with
	core.with_map_part_do(from, to, function(area, data)
		if not debug and area:content_of(id('air')) > 0.2 then
			self.logger.warning('OrcishDungeon: abort generation, area has too much air. Is this a cave or overhang?')

			return
		end

		if debug and fill_with then
			area:fill_with(fill_with)
		end

		local main_room = MainRoom:new(self.center)
			:set_debug(debug)
			:generate(area, data)

		for _, exit in pairs(main_room:get_exits()) do
			local exit_side = Side.of(exit.direction)

			local corridor = Corridor:new({ width = 3, height = 4 }, math.random(3, 3), exit_side)
				:connect_to(exit)
				:generate(area, data)

			SecondaryRoom:new()
				:connect_to(corridor.exits[exit_side])
				:generate(area, data)
		end
	end, is_on_mapgen, true)
end


return OrcishDungeon
