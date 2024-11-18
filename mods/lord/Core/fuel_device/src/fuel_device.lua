local api    = require("fuel_device.api")


fuel_device = {} -- luacheck: ignore unused global variable fuel_device

local function register_api()
	_G.fuel_device = api
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_api()
	end,
}
