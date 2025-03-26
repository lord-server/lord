local S = minetest.get_mod_translator()


local trunks = {
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	nodes = {}
}

--- @param node_name string technical node name ("<mod>:<node>").
local function add_existing(node_name)
	local definition = minetest.registered_nodes[node_name]
	minetest.override_item(node_name, {
		groups = table.overwrite(definition.groups, { tree = 1 }),
	})
	trunks.nodes[node_name] = definition
end


local young_tree_def_overwrite = {
	drawtype  = "nodebox",
	paramtype = "light",
	node_box  = {
		type  = "fixed",
		fixed = {
			{ -0.125, -0.5, -0.1875, 0.125, 0.5, 0.1875 },
			{ -0.1875, -0.5, -0.125, 0.1875, 0.5, 0.125 },
		},
	},
}

--- @class trees.young_tree_params
--- @field tree_height   number
--- @field leaves_radius number

--- @overload fun(node_name, softness, tree_height, leaves_radius)
--- @param node_name      string technical node name, which ends with 'tree' ("<mod>:<node>tree").
--- @param softness       number how easy to chop this tree. Values [1..3].
--- @param tree_height    number
--- @param leaves_radius  number
--- @param def_override   table|NodeDefinition|nil
--- @param register_young table|trees.young_tree_params|nil
local function register_trunk(node_name, softness, tree_height, leaves_radius, register_young, def_override)
	assert(node_name:contains(":"))
	assert(node_name:ends_with("tree"))
	def_override   = def_override or {}
	register_young = register_young or false
	local texture_side          = node_name:replace(":", "_") .. ".png"
	local texture_top           = node_name:replace(":", "_") .. "_top.png"
	local placed_node_name      = node_name:replace("tree$", "trunk")
	local tree_type             = node_name:split(":")[2]:replace("_tree$", ""):replace("_young$", "")
	local is_young_registration = node_name:ends_with("_young_tree")
	local title                 = (is_young_registration and "Young " or "") .. tree_type:first_to_upper() .. " Trunk"
	-- bin/minetest --info 2>&1 | grep 'use texture'
	minetest.log("info", "use texture: " .. texture_side .. " at " .. __FILE_LINE__())
	minetest.log("info", "use texture: " .. texture_top .. " at " .. __FILE_LINE__())

	local common_definition = table.merge({
		description = S(title),
		tiles       = { texture_top, texture_top, texture_side },
		paramtype2  = "facedir",
		drop        = node_name,
		groups      = { tree = 1, choppy = softness, flammable = 2 },
		sounds      = default.node_sound_wood_defaults(),
		on_place    = minetest.rotate_node,
	}, def_override)

	-- Placed tree trunk (no affect to leaves decay)
	minetest.register_node(placed_node_name, table.merge(common_definition, {
		description = S("Placed " .. title),
		drop        = node_name,
		on_place    = minetest.rotate_node,
	}))

	-- Growing tree, also in inventory, uses for crafting, ...
	minetest.register_node(node_name, table.merge(common_definition, {
		on_dig      = function(pos, node, digger)
			default.dig_tree(pos, node, node_name, digger, tree_height, leaves_radius)
		end,
		on_place = function(itemstack, placer, pointed_thing)
			return default.place_tree(itemstack, placer, pointed_thing, placed_node_name)
		end,
	}))

	if not is_young_registration then
		trunks.nodes[node_name] = minetest.registered_nodes[node_name]
	end

	if register_young then
		register_trunk(
			node_name:replace("_tree$", "_young_tree"),
			softness,
			register_young.tree_height,
			register_young.leaves_radius,
			nil,
			table.merge(young_tree_def_overwrite, {	tiles = { texture_top, texture_top, texture_side } })
		)
	end
end

register_trunk("lord_trees:alder_tree",			2, 10, 2)
register_trunk("lord_trees:beech_tree",			2, 15, 4)
register_trunk("lord_trees:birch_tree",			3, 12, 3)
register_trunk("lord_trees:cherry_tree",		2, 10, 2)
register_trunk("lord_trees:culumalda_tree",		2, 10, 2)
register_trunk("lord_trees:elm_tree",			2, 25, 2)
register_trunk("lord_trees:fir_tree",			3, 13, 2)
register_trunk("lord_trees:lebethron_tree",		1, 10, 2)
register_trunk("lord_trees:mallorn_tree",		1, 30, 5, { tree_height = 10, leaves_radius = 1 })
register_trunk("lord_trees:pine_tree",			3, 13, 2)
register_trunk("lord_trees:plum_tree",			3, 6,  2)
register_trunk("lord_trees:white_tree",			3, 12, 3)
register_trunk("lord_trees:yavannamire_tree",	3, 12, 3)


return {
	add_existing = add_existing,
	register     = register_trunk,
	--- @return NodeDefinition[]
	get_nodes    = function() return trunks.nodes end
}
