
local function find_foods_points()
	local foods_points_lines = ""

	for key, value in pairs(minetest.registered_items) do
		if value._tt_food then
			local description = minetest.get_translated_string('ru', value.description)
			description = description:split("\n")[1]
			foods_points_lines = foods_points_lines .. key .. "\t" .. description .. "\t" .. value._tt_food_hp .. "\n"
		end
	end

	return foods_points_lines
end

minetest.after(5, function()
	local filepath = minetest.get_worldpath() .. "/foods_points.txt"
	io.write_to_file(filepath, find_foods_points())
	print("Food points saved to: " .. filepath)
end)
