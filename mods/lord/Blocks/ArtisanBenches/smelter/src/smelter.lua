
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
						tiles  = {
							'smelter1_inactive.png',
							'smelter1_front_inactive_flame.png',
						},
					}),
				},
				active   = {
					node_name  = 'smelter:smelter1_active',
					definition = table.merge(nodes, {
						tiles = { 'smelter1_active.png',{
								name = 'smelter1_front_active_flame.png',
								animation = {
									type = "vertical_frames",
									aspect_w = 16,
									aspect_h = 16,
									length = 2.0,
								},
							},
						},
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
				{ '', 'castle:hole_cobble', '' },
				{ '', 'unknown:node', '' },
				{ '', 'default:furnace', '' },
			}
		})
	end
}
