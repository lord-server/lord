

return {
	--- @param mod minetest.Mod
	init = function(mod)
		minetest.CraftMethod.BARREL = 'barrel'
		minetest.register_craft_method(minetest.CraftMethod.BARREL)

		require('barrel.nodes')

		minetest.register_craft({
			output = 'barrel:barrel',
			recipe = {
				{ 'group:wood', 'group:wood', 'group:wood' },
				{ 'group:wood', '', 'group:wood' },
				{ 'group:wood', 'default:steel_ingot', 'group:wood' },
			}
		})
	end
}
