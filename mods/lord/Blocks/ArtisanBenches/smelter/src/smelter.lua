

return {
	--- @param mod minetest.Mod
	init = function(mod)
		minetest.CraftMethod.SMELTER = 'smelter'
		minetest.register_craft_method(minetest.CraftMethod.SMELTER)

		require('smelter.nodes')

		minetest.register_craft({
			output = 'smelter:smelter1',
			recipe = {
				{ '', '', '' },
				{ '', 'castle:hole_cobble', '' },
				{ '', 'default:furnace', '' },
			}
		})
	end
}
