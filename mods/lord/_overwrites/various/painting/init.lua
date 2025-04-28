for _, dye in ipairs(dye.dyes) do
	local color = dye[1]
	local dye_item = "dye:"..color

	minetest.register_craft({
		output = "painting:brush_"..color,
		recipe = {
			{ dye_item, },
			{ "group:stick", },
			{ "group:stick" }
		}
	})

	-- TODO: remove after fixing sfence/painting#15 issue
	minetest.clear_craft({output = "painting"})

	minetest.register_craft{
		output = "painting:oil_color_"..color,
		recipe = {
			{ dye_item, },
			{ "lottfarming:vegetable_oil", },
			{ "vessels:drinking_glass", },
		},
		replacements = {{ "lottfarming:vegetable_oil", "vessels:glass_bottle", }},
	}
end

minetest.register_alias("painting:brush_darkgrey", "painting:brush_dark_grey")
minetest.register_alias("painting:brush_darkgreen", "painting:brush_dark_green")

minetest.unregister_item("painting:canvas_64")
