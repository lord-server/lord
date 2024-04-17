local S = minetest.get_translator("lottplants")


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

register_leaf("lottplants:alderleaf",     "Alder Leaf", { color_green = 1 }) -- also drops lottplants:aldersapling
register_leaf("lottplants:appleleaf",     "Fruitful Apple Leaf", { color_green = 1 }) -- drops lottplants:applesapling
register_leaf("lottplants:birchleaf",     "Birch Leaf", { color_green = 1 }) -- also drops lottplants:birchsapling
register_leaf("lottplants:beechleaf",     "Beech Leaf", { color_green = 1 }) -- drops lottplants:beechsapling
register_leaf("lottplants:cherryleaf",    "Cherry Leaf", { color_pink = 1 }) -- also drops lottplants:cherrysapling
register_leaf("lottplants:culumaldaleaf", "Culumalda Leaf", { color_red = 1 }) -- also drops lottplants:culumaldasapling
register_leaf("lottplants:yellowflowers", "Yellow Flowers on Culumalda Leaf", { color_orange = 1 }, {
	max_items = 3,
	items     = { { items = { 'lottplants:yellowflowers' } }, }
})
register_leaf("lottplants:elmleaf",       "Elm Leaf", { color_green = 1 }) -- also drops lottplants:elmsapling
register_leaf("lottplants:firleaf",       "Fir Leaf", { color_green = 1 }) -- also drops lottplants:firsapling
register_leaf("lottplants:lebethronleaf", "Lebethron Leaf", { color_green = 1 })--also drops lottplants:lebethronsapling
register_leaf("lottplants:mallornleaf",   "Mallorn Leaf", { color_yellow = 1 }) -- also drops lottplants:mallornsapling
register_leaf("lottplants:pineleaf",      "Pine Leaf", { color_green = 1 }) -- also drops lottplants:pinesapling
register_leaf("lottplants:plumleaf",      "Plum Leaf", { color_green = 1 }) -- also drops lottplants:plumsapling
register_leaf("lottplants:rowanleaf",     "Rowan Leaf", { color_yellow = 1 }) -- also drops lottplants:rowansapling
register_leaf("lottplants:rowanberry",    "Rowan Leaf with Berries", {}, {
	max_items = 2,
	items     = {
		{ items = { 'lottplants:rowanleaf' } },
		{ items = { 'lottfarming:berries' } },
	}
})
register_leaf("lottplants:whiteleaf",       "White", { color_white = 1 }) -- also drops lottplants:whitesapling
register_leaf("lottplants:yavannamireleaf", "Yavannamire", { color_green = 1 }) -- drops lottplants:yavannamiresapling
register_leaf("lottplants:mirkleaf",        "Mirkwood", { color_green = 1 }) -- also drops lottplants:mirksapling
minetest.register_alias("lottmapgen:mirkleaves", "lottplants:mirkleaf")

return {
	add_existing = add_existing,
	register     = register_leaf,
	get_nodes    = function() return leaves.nodes end
}
