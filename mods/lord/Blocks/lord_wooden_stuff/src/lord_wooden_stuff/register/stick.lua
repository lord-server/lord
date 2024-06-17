local S = require("lord_wooden_stuff.config").translator

--- @param wood string
--- @param def LordWoodenStuffDefinition
--- @return string @stick item name
local function register_stick(wood, def, _, _)
	local name = "lord_wooden_stuff:stick_" .. wood
	minetest.register_craftitem(name, {
		description     = S(def.desc .. " Stick"),
		inventory_image = "lord_wooden_stuff_stick_" .. wood .. ".png",
		groups          = { stick = 1 },
	})
	minetest.register_craft({
		output = name .. " 4",
		recipe = {
			{ def.wood_name },
		}
	})
	return name
end


return register_stick
