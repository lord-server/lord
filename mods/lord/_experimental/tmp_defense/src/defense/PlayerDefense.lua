--- @class defense.PlayerDefense
local PlayerDefense = {

}

--- Constructor
--- @public
--- @param player Player
--- @return defense.PlayerDefense
function PlayerDefense:new(player)
	local class = self

	self = {}
	self.player = player

	return setmetatable(self, { __index = class })
end


return PlayerDefense
