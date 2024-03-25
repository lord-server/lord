local S = minetest.get_translator("lottplants")


local SAPLING_GROW_ABM_INTERVAL = 67
local SAPLING_GROW_ABM_CHANCE   = 11

local saplings = {
	--- @type table<string,NodeDefinition>|NodeDefinition[]
	nodes = {}
}

--- @param node_name string technical node name ("<mod>:<node>").
local function add_existing(node_name)
	local definition = minetest.registered_nodes[node_name]
	minetest.override_item(node_name, {
		groups = table.overwrite(definition.groups, { sapling = 1 }),
	})
	saplings.nodes[node_name] = definition
end

--- @param node_name     string                                            technical node name ("<mod>:<node>").
--- @param title         string                                            will be added to description of nodes.
--- @param grow_function fun(pos:Position)|table<number,fun(pos:Position)> function how to grow into a tree.
local function register_sapling(node_name, title, grow_function)
	title         = title:first_to_upper()
	local texture = node_name:replace(":", "_") .. ".png"
	-- bin/minetest --info 2>&1 | grep 'use texture'
	minetest.log("info", "use texture: " .. texture .. " at " .. __FILE_LINE__())

	minetest.register_node(node_name, {
		description     = S(title .. " Sapling"),
		drawtype        = "plantlike",
		visual_scale    = 1.0,
		tiles           = { texture },
		inventory_image = texture,
		wield_image     = texture,
		paramtype       = "light",
		waving          = 1,
		walkable        = false,
		selection_box     = {
			type  = "fixed",
			fixed = { -0.2, -0.5, -0.2, 0.2, 0.3, 0.2 },
		},
		groups          = { snappy = 2, dig_immediate = 3, flammable = 2, sapling = 1 },
		sounds          = default.node_sound_defaults(),
	})

	saplings.nodes[node_name] = minetest.registered_nodes[node_name]

	minetest.register_abm({
		nodenames = { node_name },
		interval  = SAPLING_GROW_ABM_INTERVAL,
		chance    = SAPLING_GROW_ABM_CHANCE,
		action    = function(pos, node, active_object_count, active_object_count_wider)
			if not default.can_grow(pos) then
				return
			end

			if type(grow_function) == "table" then
				grow_function[math.random(#grow_function)](pos)
			else
				grow_function(pos)
			end

			print("[lottplants] " .. title .. " Grows")
		end,
	})
end

register_sapling("lottplants:aldersapling", "Alder", lottplants_aldertree)
register_sapling("lottplants:applesapling", "Fruitful Apple Tree", lottplants_appletree)
register_sapling("lottplants:birchsapling", "Birch", lottplants_birchtree)
register_sapling("lottplants:beechsapling", "Beech", lottplants_beechtree)
register_sapling("lottplants:culumaldasapling", "Culumalda", lottplants_culumaldatree)
register_sapling("lottplants:elmsapling", "Elm", lottplants_elmtree)
register_sapling("lottplants:firsapling", "Fir", lottplants_firtree)
register_sapling("lottplants:lebethronsapling", "Lebethron", lottplants_lebethrontree)
register_sapling("lottplants:mallornsapling", "Mallorn", {
	lottplants_mallorntree, lottplants_smallmallorntree, lottplants_young_mallorn
})
register_sapling("lottplants:pinesapling", "Pine", lottplants_pinetree)
register_sapling("lottplants:plumsapling", "Plum Tree", lottplants_plumtree)
register_sapling("lottplants:rowansapling", "Rowan", lottplants_rowantree)
register_sapling("lottplants:whitesapling", "White Tree", lottplants_whitetree)
register_sapling("lottplants:yavannamiresapling", "Yavannamire", lottplants_yavannamiretree)
register_sapling("lottplants:mirksapling", "Mirkwood", { lottplants_mirktree, lottplants_smallmirktree })

return {
	add_existing = add_existing,
	register     = register_sapling,
	get_nodes    = function() return saplings.nodes end
}
