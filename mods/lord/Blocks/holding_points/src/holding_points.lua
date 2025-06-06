local node     = require('holding_points.node')


holding_points = {} -- luacheck: ignore unused global variable holding_points

local function register_node()
	minetest.register_node('holding_points:node', node.definition)
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_node()
	end,
}
