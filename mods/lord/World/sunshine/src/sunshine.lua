require('api')
require('commands')

local default_lighting = {
	shadows = { intensity = 0.5},
	bloom = { intensity = 0.05 },
	volumetric_light = { strength = 0.2 }
}

minetest.register_on_joinplayer(function(player)
	player:set_lighting(default_lighting)
end)
