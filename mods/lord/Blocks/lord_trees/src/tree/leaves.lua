local S = minetest.get_translator("lord_trees")


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
--- @param groups          table  additional or overwrite groups (default: {choppy = hardness, flammable = 3, wood = 1})
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

register_leaf("lord_trees:alderleaf",     "Alder Leaf", { color_green = 1 }) -- also drops lord_trees:aldersapling
register_leaf("lord_trees:appleleaf",     "Fruitful Apple Leaf", { color_green = 1 }) -- drops lord_trees:applesapling
register_leaf("lord_trees:birchleaf",     "Birch Leaf", { color_green = 1 }) -- also drops lord_trees:birchsapling
register_leaf("lord_trees:beechleaf",     "Beech Leaf", { color_green = 1 }) -- drops lord_trees:beechsapling
register_leaf("lord_trees:cherryleaf",    "Cherry Leaf", { color_pink = 1 }) -- also drops lord_trees:cherrysapling
register_leaf("lord_trees:culumaldaleaf", "Culumalda Leaf", { color_red = 1 }) -- also drops lord_trees:culumaldasapling
register_leaf("lord_trees:yellowflowers", "Yellow Flowers on Culumalda Leaf", { color_orange = 1 }, {
	max_items = 3,
	items     = { { items = { 'lord_trees:yellowflowers' } }, }
})
register_leaf("lord_trees:elmleaf",       "Elm Leaf", { color_green = 1 }) -- also drops lord_trees:elmsapling
register_leaf("lord_trees:firleaf",       "Fir Leaf", { color_green = 1 }) -- also drops lord_trees:firsapling
register_leaf("lord_trees:lebethronleaf", "Lebethron Leaf", { color_green = 1 })--also drops lord_trees:lebethronsapling
register_leaf("lord_trees:mallornleaf",   "Mallorn Leaf", { color_yellow = 1 }) -- also drops lord_trees:mallornsapling
register_leaf("lord_trees:pineleaf",      "Pine Leaf", { color_green = 1 }) -- also drops lord_trees:pinesapling
register_leaf("lord_trees:plumleaf",      "Plum Leaf", { color_green = 1 }) -- also drops lord_trees:plumsapling
register_leaf("lord_trees:rowanleaf",     "Rowan Leaf", { color_yellow = 1 }) -- also drops lord_trees:rowansapling
register_leaf("lord_trees:rowanberry",    "Rowan Leaf with Berries", {}, {
	max_items = 2,
	items     = {
		{ items = { 'lord_trees:rowanleaf' } },
		{ items = { 'lottfarming:berries' } },
	}
})
register_leaf("lord_trees:whiteleaf",       "White", { color_white = 1 }) -- also drops lord_trees:whitesapling
register_leaf("lord_trees:yavannamireleaf", "Yavannamire", { color_green = 1 }) -- drops lord_trees:yavannamiresapling
register_leaf("lord_trees:mirkleaf",        "Mirkwood", { color_green = 1 }) -- also drops lord_trees:mirksapling
minetest.register_alias("lottmapgen:mirkleaves", "lord_trees:mirkleaf")

return {
	add_existing = add_existing,
	register     = register_leaf,
	get_nodes    = function() return leaves.nodes end
}
