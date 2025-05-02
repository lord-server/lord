local Config  = require('lord_spawns.Config')
local Spawns  = require('lord_spawns.Spawns')
local Halls   = require('lord_spawns.Halls')
local command = require('lord_spawns.command')


lord_spawns = {} -- luacheck: ignore unused global variable lord_spawns

local function register_life_command_dummy(S)
	minetest.register_chatcommand('life', {
		description = S('Teleport to the @1', S('Hall of Life')),
		func = function(_, _)
			return true, S('Command reserved. For teleporting to Old Central Spawn use command `/center`')
		end
	})
end

--- @param player Player
--- @return boolean
local function on_player_respawn(player)
	local name = player:get_player_name()
	if beds.spawn[name] == nil then
		lord_spawns.spawns.teleport_to(player, character.of(player):get_race())
	end

	return true -- to disable regular player placement
end

--- @param mod minetest.Mod
local function register_api(mod)
	_G.lord_spawns = {
		has_several = Config.dynamic_spawns,
		spawns      = Spawns,
		halls       = Halls,
	}
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		Spawns.configure(Config.spawns).set_common(Config.common_spawn_pos)
		Halls .configure(Config.halls).register_configured()
		register_life_command_dummy(mod.translator)

		minetest.register_chatcommand(command.spawn.NAME, command.spawn.get_definition(Spawns))
		minetest.register_privilege(command.spawn_to.privilege.NAME, command.spawn_to.privilege.definition)
		minetest.register_chatcommand(command.spawn_to.command.NAME, command.spawn_to.command.get_definition(Spawns))
		minetest.register_on_respawnplayer(on_player_respawn)


		register_api(mod)
	end,
}
