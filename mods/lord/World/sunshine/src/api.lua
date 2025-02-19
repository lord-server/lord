

local function set_user_light(player, value)
	player:set_lighting({
		shadows = { intensity = 0.5},
		bloom = { intensity = 0.05 },
		volumetric_light = { strength = value }
	})
end

return set_user_light