local S = require("lord_wooden_stuff.config").translator

--- @param name string
--- @param description_prefix string
--- @param wood_name string
local function register_stick(name, description_prefix, wood_name)
	local stick_reg_name = "lord_wooden_stuff:stick_" .. name
	minetest.register_craftitem(stick_reg_name, {
		description     = S(description_prefix .. " Stick"),
		inventory_image = "lord_wooden_stuff_stick_" .. name .. ".png",
		groups          = { stick = 1 },
	})
	minetest.register_craft({
		output = stick_reg_name .. " 4",
		recipe = {
			{ wood_name },
		}
	})
	return stick_reg_name
end

return register_stick
