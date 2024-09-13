

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


return Effect
