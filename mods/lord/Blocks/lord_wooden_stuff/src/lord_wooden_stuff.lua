local api    = require("lord_wooden_stuff.api")
local config = require("lord_wooden_stuff.config")
local legacy = require("lord_wooden_stuff.legacy")

local function register_api()
	_G.lord_wooden_stuff = api
end

local function register_lord_wooden_stuff()
	for _, def in ipairs(config.wood_defs) do
		api.register_wooden_stuff(def)
	end
end

local function handle_legacy()
	for _, wood_def in ipairs(config.wood_defs) do
		local wood = wood_def[1]
		legacy.register_aliases_by_wood(wood)
	end
end

return {
	init = function()
		register_api()
		register_lord_wooden_stuff()
		handle_legacy()
	end,
}
