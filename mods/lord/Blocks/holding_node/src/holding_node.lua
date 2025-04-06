local node = require('holding_node.node')


holding_node = {} -- luacheck: ignore unused global variable holding_node

local function register_node()
	minetest.register_node('holding_node:holding_node', node.definition)
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_node()
	end,
}
