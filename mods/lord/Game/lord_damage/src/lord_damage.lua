

return {
	--- @param mod minetest.Mod
	init = function(mod)
		-- TODO: register damage Types #1623
		-- TODO: use config ?
		damage.Type.FLESHY = 'fleshy'
		damage.Type.FIRE   = 'fire'
		damage.Type.SOUL   = 'soul'
		damage.Type.POISON = 'poison'

		damage.Type.register(damage.Type.FLESHY)
		damage.Type.register(damage.Type.FIRE)
		damage.Type.register(damage.Type.SOUL)
		damage.Type.register(damage.Type.POISON)

		-- temporary test TODO: remove/rewrite
		if mod.debug then

			-- TODO: register particles on damage of Type #1624
			damage.on_damage_of(damage.Type.FIRE, function(...)
				mod.logger.action('----------- damage.Type.FIRE: -----------')
				mod.logger.action(dump({...}))
			end)

			damage.on_damage(function(player, amount, reason)
				mod.logger.action('Damaged: ' .. dump({player, amount, reason}))

				-- TODO: remove or move as damage Type detection into `Core/damage` mode #1626
				if reason.node then
					local node_definition = minetest.registered_nodes[reason.node]
					print(dump(node_definition.damage_groups or (
						node_definition.tool_capabilities
							and node_definition.tool_capabilities.damage_groups
							or  {}
					)))
				end
			end)
		end
	end,
}
