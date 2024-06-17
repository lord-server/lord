local S = require("lord_wooden_stuff.config").translator

---@param name_postfix string
---@param desc_prefix string
---@param wood_name string
---@param node_groups table<string,number>
local function register_reinforced_hatch(name_postfix, desc_prefix, wood_name, node_groups)
	local name = "lord_wooden_stuff:hatch_reinforced_" .. name_postfix
	local texture = "lord_wooden_stuff_hatch_reinforced_" .. name_postfix .. ".png"
	doors.register_trapdoor(name, {
		-- TODO: fix localization:
		description = string.format("Reinforced %s Hatch", desc_prefix),
		inventory_image = texture,
		wield_image = texture,
		tile_front = texture,
		tile_side = texture,
		groups = table.merge(node_groups, { hatch = 1, }),
	})

	minetest.register_craft({
		output = name,
		recipe = {
			{ "", "lottores:tin_ingot", "", },
			{ wood_name, wood_name, wood_name, },
			{ wood_name, wood_name, wood_name, },
		}
	})
end

return register_reinforced_hatch
