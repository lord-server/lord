local api    = require("rocks.api")
local config = require("rocks.config")

rocks = {}

local function register_api()
	_G.rocks = api
end

local function register_lord_rocks()
	api.add_existing("default:stone")
	api.add_existing("default:desert_stone")
	api.add_existing("default:sandstone")
	api.add_existing("default:desert_sandstone")
	api.add_existing("default:silver_sandstone")
	for name, registration in pairs(config) do
		api.register_rock(name, registration.softness, registration.definition)
	end
end


return {
	init = function()
		register_api()
		register_lord_rocks()
	end,
}
