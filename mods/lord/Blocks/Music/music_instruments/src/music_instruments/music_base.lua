local config = require('music_instruments.music_node.config')
local def = config.base


local function register_base()
	core.register_node('music_instruments:base', {
		description = def.title,
		_tt_help = def.description and core.colorize('#aaa',  '\n' .. def.description),
		drawtype = def.drawtype,
		mesh = def.mesh,
		tiles = def.tiles,
		paramtype = def.paramtype,
		paramtype2 = def.paramtype2,
		groups = { choppy = 2, forbidden = 1 },
	})

	core.register_craft({
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
