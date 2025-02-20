

local function set_user_light(player, value)
	player:set_lighting({
		shadows = {},
		bloom = {},
		volumetric_light = { strength = value }
	})
end

return set_user_light