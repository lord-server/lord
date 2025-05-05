-- описание нод
local table_merge = table.merge

local nodes = require('ancient_miners.nodes')


-- регистрируем ноды
return {
	init = function()
		minetest.register_node('remains:ancient_miner_mapgen_1', table_merge(
			nodes.common_definition,
			nodes.ancient_miner_mapgen_1))

		minetest.register_node('remains:ancient_miner_mapgen_2', table_merge(
			nodes.common_definition,
			nodes.ancient_miner_mapgen_2))

		minetest.register_node('remains:ancient_miner', table_merge(
			nodes.common_definition,
			nodes.ancient_miner))

		minetest.register_node('remains:ancient_miner_1', table_merge(
			nodes.common_definition,
			nodes.ancient_miner_1))

		minetest.register_node('remains:ancient_miner_2', table_merge(
			nodes.common_definition,
			nodes.ancient_miner_2))
	end
}
