local nodes = require('smelter.nodes')
local Form  = require('smelter.nodes.Form')
local S     = core.get_mod_translator()


return {
	--- @param mod core.Mod
	init = function(mod)
		core.CraftMethod.SMELTER = 'smelter'
		core.register_craft_method(core.CraftMethod.SMELTER)

		fuel_device.register(
			S('Smelter'),
			core.CraftMethod.SMELTER,
			{
				inactive = {
					node_name  = 'lord_smelter:smelter_1',
					definition = table.merge(nodes, {
						tiles = {
							'lord_smelter_1_inactive.png',
							'lord_smelter_1_front_inactive_flame.png',
						},
					}),
				},
				active   = {
					node_name  = 'lord_smelter:smelter_1_active',
					definition = table.merge(nodes, {
						tiles = { 'lord_smelter_1_active.png', {
							name = 'lord_smelter_1_front_active_flame.png',
							animation = {
								type     = 'vertical_frames',
								aspect_w = 16,
								aspect_h = 16,
								length   = 2.0,
							},
						}, },
						light_source = 3,
						drop         = 'lord_smelter:smelter_1',
						groups       = { not_in_creative_inventory = 1 },
						sound_device = { file = 'lord_smelter_1', parameters = { gain = 1 } },
						sound_output = { file = 'default_cool_lava', parameters = { gain = 0.1 } },
					}),
				}
			},
			Form,
			{ src = 2, dst = 4 }
		)

		core.register_craft({
			output = 'lord_smelter:smelter_1',
			recipe = {
				{ ''                    , 'castle:hole_cobble', ''                     },
				{ 'default:copper_ingot', 'castle:hole_cobble', 'default:copper_ingot' },
				{ 'lottores:tin_ingot'  , 'default:furnace'   , 'lottores:tin_ingot'   },
			}
		})
		core.register_craft({
			output = 'lord_smelter:smelter_1',
			recipe = {
				{ ''                    , 'castle:hole_cobble', ''                     },
				{ 'lottores:tin_ingot'  , 'castle:hole_cobble', 'lottores:tin_ingot'   },
				{ 'default:copper_ingot', 'default:furnace'   , 'default:copper_ingot' },
			}
		})
	end
}
