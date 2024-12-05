

return {
	--- @param mod minetest.Mod
	init = function(mod)
		minetest.CraftMethod.POTION = 'potion'
		minetest.register_craft_method(minetest.CraftMethod.POTION)

		require('laboratory.nodes')

		minetest.register_craft({
			output = 'laboratory:laboratory',
			recipe = {
				{ 'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot' },
				{ '', 'default:steel_ingot', '' },
				{ 'group:stone', 'group:stone', 'group:stone' },
			}
		})
	end
}
