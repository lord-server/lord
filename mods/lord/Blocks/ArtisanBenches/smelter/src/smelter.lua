local nodes_for = require('smelter.nodes')
local form_for  = require('smelter.nodes.Form')
local S         = core.get_mod_translator()
local colorize  = core.colorize
local grey      = '#aaa'


local function register_nodes()
	--- @type table<integer,string>
	local craft_methods = {
		core.CraftMethod.SMELTER_1,
		core.CraftMethod.SMELTER_2,
		core.CraftMethod.SMELTER_3,
	}

	for level, craft_method in ipairs(craft_methods) do
		fuel_device.register(
			S('Smelter') .. ' ' .. colorize(grey, S('(Level: @1)', level)),
			craft_method,
			{
				inactive = {
					node_name  = 'lord_smelter:smelter_' .. level,
					definition = table.merge(nodes_for(level), {
						tiles = {
							'lord_smelter_' .. level .. '_inactive.png',
							'lord_smelter_' .. level .. '_front_inactive_flame.png',
						},
					}),
				},
				active   = {
					node_name  = 'lord_smelter:smelter_' .. level .. '_active',
					definition = table.merge(nodes_for(level), {
						tiles = { 'lord_smelter_' .. level .. '_active.png', {
							name = 'lord_smelter_' .. level .. '_front_active_flame.png',
							animation = {
								type     = 'vertical_frames',
								aspect_w = 16,
								aspect_h = 16,
								length   = 2.0,
							},
						}, },
						light_source = 3,
						drop         = 'lord_smelter:smelter_' .. level,
						groups       = { not_in_creative_inventory = 1 },
						sound_device = { file = 'lord_smelter_1', parameters = { gain = 1 } },
						sound_output = { file = 'default_cool_lava', parameters = { gain = 0.1 } },
					}),
				}
			},
			form_for(level),
			{ src = 2, dst = 4 }
		)
	end
end

local function register_crafts()
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
	core.register_craft({
		output = 'lord_smelter:smelter_2',
		recipe = {
			{ 'lord_smelter:smelter_1', 'lord_smelter:crucible' },
		}
	})
	core.register_craft({
		output = 'lord_smelter:smelter_3',
		recipe = {
			{ 'lord_smelter:smelter_2', 'lord_smelter:hearth' },
		}
	})
end


return {
	--- @param mod core.Mod
	init = function(mod)
		core.CraftMethod.SMELTER_1 = 'smelter_1'
		core.CraftMethod.SMELTER_2 = 'smelter_2'
		core.CraftMethod.SMELTER_3 = 'smelter_3'
		core.register_craft_method(core.CraftMethod.SMELTER_1)
		core.register_craft_method(core.CraftMethod.SMELTER_2)
		core.register_craft_method(core.CraftMethod.SMELTER_3)

		register_nodes()
		register_crafts()
	end
}
