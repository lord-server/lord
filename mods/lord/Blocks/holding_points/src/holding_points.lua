local node      = require('holding_points.node')
local Storage   = require('holding_points.Storage')
local Manager   = require('holding_points.Manager')
local Scheduler = require('holding_points.Scheduler')
local command   = require('holding_points.command')


holding_points = {} -- luacheck: ignore unused global variable holding_points

local function register_node()
	minetest.register_node('holding_points:node', node.definition)
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_node()

		local storage   = Storage:new(minetest.get_mod_storage())
		local scheduler = Scheduler:new()

		-- We need minetest to have fully started to access the map.
		-- So, deferred start of Manager:
		minetest.after(5, function()
			Manager
				.init(storage)
				.run(scheduler)
		end)

		minetest.register_chatcommand(command.battle_start.NAME, command.battle_start.definition)
		minetest.register_chatcommand(command.battle_stop.NAME,  command.battle_stop.definition)
	end,
}
