local Racial = require('chests.Racial')


local chests = {
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	all_nodes = nil,
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	existing_nodes = {},
}

--- @param node_name string technical node name ('<mod>:<node>').
local function add_existing(node_name)
	local definition = minetest.registered_nodes[node_name]
	minetest.override_item(node_name, {
		groups = table.overwrite(definition.groups, { chest = 1 }),
	})
	chests.existing_nodes[node_name] = definition
end


return {
	add_existing     = add_existing,
	racial           = {
		register = Racial.register
	},
	--- @return table<string,NodeDefinition>|NodeDefinition[]
	get_all_nodes    = function()
		if not chests.all_nodes then
			chests.all_nodes = table.merge(Racial.nodes)
		end

		return chests.all_nodes
	end,
	--- @return table<string,NodeDefinition>|NodeDefinition[]
	get_racial_nodes = function() return Racial.nodes end,
}
