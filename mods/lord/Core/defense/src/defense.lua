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

local function register_nodes_damage_defense()
	for _, damage_type in ipairs(damage.Type.get_registered()) do
		damage.Type:of(damage_type):add_modifier(function(player, hp_change, reason)
			if reason.type ~= 'node_damage' then  return hp_change  end

			local defense = defense.for_player(player).defense[damage_type] or 0
			if defense > 0 then
				hp_change = hp_change * (100 - defense) / 100
			end

			return hp_change
		end)
	end
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_api()

		register_nodes_damage_defense()

		minetest.register_on_leaveplayer(function(player, timed_out)
			player_defense[player:get_player_name()] = nil
		end)

		require('defense.damage_avoid')
	end
}
