local setmetatable
    = setmetatable


--- @class defense.PlayerDefense
local PlayerDefense = {
	--- @type number in percents from 0 to 100
	fleshy              = nil,
	--- @type number in percents from 0 to 100
	fire                = nil,
	--- @type number in percents from 0 to 100
	damage_avoid_chance = nil,
}

--- Constructor
--- @public
--- @param player Player
--- @return defense.PlayerDefense
function PlayerDefense:new(player)
	local class = self

	self = {}
	self.player = player

	self.fleshy              = 0
	self.fire                = 0
	self.damage_avoid_chance = 0

	return setmetatable(self, { __index = class })
end


return PlayerDefense
