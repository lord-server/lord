local S = minetest.get_mod_translator()


local leaves = {
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	nodes = {}
}

--- @param node_name string technical node name ("<mod>:<node>").
local function add_existing(node_name)
	local definition = minetest.registered_nodes[node_name]
	minetest.override_item(node_name, {
		groups = table.overwrite(definition.groups, { leaves = 1 }),
	})
	leaves.nodes[node_name] = definition
end

--- @overload fun(node_name:string, title:string)
--- @overload fun(node_name:string, title:string, groups:table)
--- @overload fun(node_name:string, title:string, groups:table, sapling_or_drop:string|table)
--- @param node_name       string technical node name ("<mod>:<node>").
--- @param title           string for human; not translated description of node.
--- @param groups          table  additional or overwrite groups
---                               (default: {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1})
--- @param sapling_or_drop string technical node/item name string of sapling to drop or drop table
local function register_leaf(node_name, title, groups, sapling_or_drop)
	title               = title:first_to_upper()
	groups              = groups or {}
	sapling_or_drop     = sapling_or_drop or node_name:replace("leaf", "sapling")
	local texture       = node_name:replace(":", "_") .. ".png"
	local inventory_img = node_name:replace(":", "_") .. "_inv.png"
	local drop          = type(sapling_or_drop) == "table"
		and sapling_or_drop
		or {
			max_items = 1,
			items     = {
				{ items = { sapling_or_drop }, rarity = 20, },
				{ items = { node_name }, }
			}
		}
	-- bin/minetest --info 2>&1 | grep 'use texture'
	minetest.log("info", "use texture: " .. texture .. " at " .. __FILE_LINE__())

	minetest.register_node(node_name, {
		description                = S(title),
		drawtype                   = "mesh",
		mesh                       = "leaves_model.obj",
		tiles                      = { texture },
		use_texture_alpha          = "clip",
		inventory_image            = inventory_img,
		paramtype                  = "light",
		waving                     = 2,
		walkable                   = false,
		liquid_viscosity           = 8,
		liquidtype                 = "source",
		liquid_alternative_flowing = node_name,
		liquid_alternative_source  = node_name,
		liquid_renewable           = false,
		liquid_range               = 0,
		groups                     = table.merge({ snappy = 3, leafdecay = 3, flammable = 2, leaves = 1 }, groups),
		drop                       = drop,
		sounds                     = default.node_sound_leaves_defaults(),
	})

	leaves.nodes[node_name] = minetest.registered_nodes[node_name]
end

register_leaf("lord_trees:alder_leaf",     "Alder Leaf", { color_green = 1 }) -- also drops lord_trees:alder_sapling
register_leaf("lord_trees:apple_leaf",     "Fruitful Apple Leaf", { color_green = 1 }) -- drops lord_trees:apple_sapling
register_leaf("lord_trees:birch_leaf",     "Birch Leaf", { color_green = 1 }) -- also drops lord_trees:birch_sapling
register_leaf("lord_trees:beech_leaf",     "Beech Leaf", { color_green = 1 }) -- drops lord_trees:beech_sapling
register_leaf("lord_trees:cherry_leaf",    "Cherry Leaf", { color_pink = 1 }) -- also drops lord_trees:cherry_sapling
register_leaf("lord_trees:culumalda_leaf", "Culumalda Leaf", { color_red = 1 }) -- drops lord_trees:culumalda_sapling
register_leaf("lord_trees:yellow_flowers", "Yellow Flowers on Culumalda Leaf", { color_orange = 1 }, {
	max_items = 3,
	items     = { { items = { 'lord_trees:yellow_flowers' } }, }
})
register_leaf("lord_trees:elm_leaf",       "Elm Leaf", { color_green = 1 })   -- also drops lord_trees:elm_sapling
register_leaf("lord_trees:fir_leaf",       "Fir Leaf", { color_green = 1 })   -- also drops lord_trees:fir_sapling
register_leaf("lord_trees:lebethron_leaf", "Lebethron Leaf", { color_green = 1 })  -- drops lord_trees:lebethron_sapling
register_leaf("lord_trees:mallorn_leaf",   "Mallorn Leaf", { color_yellow = 1 })   -- drops lord_trees:mallorn_sapling
register_leaf("lord_trees:pine_leaf",      "Pine Leaf", { color_green = 1 })  -- also drops lord_trees:pine_sapling
register_leaf("lord_trees:plum_leaf",      "Plum Leaf", { color_green = 1 })  -- also drops lord_trees:plum_sapling
register_leaf("lord_trees:rowan_leaf",     "Rowan Leaf", { color_yellow = 1 })-- also drops lord_trees:rowan_sapling
register_leaf("lord_trees:rowan_berry",    "Rowan Leaf with Berries", {}, {
	max_items = 2,
	items     = {
		{ items = { 'lord_trees:rowan_leaf' } },
		{ items = { 'lottfarming:berries' } },
	}
})
register_leaf("lord_trees:white_leaf",       "White", { color_white = 1 }) -- also drops lord_trees:white_sapling
register_leaf("lord_trees:yavannamire_leaf", "Yavannamire", { color_green = 1 }) -- drops lord_trees:yavannamire_sapling
register_leaf("lord_trees:mirk_leaf",        "Mirkwood", { color_green = 1 }) -- also drops lord_trees:mirk_sapling

return {
	add_existing = add_existing,
	register     = register_leaf,
	--- @return NodeDefinition[]
	get_nodes    = function() return leaves.nodes end
}
