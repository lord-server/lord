local api                 = require("bows.api")
local config              = require("bows.config")

lord_bows                 = {}

local function register_api()
	_G.lord_bows = api
end

local function register_bows()
	for name, registration in pairs(config.bows) do
		api.register_bow(name, registration)
	end
end

local function register_projectiles()
	for name, registration in pairs(config.projectiles) do
		api.register_projectile(name, registration)
	end
end


return {
	init = function()
		register_api()
		register_bows()
		register_projectiles()
	end,
}
