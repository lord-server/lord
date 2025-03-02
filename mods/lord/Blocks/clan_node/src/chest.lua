local node = require('chest.node')


local function register()
	minetest.register_node('clan_node:chest', node.definition)
	minetest.register_on_player_receive_fields(node.form_handler)
	minetest.register_craft({
		output = 'clan_node:chest',
		recipe = {
			{'farming:string', 'default:chest', 'farming:string'}
		},
	})
end

local function add_as_existing()
	minetest.register_on_mods_loaded(function()
		if not minetest.global_exists('chests') then
			return
		end
		chests.add_existing('clan_node:chest')
	end)
end


return {
	init = function()
		register()
		add_as_existing()
	end
}
