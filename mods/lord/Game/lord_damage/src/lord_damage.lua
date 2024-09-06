

return {
	--- @param mod minetest.Mod
	init = function(mod)
		-- TODO: register damage Types #1623

		-- TODO: register particles on damage of Type #1624

		-- temporary test TODO: remove
		if mod.debug then
			damage.on_damage(function(player, amount, reason)
				mod.logger.action('Damaged: ' .. dump({player, amount, reason}))

				-- TODO: remove or move as damage Type detection into `Core/damage` mode
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
