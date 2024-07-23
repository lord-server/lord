local api    = require("spawners.api")
local config = require("spawners.config")

spawners = {}
local function register_api()
	_G.spawners = api
end

local function register_racial()
	local racial = config.racial

	for _, race in pairs(racial) do
		spawners.register("lottmobs:" .. race, {
			dummy = {
				visual_size = { x = 0.7, y = 0.7 },
				mesh        = 'lottarmor_character_old.b3d',
				textures    = { "lottmobs_" .. race .. ".png" },
				offset      =  0.2,
			},
			night_only = "disabled",
		})
	end
end


return {
	init = function()
		register_api()
		register_racial()
	end,
}
