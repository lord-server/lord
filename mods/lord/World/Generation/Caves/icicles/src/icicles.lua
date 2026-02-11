local config = require('icicles.config')
local Nodes  = require('icicles.Nodes')
local MapGen = require('icicles.MapGen')


--- Register icicle nodes and return ids of them.
--- @return integer[string]
local function register_nodes()
	local icicles_ids = {}
	for _, rock_name in pairs(config.rocks) do
		local ids = Nodes.register(rock_name)
		icicles_ids = table.merge(icicles_ids, ids)
	end

	return icicles_ids
end


return {
	--- @param mod minetest.Mod
	init = function(mod)

		MapGen.id_icicle = register_nodes()

		core.register_on_generated(function(min_pos, max_pos, seed)
			mod:measure('Icicles Gen', function()
				core.with_map_part_do(min_pos, max_pos, function(area, data)
					MapGen:new(area, data):generate(min_pos, max_pos, seed)
				end, true, true)
			end)
		end)
	end
}
