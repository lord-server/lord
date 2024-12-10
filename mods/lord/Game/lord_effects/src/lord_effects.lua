

lord_effects = {
	SPEED  = 'speed',
	JUMP   = 'jump',
	HEALTH = 'health',
	BREATH = 'breath',
	SUFFOCATION = 'suffocation',
}


local function register_effects()
	effects.register(
		effects.Effect:new(lord_effects.SPEED)
			:is_stops_on_same_reason(true)
			:on_start(function(self, player, amount, duration, reason)
				physics.for_player(player):set({ speed = amount }, reason)
			end)
			:on_stop(function(self, player, amount, duration, reason)
				physics.for_player(player):set({ speed = 0 }, reason)
			end)
	)
	effects.register(
		effects.Effect:new(lord_effects.JUMP)
			:is_stops_on_same_reason(true)
			:on_start(function(self, player, amount, duration, reason)
				physics.for_player(player):set({ jump = amount }, reason)
			end)
			:on_stop(function(self, player, amount, duration, reason)
				physics.for_player(player):set({ jump = 0 }, reason)
			end)
	)
	effects.register(
		effects.Effect:new(lord_effects.HEALTH)
			:is_stops_on_same_reason(true)
			:on_start(function(self, player, amount, duration)
				damage.Periodical:for_player(player):start(damage.Type.FLESHY, amount, duration)
			end)
			:on_stop(function(self, player)
				damage.Periodical:for_player(player):stop(damage.Type.FLESHY)
			end)
	)
	effects.register(
		effects.Effect:new(lord_effects.BREATH)
			:is_stops_on_same_reason(true)
			:on_start(function(self, player, amount, duration)
				player:set_breath(player.breath_max or core.PLAYER_MAX_BREATH_DEFAULT)
				player:set_flags({ drowning = false, })
			end)
			:on_stop(function(self, player)
				player:set_flags({ drowning = true, })
			end)
	)
	effects.register(
		effects.Effect:new(lord_effects.SUFFOCATION)
			:is_stops_on_same_reason(true)
			:on_start(function(self, player, amount, duration)
				player:set_breath(0)
				player:set_flags({ breathing = false, })
				damage.Periodical:for_player(player):start(damage.Type.SUFFOCATION, amount, duration)
			end)
			:on_stop(function(self, player)
				player:set_flags({ breathing = true, })
				damage.Periodical:for_player(player):stop(damage.Type.SUFFOCATION)
			end)
	)
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_effects()
	end,
}
