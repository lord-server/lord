local Form = require('smelter.nodes.Form')
local S    = minetest.get_mod_translator()


local common_node_definition = {
	description   = S('Smelter'),
	drawtype      = "mesh",
	mesh          = "smelter1.obj",
	visual_scale  = 0.5,
	paramtype     = "light",
	selection_box = {
		type  = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, 1.5, 0.5 }
	},
	collision_box = {
		type  = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
	},
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local top_pos = pos:above()
		local pos_above = minetest.get_node(top_pos)
		-- Проверяем, пусто ли на втором блоке сверху
		if pos_above.name == "air" then
			local fdir = minetest.get_node(pos).param2
			minetest.set_node(pos, {name = "smelter:smelter1", param2 = fdir})
		else
			minetest.remove_node(pos)
			return true
		end
	end,
	groups          = { cracky = 3 },
	sounds          = default.node_sound_stone_defaults(),
}

fuel_device.register(
	S('Smelter'),
	minetest.CraftMethod.SMELTER,
	{
		inactive = {
			node_name  = 'smelter:smelter1',
			definition = table.merge(common_node_definition, {
			tiles = {"smelter1_inactive.png"},
			}),
		},
		active   = {
			node_name  = 'smelter:smelter1_active',
			definition = table.merge(common_node_definition, {
				tiles = {"smelter1_active.png"},
				light_source = 3,
				drop         = "smelter:smelter1",
				groups       = { not_in_creative_inventory = 1 },
			}),
		}
	},
	Form,
	{ src = 2, dst = 4 }
)
