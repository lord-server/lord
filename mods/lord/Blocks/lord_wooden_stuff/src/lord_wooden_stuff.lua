local api    = require("lord_wooden_stuff.api")
local config = require("lord_wooden_stuff.config")

local function register_api()
	_G.lord_wooden_stuff = api
end

local function register_lord_wooden_stuff()
	for _, wood_def in ipairs(config.wood_defs) do
		local name_postfix = wood_def[1]
		local desc_prefix = wood_def[2]
		local planks_texture = wood_def[3]
		local planks_name = wood_def[4]
		api.register_wooden_stuff(name_postfix, desc_prefix, planks_texture, planks_name)
	end
end

return {
	init = function()
		register_api()
		register_lord_wooden_stuff()
	end,
}
