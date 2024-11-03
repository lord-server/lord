local api    = require("lord_archery.api")
local config = require("lord_archery.config")

lord_archery = {}

local function register_api()
	_G.lord_archery = api
end

local function register_bows()
	for name, registration in pairs(config.bows) do
		api.register_bow(name, registration)
	end
	for name, registration in pairs(config.crossbows) do
		api.register_crossbow(name, registration)
	end
end

return {
	init = function()
		register_api()
		register_bows()
	end,
}
