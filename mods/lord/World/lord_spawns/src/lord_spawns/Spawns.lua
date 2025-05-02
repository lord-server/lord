local Logger = minetest.get_mod_logger()


--- @class lord_spawns.Spawns
local Spawns = {
	--- @private
	--- @type lord_spawns.Config.spawns
	config = nil,
	--- @private
	--- @type Position
	common_spawn_position = nil,
}

--- @static
--- @private
--- @param config lord_spawns.Config.spawns
function Spawns.validate(config)
	for race, position in pairs(config) do
		assert(lord_races.has_player_race(race), 'Unknown race `' .. race .. '` in Spawns config.')
		assert(
			table.is_position(position),
			'Invalid position for race `' .. race .. '`. Expected `{ x:number, y:number, z:number }`.'
		)
	end
end

--- @static
--- @param config lord_spawns.Config.spawns
--- @return lord_spawns.Spawns
function Spawns.configure(config)
	Spawns.validate(config)
	Spawns.config = config

	return Spawns
end

--- @param position Position
--- @return lord_spawns.Spawns
function Spawns.set_common(position)
	assert(table.is_position(position), 'Invalid position of common Spawn. Expected `{ x:number, y:number, z:number }`.')
	Spawns.common_spawn_position = position

	return Spawns
end

--- @param race string one of lord_races.Name.<RACE>.
--- @return Position
function Spawns.position_of(race)
	return Spawns.config[race] or Spawns.common_spawn_position
end

--- @static
--- Moves the `player` to spawn of `race` & returns actual teleportation location.
--- @param player Player player to teleport to spawn.
--- @param race   string one of lord_races.Name.<RACE>.
--- @return string, Position actual tp location: spawn-code (race name or string `"common"`), position
function Spawns.teleport_to(player, race)
	local position = Spawns.position_of(race)
	local spawn_code = Spawns.config[race] and race or 'common'

	Logger.action(
		'Moving %s to %s spawn at %s',
		player:get_player_name(),
		Spawns.config[race] and race or ('common(no config for `'.. race ..'`)'),
		minetest.pos_to_string(position)
	)

	player:set_pos(position)

	return spawn_code, position
end


return Spawns
