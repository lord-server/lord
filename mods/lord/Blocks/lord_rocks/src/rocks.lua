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
	for name, registration in pairs(config.rocks) do
		api.register_rock(name, registration.softness, registration.definition, true, registration.not_rock)
	end
end

local function register_additional_crafts()
	for _, recipe in pairs(config.additional_crafts) do
		minetest.register_mirrored_crafts(recipe)
	end
end


return {
	init = function()
		register_api()
		register_lord_rocks()
		register_additional_crafts()
	end,
}
