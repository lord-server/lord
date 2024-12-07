local table_merge, table_add_values, table_sub_values, table_mul_values, table_div_values, setmetatable
	= table.merge, table.add_values, table.sub_values, table.mul_values, table.div_values, setmetatable

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

--- @overload fun()
--- @param name string
--- @return number|table<string,number>
function PlayerPhysics:get(name)
	return name
		and (self.physics[name] or nil)
		or  self.physics
end

--- @private
function PlayerPhysics:set_override()
	self.player:set_physics_override(table_merge(
		self.player:get_physics_override(), self.physics
	))
end

--- @param physics physics_override_table
function PlayerPhysics:set(physics)
	self.physics = table_merge(self.physics, physics)
	self:set_override()
	Event:trigger(Event.Type.on_change, self.player, self)
end

--- @param physics physics_override_table
function PlayerPhysics:add(physics)
	self.physics = table_add_values(self.physics, physics)
	self:set_override()
	Event:trigger(Event.Type.on_change, self.player, self)
end

--- @param physics physics_override_table
function PlayerPhysics:sub(physics)
	self.physics = table_sub_values(self.physics, physics)
	self:set_override()
	Event:trigger(Event.Type.on_change, self.player, self)
end

--- @param physics physics_override_table
function PlayerPhysics:mul(physics)
	self.physics = table_mul_values(self.physics, physics)
	self:set_override()
	Event:trigger(Event.Type.on_change, self.player, self)
end

--- @param physics physics_override_table
function PlayerPhysics:div(physics)
	self.physics = table_div_values(self.physics, physics)
	self:set_override()
	Event:trigger(Event.Type.on_change, self.player, self)
end


return PlayerPhysics
