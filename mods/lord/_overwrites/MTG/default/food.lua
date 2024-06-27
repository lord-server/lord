
-- Add food points description:

local food_points = {
	["default:blueberries"] = 2,
	["default:apple"]       = 2,
	-- unregistered in our game:
	--["flowers:mushroom_red"] = -5,
	--["flowers:mushroom_brown"] = 1,
}

for item, points in pairs(food_points) do
	minetest.override_item(item, {
		_tt_food    = true,
		_tt_food_hp = points,
	})
end
