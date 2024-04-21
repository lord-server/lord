local S = minetest.get_translator("lord_trees")

local Generator = require("tree.Generator")

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

			-- TODO # 661
			--local max_radius = 10
			--local max_height = 50
			--
			--local pos1 = vector.offset(pos, -max_radius,          0, max_radius)
			--local pos2 = vector.offset(pos, -max_radius, max_height, max_radius)
			--minetest.with_map_part_do(pos1, pos2, function(area, data)
				local tree_gen = Generator:new(grow_function)--, area, data)
				tree_gen:generate_tree(pos)
			--end)

			print("[lord_trees] " .. title .. " Grows")
		end,
	})
end

register_sapling("lord_trees:alder_sapling", "Alder", lottplants_aldertree)
register_sapling("lord_trees:apple_sapling", "Fruitful Apple Tree", lottplants_appletree)
register_sapling("lord_trees:birch_sapling", "Birch", lottplants_birchtree)
register_sapling("lord_trees:beech_sapling", "Beech", lottplants_beechtree)
register_sapling("lord_trees:cherry_sapling", "Cherry", lottplants_cherrytree)
register_sapling("lord_trees:culumalda_sapling", "Culumalda", lottplants_culumaldatree)
register_sapling("lord_trees:elm_sapling", "Elm", lottplants_elmtree)
register_sapling("lord_trees:fir_sapling", "Fir", lottplants_firtree)
register_sapling("lord_trees:lebethron_sapling", "Lebethron", lottplants_lebethrontree)
register_sapling("lord_trees:mallorn_sapling", "Mallorn", {
	lottplants_mallorntree, lottplants_smallmallorntree, lottplants_young_mallorn
})
register_sapling("lord_trees:pine_sapling", "Pine", lottplants_pinetree)
register_sapling("lord_trees:plum_sapling", "Plum Tree", lottplants_plumtree)
register_sapling("lord_trees:rowan_sapling", "Rowan", lottplants_rowantree)
register_sapling("lord_trees:white_sapling", "White Tree", lottplants_whitetree)
register_sapling("lord_trees:yavannamire_sapling", "Yavannamire", lottplants_yavannamiretree)
register_sapling("lord_trees:mirk_sapling", "Mirkwood", { lottplants_mirktree, lottplants_smallmirktree })

return {
	add_existing = add_existing,
	register     = register_sapling,
	get_nodes    = function() return saplings.nodes end
}
