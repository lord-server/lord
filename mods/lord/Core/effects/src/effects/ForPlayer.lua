local Registered = require('effects.Registered')
local Processor  = require('effects.Processor')
local Logger     = minetest.get_mod_logger()

-- TODO: #1669

--- @class effects.ForPlayer
local ForPlayer = {
	--- @type Player
	player = nil,
	--- @type effects.Effect[]
	effects = nil,
	--- @static
	--- @type helpers.Logger
	logger = Logger,
}

function ForPlayer:new(player)
	local class = self

	self = {}
	self.player  = player
	self.effects = {}

	return setmetatable(self, { __index = class })
end

--- @param player Player
--- @return effects.ForPlayer
function ForPlayer:refresh_player(player)
	self.player = player

	return self
end

--- @param effect_name string
--- @param amount      number
--- @param duration    number
function ForPlayer:apply(effect_name, amount, duration, ...)
	local effect = Registered.get(effect_name)
	if not effect then
		self.logger.error('Can\'t apply effect: effect "%s" not found', effect_name)
		return
	end

	self.effects[effect_name] = {
		amount = amount,
		duration = duration,
	}

	Processor.run_effect_for(self.player, effect, amount, duration, {...}, function(player)
		-- TODO: the `player` could have already left. #1673
		self.effects[effect_name] = nil
	end)
end


return ForPlayer
