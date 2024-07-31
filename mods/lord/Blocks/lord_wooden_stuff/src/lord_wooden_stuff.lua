local api    = require("lord_wooden_stuff.api")
local config = require("lord_wooden_stuff.config")
local legacy = require("lord_wooden_stuff.legacy")


lord_wooden_stuff = {} -- luacheck: ignore unused global variable lord_wooden_stuff

local function register_api()
	_G.lord_wooden_stuff = api
end

local function register_lord_wooden_stuff()
	for wood, def in pairs(config.wood_defs) do
		local exceptions = config.wood_stuff_exceptions[wood]
		api.register_wooden_stuff(wood, def, exceptions)
	end
end


return {
	init = function()
		register_api()
		register_lord_wooden_stuff()
		legacy.register_aliases()
	end,
}
