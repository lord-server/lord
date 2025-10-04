local table_merge, setmetatable
	= table.merge, setmetatable

local Event = require('physics.Event')


--- @class physics.PlayerPhysics.Reason
--- @field name        string
--- @field description string

--- @class physics.PlayerPhysics
local PlayerPhysics = {
	--- @type Player
	player       = nil, --- @diagnostic disable-line: assign-type-mismatch

	--- @type physics_override_table
	base_physics = nil, --- @diagnostic disable-line: assign-type-mismatch
	--- ```lua
	--- {
	--- 	speed = {
	--- 		[reason.name] = amount,
	--- 		[reason.name] = amount,
	--- 	}
	--- }
	--- ```
	--- @private
	--- @type table<string,table<string,number>>
	deltas       = nil, --- @diagnostic disable-line: assign-type-mismatch
}

--- Constructor
--- @public
--- @param player        Player
--- @param base_physics? physics_override_table (default: { speed = 1, jump = 1, gravity = 1 })
--- @return physics.PlayerPhysics
function PlayerPhysics:new(player, base_physics)
	local class = self

	self = {}
	self.player       = player
	self.base_physics = base_physics or { speed = 1, jump = 1, gravity = 1 }
	self.deltas       = {}

	return setmetatable(self, { __index = class })
end

--- @param player Player
--- @return physics.PlayerPhysics
function PlayerPhysics:refresh_player(player)
	self.player = player

	return self
end

--- @param physics physics_override_table
--- @param reason  physics.PlayerPhysics.Reason
function PlayerPhysics:merge(physics, reason)
	for physics_name, amount in pairs(physics) do
		if not self.deltas[physics_name] then
			self.deltas[physics_name] = {}
		end
		self.deltas[physics_name][reason.name] = amount
	end
end

--- @return physics_override_table
function PlayerPhysics:extract_override()
	--- @type physics_override_table
	local for_override = {}
	for physics_name, reason_amounts in pairs(self.deltas) do
		for_override[physics_name] = self.base_physics[physics_name]
		for reason_name, delta in pairs(reason_amounts) do
			for_override[physics_name] = for_override[physics_name] + delta
		end
	end

	return for_override
end

--- @overload fun():table<string,table<string,number>>
--- @param name?   string
--- @param reason? physics.PlayerPhysics.Reason
--- @return table<string,table<string,number>>|table<string,number>|number|nil
function PlayerPhysics:get(name, reason)
	return name
		and (reason
			and (self.deltas[name] and self.deltas[name][reason.name] or nil)
			or  (self.deltas[name] or nil)
		)
		or  self.deltas
end

--- @private
function PlayerPhysics:set_override()
	self.player:set_physics_override(table_merge(
		self.player:get_physics_override(), self:extract_override()
	))
end

--- @param physics physics_override_table
--- @param reason  physics.PlayerPhysics.Reason
function PlayerPhysics:set(physics, reason)
	self:merge(physics, reason)
	self:set_override()
	Event:trigger(Event.Type.on_change, self.player, self)
end

--- After adding `reason` for `:set()` following functions seems unnecessary:

-- --- @param physics physics_override_table
--function PlayerPhysics:add(physics)
--	self.physics = table_add_values(self.physics, physics)
--	self:set_override()
--	Event:trigger(Event.Type.on_change, self.player, self)
--end
--
-- --- @param physics physics_override_table
--function PlayerPhysics:sub(physics)
--	self.physics = table_sub_values(self.physics, physics)
--	self:set_override()
--	Event:trigger(Event.Type.on_change, self.player, self)
--end
--
-- --- @param physics physics_override_table
--function PlayerPhysics:mul(physics)
--	self.physics = table_mul_values(self.physics, physics)
--	self:set_override()
--	Event:trigger(Event.Type.on_change, self.player, self)
--end
--
-- --- @param physics physics_override_table
--function PlayerPhysics:div(physics)
--	self.physics = table_div_values(self.physics, physics)
--	self:set_override()
--	Event:trigger(Event.Type.on_change, self.player, self)
--end


return PlayerPhysics
