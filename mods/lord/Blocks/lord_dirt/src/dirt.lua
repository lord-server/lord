local api    = require("dirt.api")
local config = require("dirt.config")

local function register_api()
	_G.dirts = api
end

local function register_lord_dirts()
	--- Also we use:
	---  - Simple dirt from MTG (`default:dirt`)
	---  - ... from MTG (`default:...`)
	api.add_existing("default:dirt")
	--api.add_existing("default:")
	for name, dirt in pairs(config) do
		dirt.softness   = dirt.softness or 1
		dirt.definition = dirt.definition or {}
		api.register_dirt(name, dirt.softness, dirt.definition)
	end
end


return {
	init = function()
		register_api()
		register_lord_dirts()
	end,
}
