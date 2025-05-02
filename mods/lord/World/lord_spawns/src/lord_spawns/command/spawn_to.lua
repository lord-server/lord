local S = minetest.get_mod_translator()

--- @type PrivilegeDefinition
local privilege_definition = {
	description = S('Can teleport to any race spawn.'),
	give_to_singleplayer = false,
}

--- @param Spawns lord_spawns.Spawns
--- @return ChatCommandDefinition
local function get_command_definition(Spawns)
	--- @type ChatCommandDefinition
	local command_definition = {
		params = '<race>',
		privs = { spawn_to = true, },
		description = S('Teleports to specified Spawn.'),
		func = function(name, race)
			if not lord_races.has_player_race(race) then
				return false, S('Unknown player race: @1', S(race))
			end

			local player = minetest.get_player_by_name(name)
			local teleported_to = Spawns.teleport_to(player, race)

			return true, S('Teleporting to @1 Spawn...', S(teleported_to))
		end
	}

	return command_definition
end


return {
	privilege = {
		--- @type string
		NAME       = 'spawn_to',
		--- @type PrivilegeDefinition
		definition = privilege_definition,
	},
	command = {
		--- @type string
		NAME           = 'spawn_to',
		--- @type ChatCommandDefinition
		get_definition = get_command_definition
	},
}
