local Effect     = require("effects.Effect")
local Registered = require("effects.Registered")
local ForPlayer  = require("effects.ForPlayer")
local Processor  = require("effects.Processor")


--- @type effects.ForPlayer[]|table<string,effects.ForPlayer>
local player_effects = {}

effects = {} -- luacheck: ignore unused global variable effects

local function register_api()
	_G.effects = {
		Effect         = Effect,

		register       = Registered.add,
		get_registered = Registered.all,

		for_player     = function(player)
			local name = player:get_player_name()
			if not player_effects[name] then
				player_effects[name] = ForPlayer:new(player)
			else
				player_effects[name]:refresh_player(player)
			end

			return player_effects[name]
		end
	}
end


return {
	init = function()
		register_api()

		Processor.init()
	end,
}
