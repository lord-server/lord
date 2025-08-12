local trunks = require('tree.trunks')


local INFECTED_TRUNKS_GROUP = 'infected'

--- @param parent_node_name string  technical name of not infected tree, which ends with 'tree' ("<mod>:<node>tree").
--- @param tree_height      number
--- @param leaves_radius    number
--- @param register_young   boolean
--- @param def_override     table
local function register_infected_trunk(parent_node_name, tree_height, leaves_radius, register_young, def_override)
	local parent_tree_definition = trunks.get_nodes()[parent_node_name]
	assert(
		parent_tree_definition,
		'Parent tree trunk must be registered: use `tree.trunk.register()` or `tree.trunk.add_existing()`'
	)

	local node_name = parent_node_name
	-- @legacy
	if node_name == 'default:tree'       then  node_name = 'lord_trees:apple_tree' end
	if node_name == 'default:jungletree' then  node_name = 'lord_trees:mirk_tree'  end
	-- /@legacy
	node_name    = node_name:replace(':', ':infected_')

	local softness     = parent_tree_definition.groups.choppy
	local texture_side = parent_node_name:replace(':', '_') .. '.png^lord_trees_infected_side_overlay.png'
	local texture_top  = parent_node_name:replace(':', '_') .. '_top.png^lord_trees_infected_top_overlay.png'

	node_name = not node_name:starts_with('lord_trees:') and ':' .. node_name or node_name
	trunks.register(node_name, softness, tree_height, leaves_radius, register_young, {
		tiles             = { texture_top, texture_top, texture_side .. '^lord_trees_infected_side_overlay.png' },
		groups            = { infected_tree = 1 },
		_is_infected      = true,
		_parent_node_name = parent_node_name,
	}, INFECTED_TRUNKS_GROUP)
end

-- lord_trees:infected_alder_tree       | lord_trees:infected_alder_trunk
-- lord_trees:infected_beech_tree       | lord_trees:infected_beech_trunk
-- lord_trees:infected_birch_tree       | lord_trees:infected_birch_trunk
-- lord_trees:infected_cherry_tree      | lord_trees:infected_cherry_trunk
-- lord_trees:infected_culumalda_tree   | lord_trees:infected_culumalda_trunk
-- lord_trees:infected_elm_tree         | lord_trees:infected_elm_trunk
-- lord_trees:infected_fir_tree         | lord_trees:infected_fir_trunk
-- lord_trees:infected_lebethron_tree   | lord_trees:infected_lebethron_trunk
-- lord_trees:infected_mallorn_tree     | lord_trees:infected_mallorn_trunk
-- lord_trees:infected_pine_tree        | lord_trees:infected_pine_trunk
-- lord_trees:infected_plum_tree        | lord_trees:infected_plum_trunk
-- lord_trees:infected_white_tree       | lord_trees:infected_white_trunk
-- lord_trees:infected_yavannamire_tree | lord_trees:infected_yavannamire_trunk
for node_name, trunk_definition in pairs(trunks.get_nodes()) do
	register_infected_trunk(node_name, trunk_definition._tree_height, trunk_definition._leaves_radius)
end


return {
	register = register_infected_trunk
}
