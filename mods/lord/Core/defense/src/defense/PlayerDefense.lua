local math_limit, setmetatable
	= math.limit, setmetatable

local Event = require('defense.Event')


--- @class defense.PlayerDefense
local PlayerDefense = {
	--- @static
	--- @private
	default_type = 'fleshy',

	--- @type Player
	player = nil,

	--- @private
	defense = {
		--- @type number in percents from 0 to 100
		fleshy = nil,
		--- @type number in percents from 0 to 100
		fire   = nil,
		--- @type number in percents from 0 to 100
		soul   = nil,
		--- @type number in percents from 0 to 100
		poison = nil,
	},

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
	self.player  = player
	self.defense = {}

	for _, type in pairs(damage.Type.get_registered()) do
		self.defense[type] = 0
	end
	self.damage_avoid_chance = 0

	return setmetatable(self, { __index = class })
end

--- @param player Player
--- @return defense.PlayerDefense
function PlayerDefense:refresh_player(player)
	self.player = player

	return self
end

--- @param defense {fleshy:number,fire:number,soul:number,poison:number}|table<string,number>
--- @return {fleshy:number,fire:number,soul:number,poison:number}|table<string,number>
local function build_armor_groups(defense)
	--- @type table<string,number>
	local armor_groups = {}
	for _, damage_type in pairs(damage.Type.get_registered()) do
		armor_groups[damage_type] = 100 - (
			defense[damage_type]
				and math_limit(defense[damage_type], 0, 100)
				or  0
		)
	end

	return armor_groups
end

--- @param defense             {fleshy:number,fire:number,soul:number,poison:number}|table<string,number>
--- @param damage_avoid_chance number
function PlayerDefense:set(defense, damage_avoid_chance)
	self.defense             = defense
	self.damage_avoid_chance = damage_avoid_chance

	self.player:set_armor_groups(build_armor_groups(self.defense))

	Event:trigger(Event.Type.on_change, self.player, self)
end

--- @return number
function PlayerDefense:default()
	return self.defense[self.default_type]
end


return PlayerDefense
