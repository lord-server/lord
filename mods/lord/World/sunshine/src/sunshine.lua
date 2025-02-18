require('commands')

local lighting_default = {
	shadows = { intensity = 0.33},
	bloom = { intensity = 0.05 },
	volumetric_light = { strength = 0.2 },
}


if minetest.settings:get_bool("enable_weather") == false then

	return
end

function user_light_set(player, value)
	player:set_lighting({
		shadows = { intensity = 0.5},
		bloom = { intensity = 0.05 },
		volumetric_light = { strength = value }
	})

	return
end

minetest.register_on_joinplayer(function(player)
	player:set_lighting(lighting_default)
end)
