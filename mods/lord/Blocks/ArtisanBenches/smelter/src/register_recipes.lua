
local smelter_recipes = require('recipes')

local craft_methods = {
	core.CraftMethod.SMELTER_1,
	core.CraftMethod.SMELTER_2,
	core.CraftMethod.SMELTER_3,
}


for _, row in ipairs(smelter_recipes) do
	local min_level   = row[1]
	local smelter_in1 = row[2]
	local smelter_in2 = row[3]
	local smelter_out = row[4]
	local cook_time   = row[5]

	-- A higher-level smelter can smelt everything the lower levels could.
	for level = min_level, #craft_methods do
		local method = craft_methods[level]

		core.register_craft({
			method = method,
			type   = 'cooking',
			output = smelter_out,
			recipe = { smelter_in1 , smelter_in2 },
			time   = cook_time,
		})

		if smelter_in1 ~= smelter_in2 then
			core.register_craft({
				method = method,
				type   = 'cooking',
				output = smelter_out,
				recipe = { smelter_in2 , smelter_in1 },
				time   = cook_time,
			})
		end
	end
end
