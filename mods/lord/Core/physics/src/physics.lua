local ipairs
    = ipairs

local PlayerPhysics = require('physics.PlayerPhysics')
local Event         = require('physics.Event')


--- @type table<number,string>|string[]
local PHYSICS_TYPES = { "jump", "speed", "gravity" }

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

--- @param player        Player
local function collect_physics(player)
	local physics = { speed = 1, gravity = 1, jump = 1 }
	for _, stack in equipment.for_player(player):items(equipment.Kind.ARMOR) do
		if stack:get_count() == 1 then
			local item_groups = stack:get_definition().groups
			for _, type in ipairs(PHYSICS_TYPES) do
				local value = item_groups["physics_" .. type]
				if value then
					physics[type] = (physics[type] or 1) + value
				end
			end
		end
	end

	return physics
end

--- @param player Player
local function set_player_physics(player)
	local physics_o = collect_physics(player)

	physics.for_player(player):set(physics_o)
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_api()

		equipment.on_load(equipment.Kind.ARMOR, function(player)
			set_player_physics(player)
		end)
		equipment.on_change(equipment.Kind.ARMOR, function(player)
			set_player_physics(player)
		end)
		minetest.register_on_leaveplayer(function(player)
			player_physics[player:get_player_name()] = nil
		end)
	end,
}

