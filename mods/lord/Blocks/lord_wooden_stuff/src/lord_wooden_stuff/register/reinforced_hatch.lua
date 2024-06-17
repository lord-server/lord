local S = require("lord_wooden_stuff.config").translator

---@param wood string
---@param def LordWoodenStuffDefinition
---@param groups table<string,number>
local function register_reinforced_hatch(wood, def, groups)
	local name = "lord_wooden_stuff:hatch_reinforced_" .. wood
	local texture = "lord_wooden_stuff_hatch_reinforced_" .. wood .. ".png"
	doors.register_trapdoor(name, {
		-- TODO: fix localization:
		description = string.format("Reinforced %s Hatch", def.desc),
		inventory_image = texture,
		wield_image = texture,
		tile_front = texture,
		tile_side = texture,
		groups = table.merge(groups, { hatch = 1, }),
	})

	minetest.register_craft({
		output = name,
		recipe = {
			{ "", "lottores:tin_ingot", "", },
			{ def.wood_name, def.wood_name, def.wood_name, },
			{ def.wood_name, def.wood_name, def.wood_name, },
		}
	})
end


return register_reinforced_hatch
