local Default  = require('config')


--- @class sunshine.Api
local Api = {
    --- Array for managing volumetric light parameters.
    light = {},

    --- Array for managing bloom effect parameters.
    bloom = {},

    --- Array for setting up default Luanti light parameters.
    reset = {},
}
function Api.light.set_for(player, value)
    player:set_lighting({
        volumetric_light = { strength = value }
    })
end

--- Sets bloom effect parameters for a player.
--- @param i number intensity of the bloom effect.
--- @param s number strength factor of the bloom effect.
--- @param r number radius of the bloom effect.
function Api.bloom.set_for(player, i, s, r)
    player:set_lighting({
        bloom = {
            intensity = i,
            strength_factor = s,
            radius = r,
        },
    })
end

--- Resets lighting parameters for a player to Luanti's default values.
--- @param player object player for whom the lighting parameters are reset.
function Api.reset.set_for(player)
    player:set_lighting({
        shadows = Default.shadows,
        bloom = Default.bloom,
        volumetric_light = Default.volumetric_light,
    })
end

return Api
