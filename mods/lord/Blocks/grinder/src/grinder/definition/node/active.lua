local SL = minetest.get_mod_translator()

local common              = require('grinder.definition.node.common')
local inventory_callbacks = require('grinder.definition.node.inventory_callbacks')


--- @param width  number Width of a frame in pixels.
--- @param height number Height of a frame in pixels.
--- @param length number Full loop length.
local function animation_vf(width, height, length)
	return { type = "vertical_frames", aspect_w = width, aspect_h = height, length = length }
end

--- @param image  string image file name
--- @param width  number Width of a frame in pixels.
--- @param height number Height of a frame in pixels.
--- @param length number Full loop length.
local function animated_tile(image, width, height, length)
	return { image = image, backface_culling = false, animation = animation_vf(width, height, length) }
end


return table.merge(common, table.merge(inventory_callbacks, {
	description = SL("Grinder"),
	tiles = {
		animated_tile("grinder_top_active.png", 32, 32, 1.6),
		"grinder_bottom.png",
		animated_tile("grinder_side_left_active.png", 32, 32, 3.2),
		animated_tile("grinder_side_right_active.png", 32, 32, 3.2),
		animated_tile("grinder_side_active.png", 32, 32, 1.0),
		animated_tile("grinder_front_active.png", 32, 32, 1.0)
	},
	light_source = 8,
	groups = { not_in_creative_inventory = 1, hot = 1 },
}))
