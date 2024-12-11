local Registered = require('effects.Registered')
local Processor  = require('effects.Processor')
local Logger     = minetest.get_mod_logger()


--- @class effects.ForPlayer.Active
--- @field effect   effects.Effect
--- @field amount   number
--- @field duration number
--- @field job      job

--- @class effects.ForPlayer
local ForPlayer = {
	--- @type Player
	player = nil,
	--- @type effects.ForPlayer.Active[][]
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

--- @param name string|nil effect name
--- @return effects.ForPlayer.Active[][]|effects.ForPlayer.Active[]
function ForPlayer:get(name)
	return name
		and (self.effects[name] or nil)
		or   self.effects
end

--- @param effect_name string
--- @param amount      number
--- @param duration    number
--- @param reason      effects.Effect.Reason
function ForPlayer:apply(effect_name, amount, duration, reason, ...)
	local effect = Registered.get(effect_name)
	if not effect then
		self.logger.error('Can\'t apply effect: effect "%s" not found', effect_name)
		return
	end

	reason = reason or { name = 'default' }
	self.effects[effect_name] = self.effects[effect_name] or {}

	if effect.stop_with_same_reason and self.effects[effect_name][reason.name] then
		self.effects[effect_name][reason.name].effect:stop(self.player, amount, duration, unpack({ reason, ... }))
		self.effects[effect_name][reason.name].job:cancel()
	end

	self.effects[effect_name][reason.name] = {
		amount   = amount,
		duration = duration,
		effect   = effect,
		job      = Processor.run_effect_for(self.player, effect, amount, duration, { reason, ... }, function(player)
			-- TODO: the `player` could have already left. #1673
			self.effects[effect_name][reason.name] = nil
		end)
	}
end


return ForPlayer
