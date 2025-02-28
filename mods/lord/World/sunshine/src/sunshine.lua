require('api')
require('commands')

local Default = require('config')


minetest.register_on_joinplayer(function(player)
	player:set_lighting({
        shadows = Default.shadows,
        bloom = Default.bloom,
        volumetric_light = Default.volumetric_light,
    })
end)
