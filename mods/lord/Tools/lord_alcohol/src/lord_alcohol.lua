local api    = require("lord_alcohol.api")
local config = require("lord_alcohol.config")


lord_alcohol = {} -- luacheck: ignore unused global variable lord_alcohol

local function register_api()
	_G.lord_alcohol = api
end

local function register_lord_alcohol()
	for _, alcohol in pairs(config) do
		api.register(alcohol.item_name, alcohol.satiety)
	end
end


return {
--- @param mod minetest.Mod
	init = function(mod)
		register_api()
		register_lord_alcohol()
	end,
}
