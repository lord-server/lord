
local smelter_recipes = require('recipes')

for _, row in ipairs(smelter_recipes) do
	local smelterin1 = row[1]
	local smelterin2 = row[2]
	local smelterout = row[3]
	local cooktime   = row[4]

	-- следует проверять наличие рецепта до его удаления
	minetest.clear_craft({
		type = 'cooking',
		output = smelterout,
		recipe = smelterin1,
	})

	minetest.register_craft({
		method = minetest.CraftMethod.SMELTER,
		type   = 'cooking',
		output = smelterout,
		recipe = { smelterin1 , smelterin2 },
		time   = cooktime,
	})

	if smelterin1 ~= smelterin2 then
		minetest.register_craft({
			method = minetest.CraftMethod.SMELTER,
			type   = 'cooking',
			output = smelterout,
			recipe = { smelterin2 , smelterin1 },
			time   = cooktime,
		})
	end
end
