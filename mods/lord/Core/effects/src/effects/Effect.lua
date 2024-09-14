

--- @class effects.Effect
local Effect = {
	--- @type string
	name = nil,
	--- @type string
	type = nil,
}

--- @param
function Effect:new(name, type)
	local class = self

	self = {}
	self.name = name
	self.type = type

	return setmetatable(self, { __index = class })
end

-- TODO: function self.start() / self.stop() github: #1667

return Effect
