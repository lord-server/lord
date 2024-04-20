local S = minetest.get_translator("worldedit_ext")

worldedit.register_command('select_chunks', {
	params      = "",
	description = S(
		"Sets WorldEdit region positions to chunk(s) corners " ..
		"according to current selection marker(s) and/or player position."
	),
	privs       = { worldedit = true },
	func        = function(name)
		local player_pos = minetest.get_player_by_name(name):get_pos()

		local pos1 = worldedit.pos1[name] or player_pos
		local pos2 = worldedit.pos2[name] or player_pos
		pos1, pos2 = worldedit.sort_pos(pos1, pos2)

		pos1 = vector.floor(pos1 / 80) * 80
		pos2 = vector.floor(pos2 / 80) * 80
		pos2 = vector.add(pos2, 79)

		worldedit.pos1[name] = pos1
		worldedit.pos2[name] = pos2
		worldedit.mark_pos1(name)
		worldedit.mark_pos2(name)
	end,
})

worldedit.alias_command('sc', 'select_chunks')



local trees_nodes = {
	"default:tree", "default:jungletree", "default:leaves", "default:apple", "lord_trees:plum",
	"lord_trees:aldertree", "lord_trees:beechtree", "lord_trees:birchtree", "lord_trees:firtree",
	"lord_trees:lebethrontree",	"lord_trees:mallorntree", "lord_trees:mallorntree_young", "lord_trees:pinetree",
	"lord_trees:elmtree",
	"lord_trees:alder_leaf", "lord_trees:apple_leaf", "lord_trees:beech_leaf", "lord_trees:birch_leaf",
	"lord_trees:culumalda_leaf", "lord_trees:elm_leaf", "lord_trees:fir_leaf", "lord_trees:lebethron_leaf",
	"lord_trees:mallorn_leaf", "lord_trees:mirk_leaf", "lord_trees:pine_leaf", "lord_trees:plum_leaf",
	"lord_trees:rowan_berry", "lord_trees:rowan_leaf", "lord_trees:white_leaf", "lord_trees:yavannamire_leaf",
	"lord_trees:yellow_flowers",
}
worldedit.register_command('clear_trees', {
	params      = "",
	description = S(""),
	privs       = { worldedit = true },
	require_pos = 2,
	func        = function(name)
		local count = 0
		for _, search_node_name in pairs(trees_nodes) do
			count = count + worldedit.replace(worldedit.pos1[name], worldedit.pos2[name], search_node_name, "air")
		end
		worldedit.player_notify(name, S("@1 nodes replaced", count))
	end
})
