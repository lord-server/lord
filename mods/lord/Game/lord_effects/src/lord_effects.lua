

lord_effects = {
	SPEED  = 'speed',
	JUMP   = 'jump',
	HEALTH = 'health',
	-- BREATH = 'breath', TODO: #1678
}


local function register_effects()
	effects.register(
		effects.Effect:new(lord_effects.SPEED)
			:on_start(function(self, player, amount)
				physics.for_player(player):set({ speed = amount })
			end)
			:on_stop(function(self, player)
				physics.for_player(player):set({ speed = 1 })
			end)
	)
	effects.register(
		effects.Effect:new(lord_effects.JUMP)
			:on_start(function(self, player, amount)
				physics.for_player(player):set({ jump = amount })
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
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_effects()
	end,
}
