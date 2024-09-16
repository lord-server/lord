local table_merge, setmetatable
	= table.merge, setmetatable

local Event = require('physics.Event')


--- @class physics.PlayerPhysics
local PlayerPhysics = {
	--- @type Player
	player = nil,

	--- @private
	--- @type table<string,number>
	physics = nil,
}

--- Constructor
--- @public
--- @param player  Player
--- @param physics table<string,number>
--- @return physics.PlayerPhysics
function PlayerPhysics:new(player, physics)
	local class = self

	self = {}
	self.player  = player
	self.physics = physics or {}

	return setmetatable(self, { __index = class })
end

--- @param player Player
--- @return physics.PlayerPhysics
function PlayerPhysics:refresh_player(player)
	self.player = player

	return self
end

--- @param physics table
function PlayerPhysics:set(physics)
	self.physics = table_merge(self.physics, physics)

	self.player:set_physics_override(table_merge(
		self.player:get_physics_override(), self.physics
	))

	Event:trigger(Event.Type.on_change, self.player, self)
end

--- @overload fun()
--- @param name string
--- @return number|table<string,number>
function PlayerPhysics:get(name)
	return name
		and (self.physics[name] or nil)
		or  self.physics
end


return PlayerPhysics
