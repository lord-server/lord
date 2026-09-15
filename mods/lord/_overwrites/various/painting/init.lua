for _, dye in ipairs(dye.dyes) do
	local color = dye[1]
	local dye_item = "dye:"..color

	core.register_craft({
		output = "painting:brush_"..color,
		recipe = {
			{ dye_item, },
			{ "group:stick", },
			{ "group:stick" }
		}
	})

	-- Removing crafts with hemp oil that we don't have.
	core.clear_craft({output = "painting:oil_color_"..color})

	core.register_craft{
		output = "painting:oil_color_"..color,
		recipe = {
			{ dye_item, },
			{ "lottfarming:vegetable_oil", },
			{ "vessels:drinking_glass", },
		},
		replacements = {{ "lottfarming:vegetable_oil", "vessels:glass_bottle", }},
	}
end

core.register_alias("painting:brush_darkgrey", "painting:brush_dark_grey")
core.register_alias("painting:brush_darkgreen", "painting:brush_dark_green")

core.unregister_item("painting:canvas_64")
