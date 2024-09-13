local Effect     = require("effects.Effect")
local Registered = require("effects.Registered")
local Processor  = require("effects.Processor")


effects = {} -- luacheck: ignore unused global variable effects

local function register_api()
	_G.effects = {
		Effect         = Effect,
		register       = Registered.add,
		get_registered = Registered.all,
		for_player     = function(player)

		end
	}
end


return {
	init = function()
		register_api()

		Processor.init()
	end,
}
