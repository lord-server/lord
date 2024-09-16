local PlayerPhysics = require('physics.PlayerPhysics')
local Event         = require('physics.Event')


--- @type physics.PlayerPhysics[]|table<string,physics.PlayerPhysics>
local player_physics = {}

physics = {} -- luacheck: ignore unused global variable physics

local function register_api()
	_G.physics = {
		--- @param player Player
		--- @return physics.PlayerPhysics
		for_player = function(player)
			local name = player:get_player_name()
			if not player_physics[name] then
				player_physics[name] = PlayerPhysics:new(player)
			else
				player_physics[name]:refresh_player(player)
			end

			return player_physics[name]
		end,

		--- @type fun(callback:physics.callback)
		on_change = Event:on(Event.Type.on_change),

		--- @type fun(callback:physics.callback)
		on_init   = Event:on(Event.Type.on_init),
	}
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_api()

		minetest.register_on_leaveplayer(function(player)
			player_physics[player:get_player_name()] = nil
		end)
	end,
}

