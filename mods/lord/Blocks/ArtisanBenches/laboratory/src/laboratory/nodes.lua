local Form = require('laboratory.nodes.Form')
local S    = minetest.get_mod_translator()


local common_node_definition = {
	description     = S('Laboratory'),
	drawtype        = "plantlike",
	visual_scale    = 1.0,
	inventory_image = "benches_laboratory.png",
	wield_image     = "benches_laboratory.png",
	paramtype       = "light",
	selection_box   = {
		type  = "fixed",
		fixed = { -0.3, -0.5, -0.3, 0.3, 0.35, 0.3 }
	},
	groups          = { cracky = 2 },
	sounds          = default.node_sound_stone_defaults(),
}

fuel_device.register(
	S('Laboratory'),
	minetest.CraftMethod.POTION,
	{
		inactive = {
			node_name  = 'laboratory:laboratory',
			definition = table.merge(common_node_definition, {
				tiles = { "benches_laboratory.png" },
			}),
		},
		active   = {
			node_name  = 'laboratory:laboratory_active',
			definition = table.merge(common_node_definition, {
				tiles        = { "benches_laboratory_active.png" },
				light_source = 8,
				drop         = "laboratory:laboratory",
				groups       = { not_in_creative_inventory = 1 },
			}),
		}
	},
	Form,
	{ src = 2 }
)
