local api       = require('holding_points.api')
local node      = require('holding_points.node')
local Storage   = require('holding_points.Storage')
local Manager   = require('holding_points.Manager')
local Notifier  = require('holding_points.Notifier')
local Scheduler = require('holding_points.Scheduler')
local command   = require('holding_points.command')
local config    = require('holding_points.config')


holding_points = {} -- luacheck: ignore unused global variable holding_points


return {
	--- @param mod minetest.Mod
	init = function(mod)
		-- Register api
		_G.holding_points = api

		minetest.register_node('holding_points:node', node.definition)

		local storage   = Storage:new(minetest.get_mod_storage())
		local scheduler = Scheduler:new()

		-- We need minetest to have fully started to access the map.
		-- So, deferred start of Manager:
		minetest.after(1, function()
			Manager
				.init(storage)
				.set_debug(mod.debug)
				.run(scheduler)
		end)

		Notifier.init(config.notifier)

		minetest.register_chatcommand(command.battle_start.NAME, command.battle_start.definition)
		minetest.register_chatcommand(command.battle_stop.NAME,  command.battle_stop.definition)
	end,
}
