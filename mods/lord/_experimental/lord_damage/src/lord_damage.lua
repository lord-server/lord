local api    = require("damage.api")
local config = require("damage.config")

lord_damage = {}

local function register_api()
	_G.lord_damage = api
end

local function register_damage_types()
	for damage_type, behavior in pairs(config) do
		api.register_damage_type(damage_type, behavior)
	end
end


return {
	init = function()
		register_api()
		register_damage_types()
	end,
}
