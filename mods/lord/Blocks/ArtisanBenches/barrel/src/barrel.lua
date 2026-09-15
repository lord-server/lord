

return {
	--- @param mod core.Mod
	init = function(mod)
		core.CraftMethod.BARREL = 'barrel'
		core.register_craft_method(core.CraftMethod.BARREL)

		require('barrel.nodes')

		core.register_craft({
			output = 'barrel:barrel',
			recipe = {
				{ 'group:wood', 'group:wood', 'group:wood' },
				{ 'group:wood', '', 'group:wood' },
				{ 'group:wood', 'default:steel_ingot', 'group:wood' },
			}
		})
	end
}
