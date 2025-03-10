local S = minetest.get_mod_translator()

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
	"lord_trees:alder_tree", "lord_trees:beech_tree", "lord_trees:birch_tree", "lord_trees:fir_tree",
	"lord_trees:lebethron_tree",	"lord_trees:mallorn_tree", "lord_trees:mallorn_young_tree", "lord_trees:pine_tree",
	"lord_trees:elm_tree", "lord_trees:plum_tree",
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


worldedit.register_command('find_entity', {
	params      = "",
	description = S(""),
	privs       = { worldedit = true },
	require_pos = 2,
	--- @param param string
	parse = function(param)
		local entity_name = param:replace(' ', '')
		if entity_name == '' then
			return false, S("invalid entity name: @1", param)
		end
		return true, entity_name
	end,
	--- @param name        string player name.
	--- @param entity_name string parsed first command param.
	func        = function(name, entity_name)
		local pos1 = vector.add(worldedit.pos1[name], -0.5)
		local pos2 = vector.add(worldedit.pos2[name], 0.5)

		pos1, pos2 = worldedit.sort_pos(pos1, pos2)
		worldedit.keep_loaded(pos1, pos2)

		local count = 0
		local objects = minetest.get_objects_in_area(pos1, pos2)
		for _, obj in pairs(objects) do
			if not obj:is_player() then
				if obj:get_entity_name() == entity_name then
					worldedit.player_notify(name, obj:get_entity_name() .. ' at ' .. core.pos_to_string(obj:get_pos()))
					count = count + 1
				end
			end
		end

		worldedit.player_notify(name, S("@1 entities found", count))
	end
})
