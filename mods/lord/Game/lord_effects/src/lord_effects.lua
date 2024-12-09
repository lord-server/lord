

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
			:on_start(function(self, player, amount)
				physics.for_player(player):set({ speed = 1 + amount })
			end)
			:on_stop(function(self, player)
				physics.for_player(player):set({ speed = 1 })
			end)
	)
	effects.register(
		effects.Effect:new(lord_effects.JUMP)
			:on_start(function(self, player, amount)
				physics.for_player(player):set({ jump = 1 + amount })
			end)
			:on_stop(function(self, player)
				physics.for_player(player):set({ jump = 1 })
			end)
	)
	effects.register(
		effects.Effect:new(lord_effects.HEALTH)
			:on_start(function(self, player, amount, duration)
				damage.Periodical:for_player(player):start(damage.Type.FLESHY, amount, duration)
			end)
			:on_stop(function(self, player)
			    -- Periodical Damage stops itself.
			end)
	)
	effects.register(
		effects.Effect:new(lord_effects.BREATH)
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
			:on_start(function(self, player, amount, duration)
				player:set_breath(0)
				player:set_flags({ breathing = false, })
				damage.Periodical:for_player(player):start(damage.Type.SUFFOCATION, amount, duration)
			end)
			:on_stop(function(self, player)
				player:set_flags({ breathing = true, })
				-- Periodical Damage stops itself.
			end)
	)
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_effects()
	end,
}
