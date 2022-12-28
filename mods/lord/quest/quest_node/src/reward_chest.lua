local node = require("reward_chest.node")


local function register()
	minetest.register_node('quest_node:reward_chest', node.definition);
	minetest.register_on_player_receive_fields(node.form_handler)
end


return {
	init = function()
		register()
	end
}
