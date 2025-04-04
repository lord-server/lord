local api    = require('holding_node.api')
local config = require('holding_node.config')


holding_node = {} -- luacheck: ignore unused global variable holding_node

local function register_api()
	_G.holding_node = api
end

local function register_node()
	minetest.register_node('holding_node:holding_node', {})
end

return {
--- @param mod minetest.Mod
	init = function(mod)
		register_api()
		register_node()
	end,
}
