local Nodes  = require('icicles.Nodes')
local MapGen = require('icicles.MapGen')


local except = { 'lord_rocks:mordor_stone' }

local function register_nodes()
	Nodes.register('default:stone')

	for rock_name, _ in pairs(rocks.get_lord_rocks()) do
		if not except[rock_name] then
			Nodes.register(rock_name)
		end
	end
end


return {
	--- @param mod minetest.Mod
	init = function(mod)
		register_nodes()
		minetest.register_on_generated(function(min_pos, max_pos, seed)
			MapGen.generate(min_pos, max_pos, seed, 1/8, 1, -31000, -200)
		end)
	end
}
