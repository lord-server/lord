

return {
	--- @param mod core.Mod
	init = function(mod)
		core.CraftMethod.POTION = 'potion'
		core.register_craft_method(core.CraftMethod.POTION)

		require('laboratory.nodes')

		core.register_craft({
			output = 'laboratory:laboratory',
			recipe = {
				{ 'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot' },
				{ '', 'default:steel_ingot', '' },
				{ 'group:stone', 'group:stone', 'group:stone' },
			}
		})
	end
}
