local api    = require("rocks.api")
local config = require("rocks.config")

lord_damage = {}

local function register_api()
	_G.lord_damage = api
end

local function register_damage_types()
	for type, behavior in pairs(config) do
		api.register_damage_type(type, behavior)
	end
end


return {
	init = function()
		register_api()
		register_damage_types()
	end,
}
