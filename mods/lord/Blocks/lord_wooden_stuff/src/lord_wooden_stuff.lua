local api    = require("lord_wooden_stuff.api")
local config = require("lord_wooden_stuff.config")
local legacy = require("lord_wooden_stuff.legacy")

local function register_api()
	_G.lord_wooden_stuff = api
end

local function register_lord_wooden_stuff()
	for wood, def in pairs(config.wood_defs) do
		api.register_wooden_stuff(wood, def)
	end
end


return {
	init = function()
		register_api()
		register_lord_wooden_stuff()
		legacy.register_aliases()
	end,
}
