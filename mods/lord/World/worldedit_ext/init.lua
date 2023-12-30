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
