local node = require('chest.node')


local function register()
	core.register_node('clan_node:chest', node.definition)
	core.register_on_player_receive_fields(node.form_handler)
	core.register_craft({
		output = 'clan_node:chest',
		recipe = {
			{'farming:string', 'default:chest', 'farming:string'}
		},
	})
end

local function add_as_existing()
	core.register_on_mods_loaded(function()
		if not core.global_exists('chests') then
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
