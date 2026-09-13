
local smelter_recipes = require('recipes')


for _, row in ipairs(smelter_recipes) do
	local smelter_in1 = row[1]
	local smelter_in2 = row[2]
	local smelter_out = row[3]
	local cook_time   = row[4]

	core.register_craft({
		method = core.CraftMethod.SMELTER,
		type   = 'cooking',
		output = smelter_out,
		recipe = { smelter_in1 , smelter_in2 },
		time   = cook_time,
	})

	if smelter_in1 ~= smelter_in2 then
		core.register_craft({
			method = core.CraftMethod.SMELTER,
			type   = 'cooking',
			output = smelter_out,
			recipe = { smelter_in2 , smelter_in1 },
			time   = cook_time,
		})
	end
end
