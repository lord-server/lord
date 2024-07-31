
-- Add food points description:

local food_points = {
	["default:blueberries"] = 3,
	["default:apple"]       = 4,
	-- unregistered in our game:
	--["flowers:mushroom_red"] = -5,
	--["flowers:mushroom_brown"] = 1,
}

for item, points in pairs(food_points) do
	minetest.override_item(item, {
		on_use      = minetest.item_eat(points),
		_tt_food_hp = points,
	})
end
