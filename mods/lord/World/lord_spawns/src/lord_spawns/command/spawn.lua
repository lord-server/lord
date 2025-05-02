local S = minetest.get_mod_translator()


--- @param Spawns lord_spawns.Spawns
--- @return ChatCommandDefinition
local function get_spawn_command_definition(Spawns)
	--- @type ChatCommandDefinition
	local spawn_command_definition = {
		description = S('Teleport to Spawn'),
		func        = function(name, _)
			local player   = minetest.get_player_by_name(name)
			local location = character.of(player):get_race()

			local teleported_to = Spawns.teleport_to(player, location)

			return true, S('Teleporting to @1 Spawn...', S(teleported_to))
		end
	}

	return spawn_command_definition
end


return {
	--- @type string
	NAME           = 'spawn',
	--- @type ChatCommandDefinition
	get_definition = get_spawn_command_definition,
}
