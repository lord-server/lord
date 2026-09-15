local node = require("reward_chest.node")


return {
	init = function()
		core.register_node('quest_node:reward_chest', node.definition);
	end
}
