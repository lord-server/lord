local config = require('icicles.config')
local Nodes  = require('icicles.Nodes')
local MapGen = require('icicles.MapGen')


local function register_nodes()
	for _, rock_name in pairs(config.rocks) do
		Nodes.register(rock_name)
	end
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_nodes()
		minetest.register_on_generated(function(min_pos, max_pos, seed)
			MapGen.generate(min_pos, max_pos, seed)
		end)
	end
}
