local Faction     = require('factions.Faction')
local Collection  = require('factions.Collection')


factions          = {} -- luacheck: ignore unused global variable factions

local function register_api()
	_G.factions = {
		--- @param definition factions.FactionDefinition
		register = function(definition)
			Collection.add(Faction:new(definition))
		end,

		get      = Collection.get,

		all      = Collection.all,
	}
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_api()
	end,
}
