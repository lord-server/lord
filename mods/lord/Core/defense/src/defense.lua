local PlayerDefense = require('defense.PlayerDefense')
local Event         = require('defense.Event')


--- @type defense.PlayerDefense[]|table<string,defense.PlayerDefense>
local player_defense = {}


defense = {} -- luacheck: ignore unused global variable defense

local function register_api()
	_G.defense = {
		--- @param player Player
		for_player = function(player)
			local name = player:get_player_name()
			if not player_defense[name] then
				player_defense[name] = PlayerDefense:new(player)
				Event:trigger(Event.Type.on_init, player, player_defense[name])
			else
				player_defense[name]:refresh_player(player)
			end

			return player_defense[name]
		end,

		--- @type fun(callback:defense.callback)
		on_change = Event:on(Event.Type.on_change),

		--- @type fun(callback:defense.callback)
		on_init   = Event:on(Event.Type.on_init),
	}
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_api()

		minetest.register_on_leaveplayer(function(player, timed_out)
			player_defense[player:get_player_name()] = nil
		end)

		require('defense.damage_avoid')
	end
}
