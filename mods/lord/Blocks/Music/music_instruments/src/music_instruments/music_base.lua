local S = minetest.get_mod_translator()

local function register_base()
	minetest.register_node('music_instruments:base', {
		description =   S('Musical instrument base') .. '\n' ..
						S('A stone plucked from the embrace of subterranean horrors') .. '\n' ..
						S('and a tree liberated from the elves') .. '\n' ..
						S('They are now the basis for melodies') .. '\n' ..
						S('that can melt hearts...') .. '\n' ..
						S('or exorcise nazguls'),
		drawtype = 'mesh',
		mesh = 'music_instruments_base.obj',
		tiles = {
			'lord_rocks_peridotite.png',
			'lord_trees_yavannamire_tree.png',
			'lord_trees_yavannamire_tree_top.png',
		},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = { choppy = 2, forbidden = 1 },
	})

	minetest.register_craft({
		output = 'music_instruments:base',
		recipe = {
			{'lord_rocks:peridotite', 'lord_rocks:peridotite', 'lord_rocks:peridotite', },
			{'lord_rocks:peridotite', 'lord_trees:yavannamire_tree', 'lord_rocks:peridotite', },
			{'lord_rocks:peridotite', 'lord_rocks:peridotite', 'lord_rocks:peridotite', }
		}
	})
end


return {
	register = register_base,
}
