
local nodes = require('smelter.nodes')
local Form  = require('smelter.nodes.Form')
local S     = minetest.get_mod_translator()

return {
	--- @param mod minetest.Mod
	init = function(mod)
		minetest.CraftMethod.SMELTER = 'smelter'
		minetest.register_craft_method(minetest.CraftMethod.SMELTER)

		fuel_device.register(
			S('Smelter'),
			minetest.CraftMethod.SMELTER,
			{
				inactive = {
					node_name  = 'smelter:smelter1',
					definition = table.merge(nodes, {
					tiles      = {'smelter1_inactive.png'},
					}),
				},
				active   = {
					node_name  = 'smelter:smelter1_active',
					definition = table.merge(nodes, {
						tiles  = {'smelter1_active.png'},
						light_source = 3,
						drop         = 'smelter:smelter1',
						groups       = { not_in_creative_inventory = 1 },
					}),
				}
			},
			Form,
			{ src = 2, dst = 4 }
		)

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
