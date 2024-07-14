local api    = require("lord_spawners.api")
local config = require("lord_spawners.config")


local function register_api()
	_G.lord_spawners = api
end

local function register_racial()
	local racial = config.racial

	for _, race in pairs(racial) do
		api.register("lottmobs:" .. race, {
			dummy_size = { x = 0.7, y = 0.7 },
			dummy_offset = 0.2,
			dummy_mesh = 'lottarmor_character_old.b3d',
			dummy_texture = { "lottmobs_" .. race .. ".png" },
		})
	end
end


return {
	init = function()
		register_api()
		register_racial()
	end,
}
