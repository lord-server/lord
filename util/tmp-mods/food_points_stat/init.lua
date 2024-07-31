
local function find_foods_points()
	local foods_points_lines = ""

	for name, node in pairs(minetest.registered_items) do
		if node._tt_food_hp then
			local description = minetest.get_translated_string('ru', node.description)
			description = description:split("\n")[1]
			local hb_value = hbhunger.food[name] and hbhunger.food[name].saturation or nil
			foods_points_lines = foods_points_lines ..
				name .. "\t" .. description .. "\t" .. node._tt_food_hp .. "\t" .. (hb_value or "-") .. "\n"
		end
	end

	return foods_points_lines
end

minetest.after(5, function()
	local filepath = minetest.get_worldpath() .. "/foods_points.txt"
	io.write_to_file(filepath, find_foods_points())
	print("Food points saved to: " .. filepath)
end)
