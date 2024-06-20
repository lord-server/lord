for _, dye in ipairs(dye.dyes) do
	local color = dye[1]
	minetest.register_craft({
		output = "painting:brush_"..color,
		recipe = {
			{"dye:"..color},
			{"group:stick"},
			{"group:stick"}
		}
	})
end

minetest.register_alias("painting:brush_darkgrey", "painting:brush_dark_grey")
minetest.register_alias("painting:brush_darkgreen", "painting:brush_dark_green")

minetest.unregister_item("painting:canvas_64")
