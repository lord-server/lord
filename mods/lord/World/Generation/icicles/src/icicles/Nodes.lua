--- @class icicles.Nodes
local Nodes = {}

function Nodes.register()
	for i = 1, 4 do
		minetest.register_node("icicles:icicle_" .. i, {
			description       = "Icicle " .. i,
			groups            = {
				cracky = 3, icicle = 1, oddly_breakable_by_hand = 4 - i, drop_on_dig = 1, attached_node = 1
			},
			tiles             = { "default_stone.png" },
			is_ground_content = true,
			sounds            = default.node_sound_stone_defaults(),
			drop              = {
				max_items = 1,
				items     = {
					{
						items  = { "default:cobble" },
						rarity = 5 - i,
					},
				},
			},
			drawtype          = "nodebox",
			paramtype         = "light",
			paramtype2        = "wallmounted",
			node_box          = {
				type  = "fixed",
				fixed = { -i / 10, -0.5, -i / 10, i / 10, 0.5, i / 10 }
			},
			selection_box     = {
				type  = "fixed",
				fixed = { -i / 10, -0.5, -i / 10, i / 10, 0.5, i / 10 }
			},
		})
	end
end


return Nodes
