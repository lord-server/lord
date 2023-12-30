local node = require("chest.node")


local function register()
	minetest.register_node("clan_node:chest", node.definition)
	minetest.register_on_player_receive_fields(node.form_handler)
	minetest.register_craft({
		output = "clan_node:chest",
		recipe = {
			{"farming:string", "default:chest", "farming:string"}
		},
	})
end


return {
	init = function()
		register()
	end
}
